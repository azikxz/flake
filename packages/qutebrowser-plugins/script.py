#!/usr/bin/env python3

"""
Qutebrowser userscript для автозаполнения паролей из rbw (Bitwarden CLI)

Установка: скопируйте в ~/.local/share/qutebrowser/userscripts/
Использование:
  :spawn --userscript rbw-autofill.py [username|password|totp|both]
  both - заполняет username и password (по умолчанию)
  totp - вводит TOTP код
"""

import json
import os
import re
import subprocess
import sys
from urllib.parse import urlparse

CMD_DELAY = 50


def cmd(command):
    """Отправляет команду в qutebrowser через FIFO"""
    with open(os.environ["QUTE_FIFO"], "w") as fifo:
        fifo.write(command + "\n")
        fifo.flush()


def msg(msg_type, message):
    """Отправляет сообщение в qutebrowser"""
    cmd('{} "{}"'.format(msg_type, message))


def unlock_rbw():
    """Разблокирует rbw используя встроенный интерфейс rbw unlock"""
    try:
        # rbw unlock имеет свой собственный интерфейс ввода пароля
        subprocess.run(["rbw", "unlock"], check=True)
        msg("message-info", "Bitwarden unlocked successfully")
        return True
    except subprocess.CalledProcessError:
        msg("message-error", "Failed to unlock Bitwarden")
        return False


def check_rbw_unlocked():
    """Проверяет, разблокирован ли rbw, и разблокирует при необходимости"""
    try:
        subprocess.run(["rbw", "unlocked"], check=True, capture_output=True)
        return True
    except subprocess.CalledProcessError:
        # rbw заблокирован - запускаем разблокировку
        msg("message-info", "Bitwarden is locked. Running rbw unlock...")
        return unlock_rbw()


def extract_domain(url):
    """Извлекает домен из URL"""
    parsed = urlparse(url)
    raw_domain = parsed.netloc

    raw_domain = re.sub(r"^www\.", "", raw_domain)

    if not raw_domain:
        return None, None

    parts = raw_domain.split(".")
    num_parts = len(parts)

    if num_parts < 2:
        return raw_domain, raw_domain

    last_two = ".".join(parts[-2:])
    if re.match(r"^(co|com|gov|ac|org|net)\.[a-z]{2}$", last_two) and num_parts >= 3:
        full_domain = ".".join(parts[-3:])
    else:
        full_domain = last_two

    base_domain = full_domain.split(".")[0]

    return full_domain, base_domain


def get_all_entries():
    """Получает все записи из rbw"""
    try:
        result = subprocess.run(
            ["rbw", "list"], capture_output=True, text=True, check=True
        )
        entries = [
            line.strip() for line in result.stdout.strip().split("\n") if line.strip()
        ]
        return entries
    except subprocess.CalledProcessError:
        return []


def get_entry_details(name):
    """Получает детали записи из rbw"""
    try:
        result = subprocess.run(
            ["rbw", "get", name, "--raw"], capture_output=True, text=True, check=True
        )
        return json.loads(result.stdout)
    except (subprocess.CalledProcessError, json.JSONDecodeError):
        return None


def get_totp_code(name):
    """Получает TOTP код для записи"""
    try:
        result = subprocess.run(
            ["rbw", "totp", name], capture_output=True, text=True, check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return None


def find_matching_entry(current_url):
    """Ищет подходящую запись для текущего URL"""
    full_domain, base_domain = extract_domain(current_url)

    if not full_domain:
        return None, None

    entries = get_all_entries()

    for entry_name in entries:
        entry = get_entry_details(entry_name)
        if not entry or "data" not in entry:
            continue

        uris = entry.get("data", {}).get("uris", [])
        for uri_obj in uris:
            uri = uri_obj.get("uri", "")
            entry_full_domain, _ = extract_domain(uri)

            if entry_full_domain == full_domain:
                return entry, full_domain

    if full_domain != base_domain:
        for entry_name in entries:
            entry = get_entry_details(entry_name)
            if not entry or "data" not in entry:
                continue

            uris = entry.get("data", {}).get("uris", [])
            for uri_obj in uris:
                uri = uri_obj.get("uri", "")
                entry_full_domain, entry_base_domain = extract_domain(uri)

                if entry_base_domain == base_domain or entry_full_domain == base_domain:
                    return entry, base_domain

    return None, None


def fill_credentials(username, password, fill_mode, search_term, entry_name):
    """Заполняет учётные данные через insert-text"""

    def text(content):
        cmd("insert-text {}".format(content))

    if fill_mode == "username":
        if username:
            msg("message-info", "Filling username: (matched: {})".format(search_term))
            text(username)
        else:
            msg(
                "message-error",
                "No username for this entry: (matched: {})".format(search_term),
            )

    elif fill_mode == "password":
        if password:
            msg("message-info", "Filling password: (matched: {})".format(search_term))
            text(password)
        else:
            msg(
                "message-error",
                "No password for this entry: (matched: {})".format(search_term),
            )

    elif fill_mode == "totp":
        totp_code = get_totp_code(entry_name)
        if totp_code:
            msg(
                "message-info",
                "TOTP code entered: {} (matched: {})".format(totp_code, search_term),
            )
            text(totp_code)
        else:
            msg(
                "message-error",
                "No TOTP for this entry: (matched: {})".format(search_term),
            )

    # both: username and password
    else:
        if username and password:
            msg(
                "message-info",
                "Filling username and password: (matched: {})".format(search_term),
            )
            cmd(
                "insert-text {} ;; cmd-later {} fake-key <Tab> ;; cmd-later {} insert-text {}".format(
                    username, CMD_DELAY, CMD_DELAY * 2, password
                )
            )
        else:
            msg(
                "message-error",
                "No login for this entry: (matched: {})".format(search_term),
            )


def main():
    fill_mode = sys.argv[1] if len(sys.argv) > 1 else "both"

    qute_url = os.environ.get("QUTE_URL")
    qute_fifo = os.environ.get("QUTE_FIFO")

    if not all([qute_url, qute_fifo]):
        msg("message-error", "Missing required qutebrowser environment variables")
        return 1

    if not check_rbw_unlocked():
        return 1

    entry, search_term = find_matching_entry(qute_url)

    if not entry:
        msg("message-error", "No matching entry found for this URL")
        return 1

    entry_name = entry.get("name", "")

    if fill_mode == "totp":
        fill_credentials(None, None, fill_mode, search_term, entry_name)
        return 0

    username = entry.get("data", {}).get("username", "")
    password = entry.get("data", {}).get("password", "")

    fill_credentials(username, password, fill_mode, search_term, entry_name)

    return 0


if __name__ == "__main__":
    sys.exit(main())

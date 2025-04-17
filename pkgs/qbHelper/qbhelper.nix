# python
''
  #! /usr/bin/env nix-shell
  #! nix-shell -i python3 -p python3Packages.requests

  """
      RuTracker to qBittorrent Downloader (Magnet-only version)
  """

  import argparse
  import requests
  from urllib.parse import urlparse, parse_qs

  # Конфигурация qBittorrent
  QBITTORRENT_URL = "http://localhost:8080"
  QBITTORRENT_USER = "admin"
  QBITTORRENT_PASS = "adminadmin"

  def get_magnet_from_rutracker(topic_id: int) -> str:
      """Получает magnet-ссылку с Rutracker по ID темы"""
      url = f"https://rutracker.org/forum/viewtopic.php?t={topic_id}"
      try:
          response = requests.get(
              url, 
              headers={
                  "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
                  "Accept-Language": "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"
              }
          )
          response.raise_for_status()
          
          # Улучшенный поиск magnet-ссылки
          for line in response.text.splitlines():
              if "magnet:?" in line and "href=" in line:
                  magnet = line.split('href="')[1].split('"')[0]
                  return magnet.replace("&amp;", "&")
          
          raise ValueError("Magnet-ссылка не найдена в HTML страницы")
      except Exception as e:
          print(f"🚨 Ошибка при получении magnet-ссылки: {str(e)}")
          return None

  def add_magnet_to_qbittorrent(magnet: str, 
                              save_path=None, 
                              category=None, 
                              paused=False,
                              qb_url=None,
                              qb_user=None,
                              qb_pass=None):
      """Добавляет magnet-ссылку в qBittorrent"""
      # Используем переданные параметры или глобальные значения
      url = qb_url or QBITTORRENT_URL
      user = qb_user or QBITTORRENT_USER
      passwd = qb_pass or QBITTORRENT_PASS
      
      session = requests.Session()
      
      # Авторизация
      try:
          login = session.post(
              f"{url}/api/v2/auth/login",
              data={"username": user, "password": passwd}
          )
          if login.text != "Ok.":
              raise ValueError("Неверный логин/пароль qBittorrent")
      except Exception as e:
          print(f"🚨 Ошибка подключения к qBittorrent: {str(e)}")
          return False

      # Подготовка данных
      add_url = f"{url}/api/v2/torrents/add"
      data = {"urls": magnet}

      if save_path:
          data['savepath'] = save_path
      if category:
          data['category'] = category
      if paused:
          data['paused'] = 'true'

      # Отправка
      try:
          response = session.post(add_url, data=data)
          if response.status_code == 200:
              print("✅ Торрент успешно добавлен в qBittorrent")
              return True
          else:
              print(f"🚨 Ошибка qBittorrent: {response.text}")
              return False
      finally:
          session.get(f"{url}/api/v2/auth/logout")

  def parse_rutracker_url(url: str) -> int:
      """Извлекает ID темы из URL Rutracker"""
      try:
          if url.isdigit():
              return int(url)
          
          parsed = urlparse(url)
          if 't=' in parsed.query:
              return int(parse_qs(parsed.query)['t'][0])
          elif '/t' in parsed.path:
              return int(parsed.path.split('/t')[-1].split('.')[0])
          raise ValueError("Не удалось извлечь ID темы")
      except Exception as e:
          print(f"🚨 Ошибка парсинга URL: {str(e)}")
          return None

  def main():
      parser = argparse.ArgumentParser(
          description="📥 RuTracker to qBittorrent Downloader (Magnet-only)",
          formatter_class=argparse.ArgumentDefaultsHelpFormatter
      )
      parser.add_argument(
          "topic",
          help="ID темы или URL страницы на Rutracker (например: 6673601 или https://rutracker.org/forum/viewtopic.php?t=6673601)"
      )
      parser.add_argument(
          "--url",
          default=QBITTORRENT_URL,
          help="URL qBittorrent Web UI"
      )
      parser.add_argument(
          "--user",
          default=QBITTORRENT_USER,
          help="Логин qBittorrent"
      )
      parser.add_argument(
          "--pass",
          dest="password",
          default=QBITTORRENT_PASS,
          help="Пароль qBittorrent"
      )
      parser.add_argument(
          "--save-path",
          help="Папка для загрузки"
      )
      parser.add_argument(
          "--category",
          help="Категория торрента"
      )
      parser.add_argument(
          "--paused",
          action="store_true",
          help="Добавить торрент в остановленном состоянии"
      )

      args = parser.parse_args()

      # Получаем ID темы
      topic_id = parse_rutracker_url(args.topic)
      if not topic_id:
          return

      print(f"🔍 Получаем magnet-ссылку для темы #{topic_id}...")
      magnet = get_magnet_from_rutracker(topic_id)
      
      if magnet:
          print("🔗 Найдена magnet-ссылка, добавляем в qBittorrent...")
          add_magnet_to_qbittorrent(
              magnet,
              save_path=args.save_path,
              category=args.category,
              paused=args.paused,
              qb_url=args.url,
              qb_user=args.user,
              qb_pass=args.password
          )
      else:
          print("❌ Не удалось получить magnet-ссылку. Возможные причины:")
          print("- Требуется авторизация на Rutracker")
          print("- Тема удалена или не существует")
          print("- Rutracker изменил структуру страницы")

  if __name__ == "__main__":
      main()
''

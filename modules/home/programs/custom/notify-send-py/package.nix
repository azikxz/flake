{
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonApplication {
  pname = "notify-send-py";
  version = "unstable-2021-05-12";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "phuhl";
    repo = "notify-send.py";
    rev = "0575c79f10d10892c41559dd3695346d16a8b184";
    hash = "sha256-+6hh2c+TWMYaAI2SCRZrrwIh8FhKpJthFL0o6QMsoSY=";
  };

  build-system = [
    python3.pkgs.flit-core
  ];

  dependencies = with python3.pkgs; [
    dbus-python
    pygobject
  ];

  pythonImportsCheck = [
    "notify_send_py"
  ];
}

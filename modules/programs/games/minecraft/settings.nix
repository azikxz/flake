{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

{
  General = {
    ApplicationTheme = "system";
    AutoCloseConsole = false;
    AutomaticJavaDownload = false;
    AutomaticJavaSwitch = false;
    CatOpacity = 100;
    CentralModsDir = "mods";
    CloseAfterLaunch = false;
    ConfigVersion = "1.2";
    ConsoleFont = config.stylix.fonts.monospace.name;
    ConsoleOverflowStop = true;
    DownloadsDir = "/home/nixzoid/Downloads";
    DownloadsDirWatchRecursive = false;
    EnableFeralGamemode = true;
    EnableMangoHud = config.hm.programs.mangohud.enable;
    IconTheme = "pe_light";
    IconsDir = "icons";
    IgnoreJavaCompatibility = false;
    IgnoreJavaWizard = true;
    InstSortMode = "Name";
    InstanceDir = "instances";
    JavaDir = "java";
    JavaPath = getExe pkgs.temurin-jre-bin;
    Language = "en_US";
    LastHostname = "jetpure";
    LaunchMaximized = false;
    MaxMemAlloc = if (machine == "pcRyazenka") then 16384 else 8192;
    MenuBarInsteadOfToolBar = true;
    MinMemAlloc = 512;
    ModDependenciesDisabled = false;
    ModMetadataDisabled = false;
    NumberOfConcurrentDownloads = 6;
    NumberOfConcurrentTasks = 10;
    NumberOfManualRetries = 1;
    OnlineFixes = true;
    PastebinType = 3;
    PermGen = 128;
    QuitAfterGameStop = false;
    RecordGameTime = true;
    RequestTimeout = 60;
    ShowConsole = false;
    ShowConsoleOnError = true;
    ShowGameTime = true;
    ShowGameTimeWithoutDays = false;
    ShowGlobalGameTime = true;
    SkinsDir = "skins";
    SkipModpackUpdatePrompt = false;
    StatusBarVisible = false;
    TechnicClientID = "";
    ToolbarsLocked = true;
    UseDiscreteGpu = false;
    UseNativeGLFW = false;
    UseNativeOpenAL = false;
    UseZink = false;
    UserAgentOverride = "";
    UserAskedAboutAutomaticJavaDownload = true;
  };
}

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
    ConsoleFont = config.stylix.fonts.sansSerif.name;
    ConsoleFontSize = config.stylix.fonts.sizes.terminal;
    ConsoleOverflowStop = true;
    DownloadsDir = config.hm.xdg.userDirs.download;
    DownloadsDirWatchRecursive = false;
    EnableFeralGamemode = config.programs.gamemode.enable;
    EnableMangoHud = config.hm.programs.mangohud.enable;
    IconTheme = "pe_light";
    IconsDir = "icons";
    IgnoreJavaCompatibility = false;
    IgnoreJavaWizard = true;
    InstSortMode = "Name";
    InstanceDir = "instances";
    JavaDir = "java";
    JavaPath = getExe pkgs.temurin-jre-bin;
    Language = builtins.head (builtins.split "\\." config.i18n.defaultLocale);
    LastHostname = machine;
    LaunchMaximized = false;
    MaxMemAlloc = if (mac "pcRyazenka") then 16384 else 8192;
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

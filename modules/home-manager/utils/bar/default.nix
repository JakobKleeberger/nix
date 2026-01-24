{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = ../../../nixos/utils/stylix/wallpapers/mountains.jpg;
      wallpapers = {
        "DP-1" = ../../../nixos/utils/stylix/wallpapers/mountains.jpg;
      };
    };
  };

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "compact";
        position = "top";
        floating = true;
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "index";
            }
          ];
          center = [ ];
          right = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              alwaysShowPercentage = true;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/drfoobar/.face";
        radiusRatio = 0.2;
      };
      appLauncher = {
        terminalCommand = "ghostty -e";
        viewMode = "grid";
        showCategories = false;
      };
      location = {
        name = "Bonn";
        weatherEnabled = true;
        weatherShowEffects = true;
        showWeekNumberInCalendar = true;
        showCalendarEvents = true;
        showCalendarWeather = false;
        monthBeforeDay = true;
        firstDayOfTheWeek = 0;
      };
      wallpaper = {
        enabled = true;
        directory = ../../../nixos/utils/stylix/wallpapers;
        setWallpapersOnAllMonitors = true;
      };
    };
  };
}

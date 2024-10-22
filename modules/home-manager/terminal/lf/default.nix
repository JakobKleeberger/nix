{...}: {
  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;
    commands = {
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
             ''${{
        printf "Directory Name: "
        read DIR
        mkdir -p DIR
             }}
      '';
    };

    keybindings = {
      "\\\"" = "";
      o = "";
      d = "mkdir";
      "." = "set hidden!";
      "<enter>" = "open";

      "g~" = "cd";
      gh = "cd";
      "g/" = "cd /";

      ee = "editor-open";
    };

    settings = {
      # preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
  };
}

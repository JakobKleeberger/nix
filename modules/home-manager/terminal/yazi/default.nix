{pkgs, ...}: {
  home.packages = [
    pkgs.yazi
  ];
  programs.yazi = {
    enable = true;

    settings = {
      manager = {
        linemode = "relative";
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };
}

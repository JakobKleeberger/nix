{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/nixos/utils/stylix/stylix-home.nix
    ../../modules/home-manager/terminal
    ../../modules/home-manager/utils
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    teams-for-linux
    spotify
    onlyoffice-desktopeditors
    jetbrains.idea
    thunderbird
    brave
    kdePackages.dolphin
    prismlauncher

    inputs.nvim.packages.x86_64-linux.default

    tree
    pkgs.texlive.combined.scheme-full
  ];

  home.file = {
    ".config/hypr".source = ../../dotfiles/hypr;
    ".config/waybar".source = ../../dotfiles/waybar;
    "~/".source = ../../dotfiles/idea;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    settings.user.name = "JakobKleeberger";
    settings.user.email = "kleeberger.jakob@aol.com";
    lfs.enable = true;
  };

  programs.bash.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

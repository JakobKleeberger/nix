{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ../../modules/home-manager/terminal
    ../../modules/nixos/util/stylix/stylix-home.nix
    ../../modules/home-manager/terminal
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    ripgrep
    # Microsoft Teams
    teams-for-linux
    # Doom
    doomrunner
    # Dia
    dia
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

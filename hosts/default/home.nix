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
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nixvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

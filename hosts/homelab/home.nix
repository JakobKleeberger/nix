{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ../../modules/nixos/util/stylix/stylix-home.nix
    ../../modules/home-manager/terminal
  ];

  home.username = "homelab";
  home.homeDirectory = "/home/homelab";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    ripgrep
    # Power Manager
    powertop
    compose2nix
  ];

  home.file = { };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # programs.bash.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    # ../../modules/home-manager/terminal
    ../../modules/nixos/util/stylix/stylix-home.nix
    ../../modules/home-manager/terminal
  ];

  home.username = "jakob";
  home.homeDirectory = "/home/jakob";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ripgrep
    # Microsoft Teams
    teams-for-linux
    # Spotify
    spotify
    # Ressource Monitor
    bottom
    # Keepass
    keepassxc
    
    vmware-workstation

    inputs.nvim.packages.x86_64-linux.default
  ];

  home.file = {
    ".config/hypr".source = ../../dotfiles/hypr;
    ".config/waybar".source = ../../dotfiles/waybar;
    "Pictures/wallpapers".source = ../../modules/nixos/util/stylix/wallpapers;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.bash.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

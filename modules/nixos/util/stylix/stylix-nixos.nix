{ pkgs, ... }: {
  stylix.enable = true;

  stylix.image = ./wallpapers/mountains.jpg;
  stylix.opacity.terminal = 0.8;

  stylix.polarity = "dark";

  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/pinky.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/vice.yaml";

  stylix.homeManagerIntegration.autoImport = true;
  stylix.homeManagerIntegration.followSystem = true;

  # stylix.targets.nixvim.enable = false;

  stylix.fonts = {
    serif = {
      package = pkgs.nerd-fonts.noto;
      name = "Noto";
    };

    sansSerif = {
      package = pkgs.nerd-fonts.noto;
      name = "Noto";
    };

    monospace = {
      package = pkgs.nerd-fonts.noto;
      name = "Noto";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };

    sizes = {
      applications = 12;
      desktop = 10;
      popups = 10;
      terminal = 14;
    };
  };
}

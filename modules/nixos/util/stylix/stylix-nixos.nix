{pkgs, ...}: {
  stylix.enable = true;

  stylix.image = ./wallpapers/starry-sky-purple-sky-astronomical-stars-5k-3840x2160-1022.jpg;
  stylix.opacity.terminal = 0.8;

  stylix.polarity = "dark";

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/vice.yaml";

  stylix.homeManagerIntegration.autoImport = true;
  stylix.homeManagerIntegration.followSystem = true;

  # stylix.targets.nixvim.enable = false;

  stylix.fonts = {
    serif = {
      package = pkgs.nerdfonts.override {fonts = ["Noto"];};
      name = "Noto";
    };

    sansSerif = {
      package = pkgs.nerdfonts.override {fonts = ["Noto"];};
      name = "Noto";
    };

    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["Noto"];};
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

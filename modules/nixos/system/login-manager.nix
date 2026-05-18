{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd start-hyprland";
        user = "jakob";
      };
      default_session = initial_session;
    };
  };
}

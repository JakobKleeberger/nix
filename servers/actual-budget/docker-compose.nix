# Auto-generated using compose2nix v0.2.3.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."actualbudget-actual_server" = {
    image = "docker.io/actualbudget/actual-server:latest";
    volumes = [
      "/home/homelab/.nix/servers/actual-budget/actual-data:/data:rw"
    ];
    ports = [
      "5006:5006/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=actual_server"
      "--network=actualbudget_default"
    ];
  };
  systemd.services."docker-actualbudget-actual_server" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-actualbudget_default.service"
    ];
    requires = [
      "docker-network-actualbudget_default.service"
    ];
    partOf = [
      "docker-compose-actualbudget-root.target"
    ];
    wantedBy = [
      "docker-compose-actualbudget-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-actualbudget_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f actualbudget_default";
    };
    script = ''
      docker network inspect actualbudget_default || docker network create actualbudget_default
    '';
    partOf = [ "docker-compose-actualbudget-root.target" ];
    wantedBy = [ "docker-compose-actualbudget-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-actualbudget-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

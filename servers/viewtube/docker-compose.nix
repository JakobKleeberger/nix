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
  virtualisation.oci-containers.containers."viewtube-viewtube" = {
    image = "mauriceo/viewtube:latest";
    environment = {
      "VIEWTUBE_DATABASE_HOST" = "viewtube-mongodb";
      "VIEWTUBE_REDIS_HOST" = "viewtube-redis";
    };
    volumes = [
      "/home/homelab/.nix/servers/viewtube/data/viewtube:/data:rw"
    ];
    ports = [
      "8066:8066/tcp"
    ];
    dependsOn = [
      "viewtube-viewtube-mongodb"
      "viewtube-viewtube-redis"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=viewtube"
      "--network=viewtube_viewtube"
    ];
  };
  systemd.services."docker-viewtube-viewtube" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-viewtube_viewtube.service"
    ];
    requires = [
      "docker-network-viewtube_viewtube.service"
    ];
    partOf = [
      "docker-compose-viewtube-root.target"
    ];
    wantedBy = [
      "docker-compose-viewtube-root.target"
    ];
  };
  virtualisation.oci-containers.containers."viewtube-viewtube-mongodb" = {
    image = "mongo:7";
    volumes = [
      "/home/homelab/.nix/servers/viewtube/data/db:/data/db:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=viewtube-mongodb"
      "--network=viewtube_viewtube"
    ];
  };
  systemd.services."docker-viewtube-viewtube-mongodb" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-viewtube_viewtube.service"
    ];
    requires = [
      "docker-network-viewtube_viewtube.service"
    ];
    partOf = [
      "docker-compose-viewtube-root.target"
    ];
    wantedBy = [
      "docker-compose-viewtube-root.target"
    ];
  };
  virtualisation.oci-containers.containers."viewtube-viewtube-redis" = {
    image = "redis:7";
    volumes = [
      "/home/homelab/.nix/servers/viewtube/data/redis:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=viewtube-redis"
      "--network=viewtube_viewtube"
    ];
  };
  systemd.services."docker-viewtube-viewtube-redis" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-viewtube_viewtube.service"
    ];
    requires = [
      "docker-network-viewtube_viewtube.service"
    ];
    partOf = [
      "docker-compose-viewtube-root.target"
    ];
    wantedBy = [
      "docker-compose-viewtube-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-viewtube_viewtube" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f viewtube_viewtube";
    };
    script = ''
      docker network inspect viewtube_viewtube || docker network create viewtube_viewtube
    '';
    partOf = [ "docker-compose-viewtube-root.target" ];
    wantedBy = [ "docker-compose-viewtube-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-viewtube-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

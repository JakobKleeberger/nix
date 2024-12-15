# Auto-generated using compose2nix v0.2.3.
{ pkgs
, lib
, ...
}: {
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."paperless-broker" = {
    image = "docker.io/library/redis:7";
    volumes = [
      "paperless_redisdata:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=broker"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-broker" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-paperless_default.service"
      "docker-volume-paperless_redisdata.service"
    ];
    requires = [
      "docker-network-paperless_default.service"
      "docker-volume-paperless_redisdata.service"
    ];
    partOf = [
      "docker-compose-paperless-root.target"
    ];
    wantedBy = [
      "docker-compose-paperless-root.target"
    ];
  };
  virtualisation.oci-containers.containers."paperless-db" = {
    image = "docker.io/library/mariadb:11";
    environment = {
      "MARIADB_DATABASE" = "paperless";
      "MARIADB_HOST" = "paperless";
      "MARIADB_PASSWORD" = "paperless";
      "MARIADB_ROOT_PASSWORD" = "paperless";
      "MARIADB_USER" = "paperless";
    };
    volumes = [
      "paperless_dbdata:/var/lib/mysql:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=db"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-db" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-paperless_default.service"
      "docker-volume-paperless_dbdata.service"
    ];
    requires = [
      "docker-network-paperless_default.service"
      "docker-volume-paperless_dbdata.service"
    ];
    partOf = [
      "docker-compose-paperless-root.target"
    ];
    wantedBy = [
      "docker-compose-paperless-root.target"
    ];
  };
  virtualisation.oci-containers.containers."paperless-gotenberg" = {
    image = "docker.io/gotenberg/gotenberg:8.7";
    cmd = [ "gotenberg" "--chromium-disable-javascript=true" "--chromium-allow-list=file:///tmp/.*" ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=gotenberg"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-gotenberg" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-paperless_default.service"
    ];
    requires = [
      "docker-network-paperless_default.service"
    ];
    partOf = [
      "docker-compose-paperless-root.target"
    ];
    wantedBy = [
      "docker-compose-paperless-root.target"
    ];
  };
  virtualisation.oci-containers.containers."paperless-tika" = {
    image = "docker.io/apache/tika:latest";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=tika"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-tika" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-paperless_default.service"
    ];
    requires = [
      "docker-network-paperless_default.service"
    ];
    partOf = [
      "docker-compose-paperless-root.target"
    ];
    wantedBy = [
      "docker-compose-paperless-root.target"
    ];
  };
  virtualisation.oci-containers.containers."paperless-webserver" = {
    image = "ghcr.io/paperless-ngx/paperless-ngx:latest";
    environment = {
      "PAPERLESS_DBENGINE" = "mariadb";
      "PAPERLESS_DBHOST" = "db";
      "PAPERLESS_DBPASS" = "paperless";
      "PAPERLESS_DBPORT" = "3306";
      "PAPERLESS_DBUSER" = "paperless";
      "PAPERLESS_REDIS" = "redis://broker:6379";
      "PAPERLESS_TIKA_ENABLED" = "1";
      "PAPERLESS_TIKA_ENDPOINT" = "http://tika:9998";
      "PAPERLESS_TIKA_GOTENBERG_ENDPOINT" = "http://gotenberg:3000";
    };
    volumes = [
      "/home/homelab/.nix/servers/paperless/consume:/usr/src/paperless/consume:rw"
      "/home/homelab/.nix/servers/paperless/export:/usr/src/paperless/export:rw"
      "paperless_data:/usr/src/paperless/data:rw"
      "paperless_media:/usr/src/paperless/media:rw"
    ];
    ports = [
      "8010:8000/tcp"
    ];
    dependsOn = [
      "paperless-broker"
      "paperless-db"
      "paperless-gotenberg"
      "paperless-tika"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=webserver"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-webserver" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [
      "docker-network-paperless_default.service"
      "docker-volume-paperless_data.service"
      "docker-volume-paperless_media.service"
    ];
    requires = [
      "docker-network-paperless_default.service"
      "docker-volume-paperless_data.service"
      "docker-volume-paperless_media.service"
    ];
    partOf = [
      "docker-compose-paperless-root.target"
    ];
    wantedBy = [
      "docker-compose-paperless-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-paperless_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f paperless_default";
    };
    script = ''
      docker network inspect paperless_default || docker network create paperless_default
    '';
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };

  # Volumes
  systemd.services."docker-volume-paperless_data" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect paperless_data || docker volume create paperless_data
    '';
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };
  systemd.services."docker-volume-paperless_dbdata" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect paperless_dbdata || docker volume create paperless_dbdata
    '';
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };
  systemd.services."docker-volume-paperless_media" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect paperless_media || docker volume create paperless_media
    '';
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };
  systemd.services."docker-volume-paperless_redisdata" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect paperless_redisdata || docker volume create paperless_redisdata
    '';
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-paperless-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

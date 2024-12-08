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
  virtualisation.oci-containers.containers."gf-postgres" = {
    image = "docker.io/library/postgres:15";
    environment = {
      "ACCESS_TOKEN_SALT" = "asdfjpoadioasfjdüoasfdüoajdf";
      "COMPOSE_PROJECT_NAME" = "ghostfolio";
      "DATABASE_URL" = "postgresql://postgres:postgres@localhost:5432/ghostfolio-db?connect_timeout=300&sslmode=prefer";
      "JWT_SECRET_KEY" = "adfajsodfjasopdfhasodfj";
      "POSTGRES_DB" = "ghostfolio-db";
      "POSTGRES_PASSWORD" = "postgres";
      "POSTGRES_USER" = "postgres";
      "REDIS_HOST" = "localhost";
      "REDIS_PASSWORD" = "homelab";
      "REDIS_PORT" = "6379";
    };
    volumes = [
      "ghostfolio_postgres:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cap-add=CHOWN"
      "--cap-add=DAC_READ_SEARCH"
      "--cap-add=FOWNER"
      "--cap-add=SETGID"
      "--cap-add=SETUID"
      "--cap-drop=ALL"
      "--health-cmd=pg_isready -d \${POSTGRES_DB} -U \${POSTGRES_USER}"
      "--health-interval=10s"
      "--health-retries=5"
      "--health-timeout=5s"
      "--network-alias=postgres"
      "--network=ghostfolio_default"
      "--security-opt=no-new-privileges:true"
    ];
  };
  systemd.services."docker-gf-postgres" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "no";
    };
    after = [
      "docker-network-ghostfolio_default.service"
      "docker-volume-ghostfolio_postgres.service"
    ];
    requires = [
      "docker-network-ghostfolio_default.service"
      "docker-volume-ghostfolio_postgres.service"
    ];
    partOf = [
      "docker-compose-ghostfolio-root.target"
    ];
    wantedBy = [
      "docker-compose-ghostfolio-root.target"
    ];
  };
  virtualisation.oci-containers.containers."gf-redis" = {
    image = "docker.io/library/redis:alpine";
    environment = {
      "ACCESS_TOKEN_SALT" = "asdfjpoadioasfjdüoasfdüoajdf";
      "COMPOSE_PROJECT_NAME" = "ghostfolio";
      "DATABASE_URL" = "postgresql://postgres:postgres@localhost:5432/ghostfolio-db?connect_timeout=300&sslmode=prefer";
      "JWT_SECRET_KEY" = "adfajsodfjasopdfhasodfj";
      "POSTGRES_DB" = "ghostfolio-db";
      "POSTGRES_PASSWORD" = "postgres";
      "POSTGRES_USER" = "postgres";
      "REDIS_HOST" = "localhost";
      "REDIS_PASSWORD" = "homelab";
      "REDIS_PORT" = "6379";
    };
    cmd = [ "redis-server" "--requirepass" "" ];
    user = "999:1000";
    log-driver = "journald";
    extraOptions = [
      "--cap-drop=ALL"
      "--health-cmd=redis-cli --pass \"\" ping | grep PONG"
      "--health-interval=10s"
      "--health-retries=5"
      "--health-timeout=5s"
      "--network-alias=redis"
      "--network=ghostfolio_default"
      "--security-opt=no-new-privileges:true"
    ];
  };
  systemd.services."docker-gf-redis" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "no";
    };
    after = [
      "docker-network-ghostfolio_default.service"
    ];
    requires = [
      "docker-network-ghostfolio_default.service"
    ];
    partOf = [
      "docker-compose-ghostfolio-root.target"
    ];
    wantedBy = [
      "docker-compose-ghostfolio-root.target"
    ];
  };
  virtualisation.oci-containers.containers."ghostfolio" = {
    image = "docker.io/ghostfolio/ghostfolio:latest";
    environment = {
      "ACCESS_TOKEN_SALT" = "asdfjpoadioasfjdüoasfdüoajdf";
      "COMPOSE_PROJECT_NAME" = "ghostfolio";
      "DATABASE_URL" = "postgresql://:@postgres:5432/?connect_timeout=300&sslmode=prefer";
      "JWT_SECRET_KEY" = "adfajsodfjasopdfhasodfj";
      "POSTGRES_DB" = "ghostfolio-db";
      "POSTGRES_PASSWORD" = "postgres";
      "POSTGRES_USER" = "postgres";
      "REDIS_HOST" = "redis";
      "REDIS_PASSWORD" = "";
      "REDIS_PORT" = "6379";
    };
    ports = [
      "3333:3333/tcp"
    ];
    dependsOn = [
      "gf-postgres"
      "gf-redis"
    ];
    log-driver = "journald";
    extraOptions = [
      "--cap-drop=ALL"
      "--health-cmd=curl -f http://localhost:3333/api/v1/health"
      "--health-interval=10s"
      "--health-retries=5"
      "--health-timeout=5s"
      "--network-alias=ghostfolio"
      "--network=ghostfolio_default"
      "--security-opt=no-new-privileges:true"
    ];
  };
  systemd.services."docker-ghostfolio" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "no";
    };
    after = [
      "docker-network-ghostfolio_default.service"
    ];
    requires = [
      "docker-network-ghostfolio_default.service"
    ];
    partOf = [
      "docker-compose-ghostfolio-root.target"
    ];
    wantedBy = [
      "docker-compose-ghostfolio-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-ghostfolio_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f ghostfolio_default";
    };
    script = ''
      docker network inspect ghostfolio_default || docker network create ghostfolio_default
    '';
    partOf = [ "docker-compose-ghostfolio-root.target" ];
    wantedBy = [ "docker-compose-ghostfolio-root.target" ];
  };

  # Volumes
  systemd.services."docker-volume-ghostfolio_postgres" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect ghostfolio_postgres || docker volume create ghostfolio_postgres
    '';
    partOf = [ "docker-compose-ghostfolio-root.target" ];
    wantedBy = [ "docker-compose-ghostfolio-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-ghostfolio-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

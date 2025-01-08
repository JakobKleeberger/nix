{ pkgs, ... }: {
  virtualisation.docker.enable = true;

  systemd.services.postgres-docker = {
    description = "PostgreSQL Docker Container";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = ''
        docker run --rm \
          --name postgres-container \
          -e POSTGRES_USER=postgres \
          -e POSTGRES_PASSWORD=postgres \
          -e POSTGRES_DB=sednatrunk \
          -v /var/lib/postgres/data:/var/lib/postgresql/data \
          -p 5432:5432 \
          postgres:latest
      '';
      ExecStop = ''
        docker stop postgres-container
      '';
    };

    wantedBy = [ "multi-user.target" ];
  };

  # Ensure the data directory exists and is writable
  environment.etc."postgres-data".source = "/var/lib/postgres/data";
  environment.systemPackages = [ pkgs.docker ];
}

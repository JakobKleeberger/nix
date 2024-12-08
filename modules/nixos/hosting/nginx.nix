{ ... }: {
  services.nginx = {
    enable = true;
    virtualHosts."kleeberger.de" = {
      addSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "localhost:8081";
        proxyWebsockets = true;
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "kleeberger.jakob@aol.com";
  };
}

{
  flake.modules.nixos.ai = { ... }: {
    services.open-webui = {
      enable = true;
      host = "0.0.0.0";
      openFirewall = true;
    };
  };
}

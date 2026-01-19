{config, ...}: {
  flake.modules.nixos.core = {pkgs, ...}: let
    toggle-vpn = pkgs.writeShellApplication {
      name = "toggle-vpn";
      runtimeInputs = [pkgs.jq];
      text = builtins.readFile ./toggle-vpn.sh;
    };

    mullvad-wrapped = pkgs.symlinkJoin {
      name = "mullvad-gui-wrapped";
      paths = [pkgs.mullvad-vpn];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/mullvad-gui \
          --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib
      '';
    };
  in {
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    users.users.${config.meta.username} = {
      extraGroups = ["networkmanager"];
    };

    services.mullvad-vpn = {
      enable = true;
      package = mullvad-wrapped;
    };

    environment.systemPackages = [toggle-vpn];

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}

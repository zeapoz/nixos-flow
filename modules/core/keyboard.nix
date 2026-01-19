{
  flake.modules.nixos.core = {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "esc";
              esc = "capslock";

              # Map copilot key to right meta.
              "leftmeta+leftshift+f23" = "rightmeta";
            };
          };
        };
      };
    };

    # https://github.com/rvaiya/keyd/issues/66#issuecomment-985983524
    environment.etc."libinput/local-overrides.quirks".text = ''
      [Serial Keyboards]
      MatchUdevType=keyboard
      MatchName=keyd virtual keyboard
      AttrKeyboardIntegration=internal
    '';
  };
}

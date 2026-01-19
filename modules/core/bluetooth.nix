{
  flake.modules.nixos.core = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
  };
}

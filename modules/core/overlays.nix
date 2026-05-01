{
  flake.modules.nixos.core = _: {
    nixpkgs.overlays = [
      (final: prev: {
        openldap = prev.openldap.overrideAttrs (old: {
          doCheck = false;
        });
      })
    ];
  };
}
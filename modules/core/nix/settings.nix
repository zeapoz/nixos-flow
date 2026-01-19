{
  flake.modules.nixos.core = {
    nix = {
      settings.substituters = ["https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"];
      settings.experimental-features = ["nix-command" "flakes"];
    };

    nixpkgs.config.allowUnfree = true;
  };
}

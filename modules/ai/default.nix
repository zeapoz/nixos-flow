{
  flake.modules.nixos.ai = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      opencode
      wtype # Handy dependency
    ];

    programs.handy.enable = true;

    services.ollama = {
      enable = true;
      # ROCm segfaults, known issue: https://github.com/ROCm/ROCm/issues/5853
      # package = pkgs.ollama-rocm;
      package = pkgs.ollama-vulkan;
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = toString (128 * 1024);
      };
    };
  };
}

{
  flake.modules.nixos.ai = {pkgs, ...}: {
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

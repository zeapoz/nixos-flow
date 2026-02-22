{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      opencode
    ];

    services.ollama = {
      enable = true;
      # ROCm segfaults, known issue: https://github.com/ROCm/ROCm/issues/5853
      # package = pkgs.ollama-rocm;
      package = pkgs.ollama-vulkan;
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = builtins.toString (128 * 1024);
      };
    };

    services.open-webui.enable = true;
  };
}

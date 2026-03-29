_: {
  perSystem = {pkgs, ...}: {
    packages.voice-dictation = pkgs.writeShellApplication {
      name = "voice-dictation";
      runtimeInputs = with pkgs; [
        whisper-cpp-vulkan
        wl-clipboard
        libnotify
      ];
      text = builtins.readFile ./voice-dictation.sh;
    };
  };

  flake.modules.nixos.ai = {
    packages,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs;
      [
        whisper-cpp-vulkan
        opencode
      ]
      ++ [packages.voice-dictation];

    services.ollama = {
      enable = true;
      # ROCm segfaults, known issue: https://github.com/ROCm/ROCm/issues/5853
      # package = pkgs.ollama-rocm;
      package = pkgs.ollama-vulkan;
      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = toString (128 * 1024);
      };
    };

    services.open-webui.enable = true;
  };
}

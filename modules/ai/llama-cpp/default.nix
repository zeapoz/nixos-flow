{
  flake.modules.nixos.ai = {pkgs, ...}: let
    host = "0.0.0.0";
    port = 11434;
    contextSize = 131072;

    llama-wrapped = pkgs.runCommand "llama-cpp-rocm-wrapped" {
      nativeBuildInputs = [pkgs.makeWrapper];
    } ''
      mkdir -p $out/bin
      for bin in ${pkgs.llama-cpp-rocm}/bin/*; do
        name=$(basename "$bin")
        makeWrapper "$bin" "$out/bin/$name" --set GGML_CUDA_ENABLE_UNIFIED_MEMORY 1
      done
    '';

    llama-get-model = pkgs.writeShellScriptBin "llama-get-model" ''
      set -euo pipefail
      MODELS_DIR="/var/lib/llama-cpp"
      if [ $# -lt 2 ]; then
        echo "Usage: llama-get-model <hf-repo> <filename>"
        echo ""
        echo "  Set HF_TOKEN env var for gated models."
        echo ""
        echo "Examples:"
        echo "  llama-get-model ggml-org/Qwen3.6-35B-A3B-GGUF Qwen3.6-35B-A3B-Q4_K_M.gguf"
        echo "  HF_TOKEN=hf_xxx llama-get-model Qwen/Qwen3.6-35B-A3B-GGUF Qwen3.6-35B-A3B-Q4_K_M.gguf"
        exit 1
      fi
      REPO="$1"
      FILE="$2"
      URL="https://huggingface.co/$REPO/resolve/main/$FILE"
      echo "Downloading $REPO/$FILE to $MODELS_DIR/..."
      ${pkgs.curl}/bin/curl -fSL -o "$MODELS_DIR/$FILE" \
        ''${HF_TOKEN:+-H "Authorization: Bearer $HF_TOKEN"} \
        "$URL"
      chown llama-cpp:llama-cpp "$MODELS_DIR/$FILE"
      echo "Done: $MODELS_DIR/$FILE"
    '';
  in {
    environment.systemPackages = [llama-wrapped llama-get-model];

    users.users.llama-cpp = {
      isSystemUser = true;
      group = "llama-cpp";
      description = "llama.cpp server user";
    };

    users.groups.llama-cpp = {};

    systemd.tmpfiles.settings."llama-cpp-models" = {
      "/var/lib/llama-cpp".d = {
        mode = "0755";
        user = "llama-cpp";
        group = "llama-cpp";
      };
    };

    systemd.services.llama-server = {
      description = "llama.cpp server";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${llama-wrapped}/bin/llama-server --host ${host} --port ${toString port} --models-dir /var/lib/llama-cpp --ctx-size ${toString contextSize} --gpu-layers all --flash-attn auto";
        Restart = "on-failure";
        RestartSec = "5";
        StateDirectory = "llama-cpp";
        StateDirectoryMode = "0755";
        WorkingDirectory = "/var/lib/llama-cpp";
        User = "llama-cpp";
        Group = "llama-cpp";
      };
    };
  };
}

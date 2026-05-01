{
  flake.modules.nixos.dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      git
      gh
    ];
  };

  flake.modules.homeManager.dev = {config, ...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "zeapoz";
          email = "zeapo@pm.me";
          signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        };

        init.defaultBranch = "main";

        commit.gpgsign = true;
        tag.gpgsign = true;
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
        };
      };
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "zeapoz";
          email = "zeapo@pm.me";
        };
        signing = {
          backend = "ssh";
          behavior = "own";
          key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        };
        signing.backends.ssh.allowed-signers = "${config.home.homeDirectory}/.ssh/allowed_signers";
        git.sign-on-push = true;
      };
    };

    programs.lazygit.enable = true;
  };
}

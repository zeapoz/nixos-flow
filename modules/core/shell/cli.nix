{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      btop
      delta
      dust
      eza
      fd
      fzf
      ripgrep
      tldr
      wget
    ];

    programs = {
      bat.enable = true;
      zoxide.enable = true;

      fish.shellAliases = {
        cat = "bat";
        ls = "eza --icons=auto";
      };
    };
  };

  flake.modules.homeManager.core = {
    programs = {
      # Use delta in git diff.
      git.settings.core.pager = "delta";

      yazi = {
        enable = true;
        shellWrapperName = "y";
      };
    };
  };
}

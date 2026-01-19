{config, ...}: {
  flake.modules.nixos.core = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.meta.username} = {
      isNormalUser = true;
      description = config.meta.username;
      extraGroups = ["wheel"];
    };

    # No password needed for sudo users.
    security.sudo.wheelNeedsPassword = false;
  };
}

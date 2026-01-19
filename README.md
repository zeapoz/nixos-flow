# NixOS Flow

## Project Layout

- [config](./config) - non-nix configurations
- [modules](./modules) - flake parts modules

## Installation

### From existing NixOS installation

Clone the configuration directory to your home directory:

```sh
git clone https://github.com/zeapoz/nixos-flow ~/nixos
```

Symlink the cloned directory to `/etc/nixos`:

```sh
sudo ln -s  ~/nixos /etc/nixos
```

Rebuild as normal:

```sh
sudo nixos-rebuild switch --flake .#flow
```

### From installation media

Make sure that you have prepared the system by partitioning and mounting the drives. For details on this step, refer to the [Installation Guide](https://nixos.wiki/wiki/NixOS_Installation_Guide).

Once done, clone the configuration directory:

```sh
git clone https://github.com/zeapoz/nixos-flow /mnt/nixos
```

Generate a new hardware configuration and replace the existing one:

```sh
sudo nixos-generate-config --root /mnt
sudo mv -f /mnt/nixos/hardware-configuration.nix /mnt/nixos/modules/host/_hardware-configuration.nix
```

Install the system:

```sh
cd /mnt
sudo nixos-install --flake .#flow
```

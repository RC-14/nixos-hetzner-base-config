# nixos-hetzner-base-config
A template configuration for using nixos on hetzner cloud.
Don't expect too much. I just put this here so that I know what I did if I ever need to repeat it.

## How to use
1. Create a new hetzner cloud VM with [nixos-infect](https://github.com/elitak/nixos-infect?tab=readme-ov-file#hetzner-cloud) (used Debian 11).
2. Wait till it's done.
3. Ssh into the machine as `root`.
4. Place the files from this repo in `/etc/nixos/` (overwrite if `configuration.nix` after checking for stuff that might be important to you).
5. Change whatever you need to. (ssh key, user name, host name, ...)
6. Make sure you used the machines hostname in `flake.nix`
7. `nixos-rebuild switch --flake /etc/nixos`

## Tips and Tricks
- Opening a console in the webinterface during the boot process lets you choose the generation to boot just as usual. (in case you messed something up)

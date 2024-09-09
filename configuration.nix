{ pkgs, lib, config, ... }: let
  ssh-keys.rc-14 = ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3gaPO0iFZ8kcDHMsFT5YPWA9k5mou9+VyZYwEvA470w/8UkC5y3rVse+FTxsIO7ju5/NaQQK94jMKNrb8qNErnOGbdaWwKXHhlnWhvntW4qpl23g/2UV244OxuSHKz5ECWt3BbBqQv0VKT8b7mqsGQY+6mTi0wa9PcGrnZ/wQlMBXAk7pxMxJVzG3q4KPpKpTX57mXYhL+FWnridgzddI0WgE0G2/7ZZZGfnxjWojb3nvsUC41dtDZ7eJk+vzvUnZhbyC4RZ1UM+Pb+8fhcpeRFOgyCu+0n/FSqUpdceyNItu21JQe7hy6eCDprx13G/TrJSLiE1X5/mXZlEOU5RfBwbMIMm2WlxfbL9HCViZm8oL9ZXFOmgM7kyVb2tw4Fj2AC+OlDVtL0prwKX3UTSmMsNQVdWsM+AIExDqNQHQghFBXrM17A9GUs2wu/l1+ba1hsQLKSf7lVc9Ushk0IzCZqv6Nw4CPbj9hmHa0d7LNPHa7WIG/L6557x5E+COuFk='';
in {
  system.stateVersion = "24.05";

  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "nixos-test";
  networking.domain = "";
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "rc-14" ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      setOptions = [
      ];
      shellAliases = {
        ls = "ls --color=auto";
        l = "ls";
        la = "l -A";
        ll = "l -lh";
        lla = "ll -A";
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
        ];
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    nh = {
      enable = true;
      flake = /etc/nixos;
    };
  };
  environment = {
    shells = with pkgs; [
      zsh
    ];
  };
  security.sudo.wheelNeedsPassword = false; # !!!IMPORTANT!!! Set a password before changing this
  users = {
    defaultUserShell = pkgs.zsh;
    users.rc-14 = {
      description = "RC-14";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ssh-keys.rc-14 ];
      packages = with pkgs; [
      ];
    };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

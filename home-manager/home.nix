# This is your home-manager configuration file Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
#  inputs,
#  outputs,
#  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
#  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
#  ];

  nixpkgs = {
    # You can add overlays here
    #overlays = [
      ## Add overlays your own flake exports (from overlays and pkgs dir):
      #(import ../../outputs.overlays.additions.nix)
      #(import ../../outputs.overlays.modifications.nix)
      #(import ../../outputs.overlays.unstable-packages.nix)
      
      #outputs.overlays.additions
      #outputs.overlays.modifications
      #outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    #];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "astrea";
    homeDirectory = "/home/astrea";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
    packages = with pkgs; [ # Needs to be broken down into various modules. Target activate part of the configuration depending on the system (e.g. NixOS, wsl with hm, ...) and it's uses (e.g. home, cyber, work, ...=

# Shell
      # zhs

# CLI tools
      cowsay # Test package
 # Tools and tools replacement
      #fzf # Better history command # present below in programs.fzf 
      #eza # Better ls with icons, needs fonts (nerd-fonts installed in nix config) # present below
      tree # File listing in a tree representation
      lf # CLI file browser
      # bat to replace cat?
      glow # Render markdown in CLI
      # Check is still usefull:
      graphviz # Visualization software. Used for commands such as `systemd-analyze plot > file.svg` to create images


 # Debug tools
      wget # Url fetching
      curl # Url fetching
      lynx # Light web browser
      jq # Json parser

# Hardware / System
      hyfetch # Sys ressources
      btop # Sys ressources
      lshw # Hardware lister
      pciutils # Give access to `lspci,` `pcilmr`, and, `setpci` cli tools and `lspci.so` library for programs to access PCI subsytems



# Network analyzers
      # https://snapshooter.com/learn/check-network-usage--linux
      iftop
      nethogs
      tcpdump

# Offensive security
  # Network
      nmap

# Softwares
      (discord.override {
      # withOpenASAR = true; # can do this here too
        withVencord = true;
      })
      # https://nixos.wiki/wiki/Discord
      # Check the following packages: discord #vencord # vesktop

      # Email
      thunderbird

      # Gaming
      steam # No workie

      # Audio
      friture # RT audio analyzer with spectrum
      # audacity
    ];

  };
  programs.eza = {
    enable = true;
    #icons = "auto"; # Check which one is better AKA read the code
    icons = "always";
    colors = "auto";
  };

  programs.fzf = { # Check why it would be better to declare this program here or above and what are the implications of a double entry in home.packages
    enable = true;
  };

  programs.bash = { # Verify usefullness especially with another terminal
    enable = true;
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true; # Add git config [ #EDIT ]



  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}

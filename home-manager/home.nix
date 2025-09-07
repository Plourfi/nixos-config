# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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
      cowsay
      discord
      wget
      curl
      lynx
      jq
      tree
      hyfetch
      #fzf

      steam

      btop
    ];

  };
  programs.eza = {
    enable = true;
    #icons = "auto";
    icons = "always";
    colors = "auto";
  };

  programs.fzf = {
    enable = true;
  };

  programs.bash = {
    enable = true;
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;



  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}


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

      vscode # IDE
     # devenv # To check

# Shell
      #zsh

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


     # cabal2nix # Used in Python devenv
 # Debug tools
      wget # Url fetching
      curl # Url fetching
      lynx # Light web browser
      jq # Json parser
      toybox # Unix tools # https://landley.net/toybox/ # https://en.wikipedia.org/wiki/Toybox

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
      p0f # Get Scapy CLI and more # https://lcamtuf.coredump.cx/p0f3/

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
      #steam # No workie

      # Audio
      friture # RT audio analyzer with spectrum
      # audacity

      # vlc
      drawio

    ];

  };
  programs.eza = {
    enable = true;
    #icons = "auto"; # Check which one is better AKA read the code
    icons = "always";
    colors = "auto";
  };

#  programs.fzf = { # Check why it would be better to declare this program here or above and what are the implications of a double entry in home.packages
#    enable = true;
#  };


#  programs.zsh = {
#    enable = true;
#    autosuggestion = {
#      enable = true;
#      highlight = "fg=#6f6c5d";
#    };
#    enableCompletion = true;
#    enableZshIntegration = true;
#  };


# https://github.com/Aloxaf/fzf-tab
  programs.fzf = {
    enable = true;
#    enableZshIntegration = true;
  };


  programs.bash = { # Verify usefullness especially with another terminal
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };


# https://ohmyposh.dev/docs/installation/customize
# https://ohmyposh.dev/docs/segments/cli/nix-shell
# https://en.wikipedia.org/wiki/List_of_Unicode_characters

#  programs.oh-my-posh.enable = true;
#  programs.oh-my-posh.settings = builtins.readFile ../hul10.omp.json;

  programs.oh-my-posh = {
    enable = false;
##    enableZshIntegration = true;
##    useTheme = "M365Princess.json";
##    settings = builtins.readFile ./custom.omp.json;
#    useTheme = "../try.omp.json";
    useTheme = "../hul10.omp.json";
#    useTheme = "M365Princess.omp.json";
#    settings = "./config/ohmyposh/zen.toml";
  };


#  programs.zsh.enable = true;
#  programs.zsh = {
#    enable = true;
#    enableCompletion = true;
#    autosuggestion.enable = true;
#    syntaxHighlighting.enable = true;
#  };

#  programs.zsh.plugins = [
#      {
#        name = "fzf-tab";
#        src = pkgs.fetchFromGitHub {
#          owner = "Aloxaf";
#          repo = "fzf-tab";
#          rev = "c2b4aa5ad2532cca91f23908ac7f00efb7ff09c9";
#          sha256 = "1b4pksrc573aklk71dn2zikiymsvq19bgvamrdffpf7azpq6kxl2";
#        };
#      }
#    ];

#  programs.zsh.plugins = [
#    {
#      name = "fzf-tab";
#      src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
#    }
#  ];


  #programs.zsh.initContent = ''
  #    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
  #'';


  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true; # Add git config [ #EDIT ]



  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixtrea"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system and GNOME.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11 and console
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };
  console.keyMap = "fr";

  # Enable CUPS for printing
  services.printing.enable = true;

  # Enable sound with pipewire
  #services.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
  #};

  # Define a user account
  users.users.astrea = {
    isNormalUser = true;
    description = "astrea";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Install firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];


  # Install some basic system packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    eza
    git
    obsidian
    discord
    protonvpn-gui
    nh
    nix-output-monitor
  ];

#  programs.nh = {
#    enable = true;
#    clean.enable = true;
#    clean.extraArgs = "--keep-since 4d --keep 3";
#    flake = "/home/user/my-nixos-config"; # sets NH_OS_FLAKE variable for you
#  };




  # Enable fontconfig if necessary (optional)
  fonts.fontconfig.enable = true;
  # fonts.fontconfig.defaultFonts.emoji = [ "nerd-fonts" ];

  # Install nerd fonts
  fonts.packages = with pkgs; [
    #nerd-fonts for eza icons
    nerd-fonts.fira-code #nerd-fonts
    nerd-fonts.hack #nerd-fonts
    nerd-fonts.droid-sans-mono #nerd-fonts
  ];




  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Set the system state version
  system.stateVersion = "25.05";


 # Enable 16Go of swap memory
 # Should be required/is better for rebuild system
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];
}

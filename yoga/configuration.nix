{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "iwlwifi" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_16;

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
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Install firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true; # Would this override the next line?
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # Obsidian dependancy
  ];


  # Install some basic system packages
  environment.systemPackages = with pkgs; [
    vim # Learn it someday ¯\_(ツ)_/¯ 
    wget # trm > hm
    #eza
    git # to remove, already present in home manager
    obsidian # move to hm
    # discord
    protonvpn-gui # mv to hm
    nh # nix updater next gen
    nix-output-monitor
    nvd
  ];

#  programs.nh = {
#    enable = true;
#    clean.enable = true;
#    clean.extraArgs = "--keep-since 4d --keep 3";
#    flake = "/home/user/my-nixos-config"; # sets NH_OS_FLAKE variable for you
#  };


  # Ollama as a systemd service:
  # https://fictionbecomesfact.com/notes/nixos-ollama-oterm-openwebui/
  services.ollama = {
    enable = true;
    loadModels = [ "deepseek-r1:1.5b" "gemma3:270m" "llama3.1:8b" "deepseek-r1:14b" "gpt-oss:20b" "gemma3:12b" "gemma3:4b" ];
  };



  # Enable fontconfig if necessary (optional)
  fonts.fontconfig.enable = true;
  # fonts.fontconfig.defaultFonts.emoji = [ "nerd-fonts" ];

  # Install nerd fonts
  fonts.packages = with pkgs; [
    # nerd-fonts for eza icons
    nerd-fonts.fira-code #nerd-fonts
    nerd-fonts.hack #nerd-fonts
    nerd-fonts.droid-sans-mono #nerd-fonts
  ];

# To check
  systemd.services.NetworkManager-wait-online.enable = false; # Mayber fix the wait time for networking componnents when booting

  virtualisation.docker.enable = true;
  #virtualisation.docker.rootless = {
  #  enable = true;
  #  setSocketVariable = true;
  #};


# To check
# https://discourse.nixos.org/t/wifi-stops-working-requiring-a-reboot/48940/7
  hardware.enableRedistributableFirmware = true ; # Maybe fix boot time by using licensed firmwares 
  hardware.enableAllFirmware = true ; # Maybe fix boot time by using licensed firmwares 


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Set the system state version
  system.stateVersion = "25.05";

# Might slow boot time by 1.5 minute
 # Enable 16Go of swap memory
 # Should be required/is better for rebuild system
#  swapDevices = [{
#    device = "/swapfile";
#    size = 16 * 1024; # 16GB
#  }];
}

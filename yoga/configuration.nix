{ config, pkgs, ... }:

{

#  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_16.override {
#    argsOverride = rec {
#      src = pkgs.fetchurl {
#            #sha256 = "sha256-IxMRvXCE3DEplE0mu0O+b/g32oL7IQSmdwSuvKi/pp8=";
#            sha256 = "sha256-7nZQmWunWqKf5m8wm0Ewl/JJoD5wAfKkESjHyVIFImo=";
#            url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
##            sha256 = "sha256-231311bd7084dc3129944d26bb43be6ff837da82fb2104a67704aebca8bfa69f";
#      };
#      version = "6.16.9";
#      modDirVersion = "6.16.9";
#      };
#  });




  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
#  boot.kernelModules = [ "iwlwifi" ]; # Error -110 if not used and not powercycled?
  boot.kernelPackages = pkgs.linuxPackages_testing;
#  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_16; # Check if using a pre-rel version would help correct iwlwifi issues
  virtualisation.docker.enableOnBoot = false; # Disable Docker on boot to get faster boot time


# virtualization
##  virtualisation.virtualbox.host.enable = true;
##  virtualisation.virtualbox.guest.enable = true;
##  virtualisation.virtualbox.guest.dragAndDrop = true;
##  users.extraGroups.vboxusers.members = [ "astrea" ];
##  virtualisation.virtualbox.host.enableHardening = false;

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["astrea"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;


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
#  services.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.enable = true;
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "docker" ]; # "docker" group to execute docker or docker rootless?
  };

  # Install firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true; # Would this override the next line?
  nixpkgs.config.permittedInsecurePackages = [ # Move to [ #HM ]?
    "electron-25.9.0" # Obsidian dependancy
  ];


  # Install some basic system packages
  environment.systemPackages = with pkgs; [
    vim # Learn it someday ¯\_(ツ)_/¯ 
    git # to remove, already present in [ HM ]
    obsidian # move to [ #HM ]
    protonvpn-gui # mv to [ #HM ]
    protonmail-desktop # mv to [ #HM ]
    nh # nix updater next gen
    nix-output-monitor # Show live builds
    nvd
    python3
#    virtualbox
    #wine-stagging.overrideAttrs { version = ...; src = ...; }

    wireshark
    vscode
  ];

#  programs.nh = {
#    enable = true;
#    clean.enable = true;
#    clean.extraArgs = "--keep-since 4d --keep 3"; # Automatically gc (garbage collect) old generations
#    flake = "/home/user/my-nixos-config"; # sets NH_OS_FLAKE variable for you
#  };

  programs.zsh.enable = true;
  users.users.astrea.shell = pkgs.zsh;



  # Ollama as a systemd service:
  # https://fictionbecomesfact.com/notes/nixos-ollama-oterm-openwebui/
  services.ollama = {
    enable = true;
# Automatically download these models [ #MODULARIZE ], need to be modularized, each model download takes lot of space and bandwidth
# Check with: $ systemctl status ollama ollama-model-loader.service
    loadModels = [ "deepseek-r1:1.5b" "gemma3:270m" "llama3.1:8b" "deepseek-r1:14b" "gpt-oss:20b" "gemma3:12b" "gemma3:4b" ];
  };


  # Enable fontconfig if necessary (optional)
  fonts.fontconfig.enable = true;
  # fonts.fontconfig.defaultFonts.emoji = [ "nerd-fonts" ];

  # Install nerd fonts
  fonts.packages = with pkgs; [
    # nerd-fonts necessary for eza icons:
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
  hardware.enableRedistributableFirmware = true ; # Maybe fix boot time by using licensed firmwares [ #REDUNDANT ], next setting is more permissive
  hardware.enableAllFirmware = true ; # Maybe fix boot time by using licensed firmwares # Only this setting should suffice


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

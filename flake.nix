{
  description = "Astrea's NixOS config";

  inputs = {
    # Nixpkgs
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
#    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
#    home-manager.url = "github:nix-community/home-manager/release-25.05";



    home-manager.url = "github:nix-community/home-manager/37a3d97f2873e0f68711117c34d04b7c7ead8f4e";
#    home-manager.url = "github:nix-community/home-manager/b72be79a42d470e4bafb5348dc62df484b6baab3";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux" # Need to check
      "i686-linux" # Need to check
      "x86_64-linux" # Should be regular architecture?
      #"aarch64-darwin" # Mac OS
      #"x86_64-darwin" # Mac OS
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos; # Might be useless
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    #homeManagerModules = import ./modules/home-manager; # Useless and breaking flake if empty

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname' #Should it be the hostname or just a key?
    nixosConfigurations = {
      # hostname or conf name
      aspire3 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./aspire3/configuration.nix
        ];
      };

      yoga = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./yoga/configuration.nix
        ];
      };


    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # username@hostname
      "astrea" = home-manager.lib.homeManagerConfiguration {
#      "astrea@nixtrea" = home-manager.lib.homeManagerConfiguration {
      #"nixtrea" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
#          {
#            home.username = "astrea";
#            home.homeDirectory = "/home/astrea";
#            home.stateVersion = "23.11";
#          }
        ];
      };
    };
  };
}

# Debugging

## FLakes

Show the outputs provided by a flake : 

```shell
nix flake show --all-systems
```

> [!NOTE] - Result
> ```shell
> nix flake show --all-systems
> warning: Git tree '/home/astrea/nixos-config' is dirty
> git+file:///home/astrea/nixos-config
> ├───formatter
> │   ├───aarch64-linux: package 'alejandra-4.0.0'
> │   ├───i686-linux: package 'alejandra-4.0.0'
> │   └───x86_64-linux: package 'alejandra-4.0.0'
> ├───homeConfigurations: unknown
> ├───homeManagerModules: unknown
> ├───nixosConfigurations
> │   └───nixtrea: NixOS configuration
> └───overlays
>     ├───additions: Nixpkgs overlay
>     ├───modifications: Nixpkgs overlay
>     └───unstable-packages: Nixpkgs overlay
> ``` 


Check for flake errors :

```shell
nix flake check --show-trace
```

> [!NOTE] Results
> ```shell
> [astrea@nixtrea:~/nixos-config]$ nix flake check --all-systems 
> warning: Git tree '/home/astrea/nixos-config' is dirty
> warning: unknown flake output 'homeManagerModules'
> ```


Flake debug in one copy :
```shell
nix flake check --show-trace
nix flake show --all-systems
```

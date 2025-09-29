

# Tasks/To do

Non exaustive tasklist:

- [ ] Add desktop environment
- [ ] Add various entries for differents systems and user environments
	- [ ] Modularize home manager config # https://www.youtube.com/watch?v=vYc6IzKvAJQ
	- [ ] Possibility of creating an interacting flake
- [ ] Change default shell
- [ ] Modularize configuration.nix
	- [ ] Add new laptop to the tree structure
- [ ] Make the flake interractive
- [ ] Break down the modules into categories eitheir for packages types (e.g. cli, gaming, etc.) or packages uses (e.g. home, work, schoole etc.)
- [ ] Improve security
	- [ ] Check `systemd-analyze security` relevancy


# Command

NixOS update:
```shell
nh os switch .#nixosConfigurations.yoga
```

hm update:

```shell
nh home switch .#homeConfigurations."astrea".activationPackage
```

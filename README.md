

# Tasks/To do

Non exaustive tasklist:

- [ ] Add desktop environment
- [ ] Add various entries for differents systems and u9ser environments
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
nh os switch .#nixosConfigurations.yoga

hm update:
nh home switch .#homeConfigurations."astrea".activationPackage


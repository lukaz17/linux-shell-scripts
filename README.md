# Linux Shell Scripts

Collection of sh for convenience.

## How to use

The scripts are portable and can be run from any place in you system.

The scripts rely on common tools available on most Linux systems: `curl`, `git`, `jq`, `sed`, and `tar`. If any of them is missing, install with your package manager:

Debian / Ubuntu

```
sudo apt-get install curl git jq sed tar
```

Fedora / RHEL

```
sudo dnf install curl git jq sed tar
```

Arch Linux

```
sudo pacman -S curl git jq sed tar
```

openSUSE

```
sudo zypper install curl git jq sed tar
```

Alpine Linux

```
sudo apk add curl git jq sed tar
```

However, it is recommended to check out this repository in `~/bin` directory. Most system have already defined the path for this directory. Otherwise, the path can be added manually in `~/.profile` or `~/.bashrc`.

```
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi
```

To install systemwide with root privilege, run the scripts with `sudo -i`. This installs into `/usr/local/share` with symlinks in `/usr/local/bin`.

## License

Linux Shell Scripts is licensed under MIT license. See LICENSE file and NOTICE file for more details.

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

However, it is recommended to check out this repository in `~/bin` directory. Most system have already defined the path for this directory. Otherwise, the path can be added manually in your login file or `~/.bashrc`.

```
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi
```

Your login file is `~/.profile`. Bash reads only the first of `~/.bash_profile`, `~/.bash_login` and `~/.profile` that it finds, so if one of the first two exists and does not load `~/.profile`, that file is your login file instead.

### Install scope

Run a script by name to install for your account only. This installs into `~/.local/share` with symlinks in `~/.local/bin`.

To install systemwide, run the script as root. This installs into `/usr/local/share` with symlinks in `/usr/local/bin`. Root has its own `PATH`, so add the repository to root's login file once. The examples use `/data/scripts` as the checkout path. Write the absolute path, because `$HOME` means `/root` in that file:

```
export PATH="/data/scripts:$PATH"
```

Scripts in this directory run as root, so keep it writable by trusted users only.

Hint: if you only install systemwide, check out the repository in `/root/bin` and add that path to root's login file instead. `sudo -i go-install` then runs the scripts by name, and `/root` is normally closed to other accounts, so they cannot change the scripts. Your own account cannot run them from there either, so installing for your account needs a second checkout.

Some installers also add shell setup to the login file, or to `~/.bashrc` for `nvm-install`. The command decides which account gets it:

| Command | Installs | Shell setup goes to |
|---------|----------|---------------------|
| `go-install` | For your account | Your account |
| `sudo -i go-install` | Systemwide | Your account |
| `sudo -u root sudo -i go-install` | Systemwide | Root |
| `go-install` when logged in as root | Systemwide | Root |

A root shell opened with `sudo -i` is not a root login: `go-install` typed there sends shell setup to your account, like `sudo -i go-install`.

### Using sudo without -i

Where sudoers sets `secure_path`, as Debian and Ubuntu do, `sudo go-install` fails with `command not found`, because `sudo` searches that list instead of your `PATH`. `sudo -u root go-install` is the same command. There are two ways around this:

- Use the full path: `sudo /data/scripts/go-install`.
- Run `sudo visudo` and append `:/data/scripts` to `secure_path`, then `sudo go-install` works.

Either way, the program installs systemwide and shell setup goes to your account, like `sudo -i go-install`. Changing `secure_path` only affects `sudo`: to run `go-install` when logged in as root, the path must still be in root's login file.

## License

Linux Shell Scripts is licensed under the MIT license. See LICENSE file and NOTICE file for more details.

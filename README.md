# Linux Shell Scripts

Collection of sh for convenience.

## How to use

The scripts are portable and can be run from any place in you system.

However, it is recommended to check out this repository in `~/bin` directory. Most system have already defined the path for this directory. Otherwise, the path can be added manually in `~/.profile` or `~/.bashrc`.

```
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi
```

## License

Linux Shell Scripts is licensed under MIT license. See LICENSE file and NOTICE file for more details.

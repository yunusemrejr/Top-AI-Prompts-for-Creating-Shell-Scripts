# Kernel-Specific Shell Scripts for Linux

## Considerations
- Use `uname -r` for version
- Check `/proc`, `/sys` filesystems
- Handle different distros (systemd vs others)
- Kernel modules with `modprobe`, `lsmod`

## Examples
See `/examples/kernel-module-check.sh`

Always test on target kernel version.
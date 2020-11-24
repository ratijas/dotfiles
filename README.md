# Dotfiles

Collection of dotfiles and setup advices that suite my particular usecase. YMMV.

## Install

Installation requires [thoughtbot/rcm](https://github.com/thoughtbot/rcm) package.

 - After clonning into `.dotfiles` like this: `git clone --recurse-submodules https://github.com/ratijas/dotfiles $HOME/.dotfiles`,
 - run twice `rcup -v`:
    * first time it installs `.rcrc` config according to hostname,
    * second time it acts according to parameters in `.rcrc`.

## Dependencies

All dependencies are optional so far.

 - [lf](https://github.com/gokcehan/lf): Terminal file manager.
 - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): Fish shell-like syntax highlighting for Zsh. Available on Arch/community and apt.
 - [powerlevel10k](https://github.com/romkatv/powerlevel10k): A Zsh theme

## ASUS ROG

To fix sound issue add the following line to `/etc/modprobe.d/99-sound.conf`:

```
options snd-hda-intel model=dell-headset-multi
```

[Source](https://www.reddit.com/r/linuxhardware/comments/5nei16/linux_on_asus_rog_laptops/)

Install correct driver for ethernet module and blacklist built-in one:

- `aura -A `[r8168-dkms](https://aur.archlinux.org/packages/r8168-dkms/)
- `echo "blacklist r8169" > /etc/modprobe.d/r8169_blacklist.conf`

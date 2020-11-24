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

### Network

[Realtek RTL8111/8168B](https://wiki.archlinux.org/index.php/Network_configuration/Ethernet#Realtek_RTL8111/8168B)

> The adapter should be recognized by the `r8169` module. However, with some chip revisions the connection may go off and on all the time. The alternative [r8168](https://www.archlinux.org/packages/?name=r8168) should be used for a reliable connection in this case. [Blacklist](https://wiki.archlinux.org/index.php/Blacklist) `r8169`, if [r8168](https://www.archlinux.org/packages/?name=r8168) is not automatically loaded by [udev](https://wiki.archlinux.org/index.php/Udev), see [Kernel modules#Automatic module loading with systemd](https://wiki.archlinux.org/index.php/Kernel_modules#Automatic_module_loading_with_systemd).

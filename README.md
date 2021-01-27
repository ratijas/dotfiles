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

 - [bat](https://github.com/sharkdp/bat):  A cat(1) clone with wings.
 - [fd](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to 'find'.
 - [fzf](https://github.com/junegunn/fzf): A command-line fuzzy finder.
 - [lf](https://github.com/gokcehan/lf): Terminal file manager.
 - [powerlevel10k](https://github.com/romkatv/powerlevel10k): A Zsh theme.
 - [zsh-completions](https://github.com/zsh-users/zsh-completions): Additional completion definitions for Zsh.
 - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): Fish shell-like syntax highlighting for Zsh.

Some dependencies are vendored, i.e. copy-pasted from their repositories.
It is possible to update some of them using `git subtree` commands.

 - [ZSH-z](https://github.com/agkozak/zsh-z): Jump quickly to directories that you have visited "frecently."
   ```sh
   git subtree add --prefix=tag-zsh/config/zsh/zshrc.d/50.plugins.d/zsh-z --squash git@github.com:agkozak/zsh-z.git master
   ```

### Host "getaway"

 - [git-credential-keepassxc](https://github.com/frederick888/git-credential-keepassxc): Helper that allows Git (and shell scripts) to use KeePassXC as credential store.

## ASUS ROG

To fix sound issue add the following line to `/etc/modprobe.d/99-sound.conf`:

```
options snd-hda-intel model=dell-headset-multi
```

[Source](https://www.reddit.com/r/linuxhardware/comments/5nei16/linux_on_asus_rog_laptops/)

### Network

[Realtek RTL8111/8168B](https://wiki.archlinux.org/index.php/Network_configuration/Ethernet#Realtek_RTL8111/8168B)

> The adapter should be recognized by the `r8169` module. However, with some chip revisions the connection may go off and on all the time. The alternative [r8168](https://www.archlinux.org/packages/?name=r8168) should be used for a reliable connection in this case. [Blacklist](https://wiki.archlinux.org/index.php/Blacklist) `r8169`, if [r8168](https://www.archlinux.org/packages/?name=r8168) is not automatically loaded by [udev](https://wiki.archlinux.org/index.php/Udev), see [Kernel modules#Automatic module loading with systemd](https://wiki.archlinux.org/index.php/Kernel_modules#Automatic_module_loading_with_systemd).

Even r8169 is not perfect: my ethernet port voids out after waking up from suspend. Solved it by reloading the kernel module via systemd sleep hook. Install these files from [tag-workarounds](./tag-workarounds):

- /usr/bin/r8168-reload.sh
- /usr/lib/systemd/system-sleep

Resources:

- [My blog post](https://t.me/ratijas_life/108)
- [Arch Linux bug tracker](https://bugs.archlinux.org/task/67314)
- [GitHub issue](https://github.com/mtorromeo/r8168/issues/30)

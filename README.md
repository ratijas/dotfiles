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
   git subtree pull --prefix=tag-zsh/config/zsh/zshrc.d/50.plugins.d/zsh-z --squash git@github.com:agkozak/zsh-z.git master
   ```

### Adding new plugins

The hard way. Works for any locally cloned repo, not only for oh-my-zsh. If prefix is not needed (i.e. the whole repository is a plugin), then local cloning and subtree splitting should be omitted.

  ```sh
  cd path/to/ohmyzsh
  grt  # optionally, cd to git root
  local plugin commit
  plugin=gitignore  # for example
  commit=$( git subtree split -P plugins/$plugin )
  cd ~/.dotfiles
  git subtree add --prefix=tag-zsh/config/zsh/zshrc.d/50.plugins.d/$plugin --squash path/to/ohmyzsh $commit
  ```

### Host "getaway"

 - [git-credential-keepassxc](https://github.com/frederick888/git-credential-keepassxc): Helper that allows Git (and shell scripts) to use KeePassXC as credential store.

## ASUS ROG G752VT

### Audio/Sound

In default configuration, kernel fails to detect proper options for HD Audio driver, `snd-hda-intel`. Symptoms are: constant high-pitched noise in headset, burst of low-pitched noise after powering up, waking up, or just using audio output after long silence.

Linux kernel used to work around autodetection bugs by giving users an option to specify a "model" manually. It actually loads a set of fix-ups to apply when loading a driver. For implementation details, see `patch_realtek.c`.

For ALC668, use model `alc668-headset`. It fixes the high-pitch noise, at least until first hibernation. Install from from [tag-workarounds](./tag-workarounds) this file:

- /etc/modprobe.d/alsa.conf

Resources:

- [Linux Sound Subsystem Documentation](https://www.kernel.org/doc/html/latest/sound/index.html)
- [HD-Audio Codec-Specific Models](https://www.kernel.org/doc/html/latest/sound/hd-audio/models.html)
- [/kernel/linux/sound/pci/hda/patch_realtek.c](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/pci/hda/patch_realtek.c)

### Network

[Realtek RTL8111/8168B](https://wiki.archlinux.org/index.php/Network_configuration/Ethernet#Realtek_RTL8111/8168B)

> The adapter should be recognized by the `r8169` module. However, with some chip revisions the connection may go off and on all the time. The alternative [r8168](https://www.archlinux.org/packages/?name=r8168) should be used for a reliable connection in this case. [Blacklist](https://wiki.archlinux.org/index.php/Blacklist) `r8169`, if [r8168](https://www.archlinux.org/packages/?name=r8168) is not automatically loaded by [udev](https://wiki.archlinux.org/index.php/Udev), see [Kernel modules#Automatic module loading with systemd](https://wiki.archlinux.org/index.php/Kernel_modules#Automatic_module_loading_with_systemd).

Even r8168 is not perfect: my ethernet port voids out after waking up from suspend. Solved it by reloading the kernel module via systemd sleep hook. Install these files from [tag-workarounds](./tag-workarounds):

- /usr/bin/r8168-reload.sh
- /usr/lib/systemd/system-sleep

Resources:

- [My blog post](https://t.me/ratijas_life/108)
- [Arch Linux bug tracker](https://bugs.archlinux.org/task/67314)
- [GitHub issue](https://github.com/mtorromeo/r8168/issues/30)

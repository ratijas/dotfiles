# Dotfiles

Collection of dotfiles and setup advices that suite my particular usecase. YMMV.

### ASUS ROG

To fix sound issue add the following line to `/etc/modprobe.d/99-sound.conf`:

```
options snd-hda-intel model=dell-headset-multi
```

[Source](https://www.reddit.com/r/linuxhardware/comments/5nei16/linux_on_asus_rog_laptops/)

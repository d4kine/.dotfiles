# .dotfiles
my config-files for different tools like i3, rofi, polybar, etc.

```sh
# clone, change directory and symlink with stow
git clone ~ && cd ~/.dotfiles
stow -v -R --ignore=.cache --ignore=.git --ignore=README
```

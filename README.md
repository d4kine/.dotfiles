# .dotfiles
my config-files for different tools like i3, rofi, polybar, etc.

Managed with Gnus magic tool stow -> https://www.gnu.org/software/stow/

```sh
# clone, change directory and symlink with stow
git clone https://github.com/d4kine/.dotfiles.git && cd ~/.dotfiles
stow -v -R --ignore=.cache --ignore=.git --ignore=README.md .
```

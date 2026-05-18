# Dotfiles

This repository stores my dotfiles.

## Requirements

Ensure you have the following installed on your system:

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

First, check out the repository in your home directory:

```sh
cd ~
git clone https://github.com/DevReaper0/dotfiles.git
cd dotfiles
```

Then, use GNU Stow to create symbolic links for the dotfiles:

```sh
stow .
```

Finally, install Neovim and tmux plugins:

```sh
nvim +PlugInstall +q2
tmux # Press `Ctrl + a`, then `I`.
```

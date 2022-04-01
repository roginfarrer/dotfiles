# Rogin's Dotfiles

My dotfiles are managed with GNU Stow.

## Installation

From the root directory on the Mac, run:

```sh
git clone https://github.com/roginfarrer/dotfiles_stow.git dotfiles
cd dotfiles
bash install.sh
```

Then there's a few things that need to be installed that can't be automated:

- [Cleanshot X](https://licenses.maketheweb.io/download/cleanshotx)
- MonoLisa Font (Find the download link in your email)

Then everything should work! I don't know, I haven't tried to run this on a new machine!

## Updating dotfiles

When pulling new commits onto a machine, you can simply re-stow the dotfiles:

```sh
stow -R *
```

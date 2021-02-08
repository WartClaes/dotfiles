# dotfiles

```
$ source bootstrap.sh

$ vim ~/.vimrc
```

Then type inside the `.vimrc` file -> `:PlugInstall`
> For more info: https://github.com/junegunn/vim-plug

## Requirements

### install ripgrep

In Vim we use [FZF](https://github.com/junegunn/fzf.vim) for searching in files. 
This uses [ripgrep](https://github.com/BurntSushi/ripgrep) below the surface for enhanced performance.


```
$ brew install ripgrep
```

### Starship

[Starship](https://starship.rs/) is used for some extra customizing in the shell.

The config can be found in `.config/starship.toml`.

```
$ brew install starship
```

#### Font

Starship requires you to [use a font](https://starship.rs/presets/#nerd-font-symbols) 
that understands all the characters being used.

The font I currently use is `Droid Sans Mono for PowerLine` and can be found in 
the [powerline/fonts Github](https://github.com/powerline/fonts/).

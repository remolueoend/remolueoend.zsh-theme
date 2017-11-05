# remolueoend.zsh-theme
Prezto ZSH theme based on Sorin, using emojis for tracking GIT context.

## Prerequisites
This theme currenly only works with prezto: https://github.com/sorin-ionescu/prezto.

## Installation

The theme is linked by default to `$HOME/.zprezto/modules/prompt/functions/prompt_remolueoend_setup`.
Use the environment variable `THEME_DIR` to overwrite the default directory.

### Install via `npm` or `yarn`:
```sh
npm install -g remolueoend.zsh-theme
yarn global add remolueoend.zsh-theme
```

### Manual installation:
```sh
git clone git@github.com:remolueoend/remolueoend.zsh-theme.git
cd remolueoend.zsh-theme
./scripts/install.sh
# use ./scripts/uninstall.sh to uninstall the theme.
```

## Actvating
To activate the theme for all shell instances, update the theme settings in your `~/.preztorc` file:
```
zstyle ':prezto:module:prompt' theme 'remolueoend'
```

For previewing the theme, use: `prompt remolueoend`.
If you want to activate the theme for the current shell only, use the command `prompt remolueoend`.

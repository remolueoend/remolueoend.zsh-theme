# remolueoend.zsh-theme
Prezto ZSH theme based on Agnoster.

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
git clone https://github.com/remolueoend/remolueoend.zsh-theme.git
cd remolueoend.zsh-theme
./scripts/install.sh
# use ./scripts/uninstall.sh to uninstall the theme.
```

## Activating
To activate the theme for all shell instances, update the theme settings in your `~/.preztorc` file:
```
zstyle ':prezto:module:prompt' theme 'remolueoend'
```

For previewing the theme, use: `prompt remolueoend`.
If you want to activate the theme for the current shell only, use the command `prompt remolueoend`.

## Troubleshooting
Depending on your terminal, the wrong used version of Unicode may infer the cursor position when typing. If your're using iTerm2, you have to enable `Unicode 9 Width`. This settings can be found under `Profile > [PROFILE_NAME] > Text > Text Rendering`.

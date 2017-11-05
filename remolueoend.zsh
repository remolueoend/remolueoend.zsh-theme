
#
# A simple theme that displays relevant, contextual information,
# based on theme Sorin (Sorin Ionescu <sorin.ionescu@gmail.com>)
#
# Authors:
#   Remo <https://github.com/remolueoend>, Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# 16 Terminal Colors
# -- ---------------
#  0 black
#  1 red
#  2 green
#  3 yellow
#  4 blue
#  5 magenta
#  6 cyan
#  7 white
#  8 bright black
#  9 bright red
# 10 bright green
# 11 bright yellow
# 12 bright blue
# 13 bright magenta
# 14 bright cyan
# 15 bright white
#

# Load dependencies.
pmodload 'helper'

function prompt_remolueoend_pwd {
  local pwd="${PWD/#$HOME/~}"

  if [[ "$pwd" == (#m)[/~] ]]; then
    _prompt_remolueoend_pwd="[$MATCH]"
    unset MATCH
  else
    _prompt_remolueoend_pwd="[${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}]"
  fi
}

function prompt_remolueoend_git_info {
  if (( _prompt_remolueoend_precmd_async_pid > 0 )); then
    # Append Git status.
    if [[ -s "$_prompt_remolueoend_precmd_async_data" ]]; then
      alias typeset='typeset -g'
      source "$_prompt_remolueoend_precmd_async_data"
      RPROMPT+='${git_info:+${(e)git_info[status]}}'
      unalias typeset
    fi

    # Reset PID.
    _prompt_remolueoend_precmd_async_pid=0

    # Redisplay prompt.
    zle && zle reset-prompt
  fi
}

function prompt_remolueoend_precmd_async {
  # Get Git repository information.
  if (( $+functions[git-info] )); then
    git-info
    typeset -p git_info >! "$_prompt_remolueoend_precmd_async_data"
  fi

  # Signal completion to parent process.
  kill -WINCH $$
}

function prompt_remolueoend_precmd {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS

  # Format PWD.
  prompt_remolueoend_pwd

  # Define prompts.
  RPROMPT='${editor_info[overwrite]}%(?:: )${VIM:+" %B%F{6}V%f%b"}'

  # Kill the old process of slow commands if it is still running.
  if (( _prompt_remolueoend_precmd_async_pid > 0 )); then
    kill -KILL "$_prompt_remolueoend_precmd_async_pid" &>/dev/null
  fi

  # Compute slow commands in the background.
  trap prompt_remolueoend_git_info WINCH
  prompt_remolueoend_precmd_async &!
  _prompt_remolueoend_precmd_async_pid=$!
}

function prompt_remolueoend_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)
  _prompt_remolueoend_precmd_async_pid=0
  _prompt_remolueoend_precmd_async_data="${TMPPREFIX}-prompt_remolueoend_data"

  # Load required functions.
  autoload -Uz add-zsh-hook

  # Add hook for calling git-info before each command.
  add-zsh-hook precmd prompt_remolueoend_precmd

  # Set editor-info parameters.
  zstyle ':prezto:module:editor:info:completing' format '%B%F{7}...%f%b'
  zstyle ':prezto:module:editor:info:keymap:primary' format ''
  zstyle ':prezto:module:editor:info:keymap:primary:overwrite' format ' %F{3}♺%f'
  zstyle ':prezto:module:editor:info:keymap:alternate' format ' %B%F{2}❮%F{3}❮%F{1}❮%f%b'

  # Set git-info parameters.
  zstyle ':prezto:module:git:info' verbose 'yes'
  zstyle ':prezto:module:git:info:action' format '%F{7}:%f%%B%F{9}%s%f%%b'
  zstyle ':prezto:module:git:info:added' format ' %%B%F{2}✚%f%%b'
  zstyle ':prezto:module:git:info:ahead' format ' %%B%F{13}⇧%f%%b'
  zstyle ':prezto:module:git:info:behind' format ' %%B%F{13}⇩%f%%b'
  zstyle ':prezto:module:git:info:branch' format ' %%B%F{2}%b%f%%b'
  zstyle ':prezto:module:git:info:commit' format ' %%B%F{3}➦ %.7c%f%%b'
  zstyle ':prezto:module:git:info:deleted' format ' ✂️ '
  zstyle ':prezto:module:git:info:modified' format ' ✏️ '
  zstyle ':prezto:module:git:info:position' format ' %%B%F{13}%p%f%%b'
  zstyle ':prezto:module:git:info:renamed' format ' ♻️ '
  zstyle ':prezto:module:git:info:stashed' format ' 🔶 '
  zstyle ':prezto:module:git:info:unmerged' format ' 🙏 '
  zstyle ':prezto:module:git:info:untracked' format ' 🔆 '
  zstyle ':prezto:module:git:info:dirty' format ' 💩 '
  zstyle ':prezto:module:git:info:clean' format ' 🎉 '
  zstyle ':prezto:module:git:info:keys' format \
    'status' '$(coalesce "%b" "%p" "%c")%s%A%B%C%D%S%a%d%m%r%U%u'

  # Define prompts.
  PROMPT='${SSH_TTY:+"%F{9}%n%f%F{7}@%f%F{3}%m%f "}%F{4}${_prompt_remolueoend_pwd}%(!. %B%F{1}#%f%b.)${editor_info[keymap]} '
  RPROMPT=''
  SPROMPT='zsh: correct %F{1}%R%f to %F{2}%r%f [nyae]? '
}

function prompt_remolueoend_preview {
  local +h PROMPT=''
  local +h RPROMPT=''
  local +h SPROMPT=''

  editor-info 2>/dev/null
  prompt_preview_theme 'remolueoend'
}

prompt_remolueoend_setup "$@"

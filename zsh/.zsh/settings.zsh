# Enable autocompletions
# autoload -Uz compinit
# compinit

# Improve autocompletion style
# zstyle :compinstall filename '/Users/rfarrer/.zshrc'
# zstyle ':completion:*' menu select # select completions with arrow keys
# zstyle ':completion:*' group-name '' # group results by category
# zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
# if [ $(date +'%j') != $updated_at ]; then
#   compinit -i
# else
#   compinit -C -i
# fi

## HISTORY
# Save history so we get auto suggestions
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances


# Options
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
# setopt correct_all # autocorrect commands
setopt interactive_comments # allow comments in interactive shells

# zmodload -i zsh/complist

# Colors
# autoload colors; colors

# http://stackoverflow.com/a/844299
# expand-or-complete-with-dots() {
#   echo -n "\e[31m...\e[0m"
#   zle expand-or-complete
#   zle redisplay
# }
# zle -N expand-or-complete-with-dots
# bindkey "^I" expand-or-complete-with-dots

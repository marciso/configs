# .zshrc is for interactive shell config:
# set options (setopt), load modules, change prompt,
# set zle and completion, set variables used by
# interactive shell (e.g. $LS_COLORS)

# Install oh-my-zsh
# curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

#if [ -f /etc/profile ]; then
#  . /etc/profile
#fi

# See .zshenv for more details about DISTCC_TCP_CORK
#unset DISTCC_TCP_CORK

# I want to see test colors in the interactive shell
export GTEST_COLOR=yes

export MANPATH=$MANPATH:/usr/share/man:/usr/local/share/man

# allows editing command in external editor
autoload edit-command-line
autoload -U zmv
autoload zcalc

##
# Vcs info
##
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git #svn hg
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:*' formats "%{$fg[yellow]%}%c%{$fg[green]%}%u%{$reset_color%} [%{$fg[blue]%}%b%{$reset_color%}] %{$fg[yellow]%}%s%{$reset_color%}:%r"


# big history file, by default: $HISTFILE, that is ~/.bash_history
export HISTSIZE=1000000
export SAVEHIST=${HISTSIZE}
export HISTFILESIZE=${HISTSIZE}
export HISTFILE="${HOME}/.history"

setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit 
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword

# compatibility with bash in passing arguments
setopt SH_WORD_SPLIT
setopt SH_FILE_EXPANSION


##
# Pushd
##
setopt auto_pushd               # make cd push old dir in dir stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt pushd_to_home            # `pushd` = `pushd $HOME`
# NOTE: see alias p=pushd, b=popd, d=dirs

alias ls='ls -F --color=auto'
OS=$(uname -s)
[[ "${OS}" = "Darwin" ]] && alias ls='ls -F'

#alias ls='ls -F'
#alias ll='ls -lh'
alias la='ls -FArt'
alias lal='ls -FlArt'
alias lla=lal
alias lt='ls -Flrt'
alias ll=lt
alias l=ll
alias ls-ltr='ls -ltr'
alias ls-tlr='ls -ltr'
alias ls-la='ls -la'
alias ls-l='ls -l'
alias ls-a='ls -a'

# git aliases
for a in ch co cp bt st sh shr d d- lg la ll dd dd- a au l lp b s vb bf fe pl ph; do
	alias g$a="git $a"
done
alias gls='git ls-files -ovs --abbrev=10'

alias grep='grep --color=auto'
alias rgrep='grep -rn'

#alias srgrep='rgrep -I' # like rgrep but ignore binary files
alias moer=more
alias cim=vim
vim --serverlist >/dev/null 2>&1 && alias vim='vim --servername VIM'
alias greo=grep
alias sl=ls
alias xs=cd
alias maek=make
alias mkae=make
alias amke=make
alias gi=git
alias gti=git
alias gut=git

alias g=git
alias gg='git grep'
#alias git='git --work-tree=\$(git rev-parse --show-toplevel)'

alias watch='watch -d'

alias today="date +'%Y%m%d'"
alias today-="date +'%Y-%m-%d'"


alias xless='less -CxQai4'
#alias L=less
#alias M=more
#alias C=cat
command -v dog >/dev/null 2>&1 && alias cat=dog
#alias G=grep
#alias F=find
#alias V=vim
#alias VD=vimdiff
alias LL='xless `ls -1tr | tail -1`'

#alias htop='LANG=en_UK htop'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias f='fd -I'

alias h=history -i 0
alias j=jobs
# f - find
#alias f=locate

alias d='dirs -v'
# "push"
alias p=pushd
# "back"
alias b=popd

alias weather='curl -4 wttr.in/London' 

#setopt VI
bindkey -v
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
# enter vi mode with ^F
bindkey '^F' vi-cmd-mode
# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word


alias S='cd $MS_SRC_BASE'


# build commands
pushd-build-cmd () {
	local cmd="$1"
	local dir_name=$2
	shift 2
	pushd $dir_name && eval $cmd "$@" && popd
	export S=$MS_SRC_BASE
}

pushd-ninja () {
    pushd-build-cmd "CCACHE_BASEDIR=\$(readlink -f \$MS_SRC_BASE) ninja" "$@"
    #pushd-build-cmd "ninja" "$@"
}

get-ms-build-dir() {
    test -n "$MS_SRC_BASE" && (echo $(dirname $(readlink -f $MS_SRC_BASE))/.$(basename $(readlink -f $MS_SRC_BASE))-build) || (echo "MS_SRC_BASE not set" >&2; echo '/dev/null'; exit 1)
}

alias cd-last-cmake-build-dir='cd $(cat ~/.last-cmake-build-dir)'
alias cd-ms-build-dir='cd $(get-ms-build-dir)'

ms-run-build-cmd() {
    local cmd="$1"
    local dir_name=$2
    shift 2
    pushd-build-cmd "$cmd" $(get-ms-build-dir)/$dir_name "$@"
}

ms-ninja-run() {
    ms-run-build-cmd ninja "$@"
}

set-build-dir() {
    local dir_name=$1
    test -n "$dir_name" || (echo "$FUNCNAME() requires an argument (sub-directory name)" >&2; exit 1)
    local full_dir_name="$(get-ms-build-dir)/$dir_name"
    mkdir -p "$full_dir_name"
    echo "$full_dir_name" >! ~/.last-cmake-build-dir
}

ms-cm-run() {
    local dir_name=$1
    local env="${2}"
    local build_type=$3
    local generator="$4"
    local build_cmd="$5"
    shift 5
    test -n "$dir_name" || (echo "$FUNCNAME() requires an argument (sub-directory name)" >&2; exit 1)
    test -n "$build_type" || (echo "$FUNCNAME() requires an argument (build type)" >&2; exit 1)
    test -n "$generator" || (echo "$FUNCNAME() requires an argument (cmake generator name)" >&2; exit 1)
    test -n "$build_cmd" || (echo "$FUNCNAME() requires an argument (build command)" >&2; exit 1)
    set-build-dir $dir_name && cd-last-cmake-build-dir && \
        eval ${env[@]} cmake -G "$generator" \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=On \
        -DCMAKE_BUILD_TYPE="$build_type" "$@" $MS_SRC_BASE && \
        ms-run-build-cmd "$build_cmd" $dir_name
}

alias B=cd-last-cmake-build-dir
alias n='pushd-ninja $(cat ~/.last-cmake-build-dir)'

for i in gcc-Debug gcc-RelWithDebInfo clang-Debug clang-RelWithDebInfo eclipse-clang-Debug ccc-Debug; do

    build_env=()
    ninja_cmd="CCACHE_BASEDIR=\$(readlink -f \$MS_SRC_BASE) ninja"
    #ninja_cmd="ninja"
    case $i in
        *gcc*) build_env=(CC='ccache\ gcc' CXX='ccache\ g++');;
        *clang*) build_env=(CC='ccache\ clang' CXX='ccache\ clang++');;
        *ccc*) build_env=(CCC_CC=clang CCC_CXX=clang++ \
            CC='/usr/libexec/ccc-analyzer'; \
            CXX='/usr/libexec/c++-analyzer'); ninja_cmd="scan-build ninja";;
        *) echo "unknown compiler" >&2;;
    esac
    case $i in
        *Debug*) build_type=Debug;;
        *RelWithDebInfo*) build_type=RelWithDebInfo;;
        *Release*) build_type=Release;;
        *) echo "unknown build type" >&2;;
    esac
    case $i in
        *eclipse*) gen='"Eclipse CDT4 - Ninja"';;
        *) gen=Ninja;
    esac
    extra=''
    case $i in
        *eclipse*) extra='-DCMAKE_ECLIPSE_VERSION=\"4.2\ (Kepler)\"';;
        *) gen=Ninja;
    esac

    alias cm-$i="ms-cm-run $i \"$build_env\" $build_type $gen \"$ninja_cmd\" $extra"
    alias n-$i="ms-run-build-cmd \"$ninja_cmd\" $i"
    alias B-$i="cd \$(get-ms-build-dir)/$i"
    alias clang-check-$i="clang-check -p \$(get-ms-build-dir)/$i"
done


# for some other aliases see .zshenv
#alias P=select_work_dir
#alias select_work_dir='_ms_select_opt _ms_get_work_dirs _ms_set_work_dir "$HOME/.last-marked-work-dir"'


# Allows editing the command line with an external editor
zle -N edit-command-line
bindkey -M vicmd "v" edit-command-line

# This is a workaround for tmux. When you clear the terminal with ctrl-l
# anything on-screen is not saved (this is compatible with xterm behavior).
# In contrast, GNU screen will first push anything on-screen into the
# scrollback buffer before clearing the screen which I prefer.
function tmux-clear-screen() {
	for line in {1..$(( $LINES ))} ; do echo; done
	zle clear-screen
}
zle -N tmux-clear-screen
bindkey "^L" tmux-clear-screen


spell () {
	echo $1 | aspell -a
}


# modify the prompt to contain git branch name if applicable

autoload -U colors && colors
autoload -U promptinit && promptinit

source ~/.git-prompt.sh
export GIT_PS1_SHOWCOLORHINTS=yes
export GIT_PS1_SHOWDIRTYSTATE=yes
export GIT_PS1_SHOWUPSTREAM=auto

setopt prompt_subst prompt_percent
RPROMPT='%*%1(j.[%j].)%1(L.^%L.)'
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]

function insert-mode () { echo "-- INSERT --" }
function normal-mode () { echo "-- NORMAL --" }
function last-command-ok () { echo "%F{green}^_^%f" }
function last-command-err () { echo "%F{red}O_O%f" }

PS1_HOSTCOLOR="%F{magenta}"
if [ .$HOSTNAME = .MacBook-Pro ] ; then
	PS1_HOSTCOLOR="%F{green}"
fi

# initial value for the last command status
LAST_CMD_STATUS="%(?.$(last-command-ok).$(last-command-err))"
precmd () {
	# update last command status on each prompt display
    if [ $? -eq 0 ] ; then LAST_CMD_STATUS="$(last-command-ok)" else LAST_CMD_STATUS="$(last-command-err)" fi
	PS1="%F{green}%n@$PS1_HOSTCOLOR%m: %F{yellow}%~%f $(__git_ps1)$prompt_newline%{$terminfo_down_sc$VI_MODE$terminfo[rc]%}$LAST_CMD_STATUS %h%# "
	#TMUX_HOSTNAME="$( (hostname -s||uname -n)2>/dev/null )"
    if [ "$OSTYPE" != "cygwin" ] ; then
        # setting tmux window title on cygwin is slow
        MY_GIT_LOC="$(echo $(git rev-parse --abbrev-ref HEAD 2>/dev/null)|\
            sed -e 's/feature/f/' -e 's/bugfix/b/' -e 's/hotfix/h/' -e 's/release/r/' -e 's/f587339/-/')"
        #printf '\033kWINDOW_NAME\033\\'
        MY_LOC=$(python -c "import sys; dirs = sys.argv[1].split('/'); print(('/'.join(( (d[:1]+'*'+d[-1]) if len(d)>3 else d) for d in dirs[:-1]) + '/' + dirs[-1]) if (len(dirs)>1) else dirs[0])" "${PWD/$HOME/~}")
        tmux rename-window "${MY_LOC} ${MY_GIT_LOC:+[$MY_GIT_LOC]}" >/dev/null 2>/dev/null
    fi
}
function set-prompt () {
    case ${KEYMAP} in
      (vicmd)      VI_MODE="$(normal-mode)" ;;
      (main|viins) VI_MODE="$(insert-mode)" ;;
      (*)          VI_MODE="$(insert-mode)" ;;
    esac
	PS1="%F{green}%n@$PS1_HOSTCOLOR%m: %F{yellow}%~%f $(__git_ps1)$prompt_newline%{$terminfo_down_sc$VI_MODE$terminfo[rc]%}$LAST_CMD_STATUS %h%# "
}

# PS4 is used in xtrace mode (set -x)
#export PS4='+(${(%):-%N}:${LINENO}): ${funcstack[0]:+${funcstack[0]}(): }'
# bash equivalent would be:
export PS4='+($0|${BASH_SOURCE:-?}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

function set-title () {
	printf "\033k$1\033\\"
}

function zle-line-init zle-keymap-select {
    set-prompt
    zle reset-prompt
}
preexec () { print -rn -- $terminfo[el]; }

zle -N zle-line-init
zle -N zle-keymap-select

# select prompt theme
#prompt adam2

##
# Completion
##
autoload -U compinit && compinit # load tab-completion system, prompt
zmodload -i zsh/complist
setopt hash_list_all            # hash everything before completion
setopt complete_aliases         # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt no_complete_in_word         # do not allow completion from within a word/phrase -- too slow!
#setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

# use cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
zstyle ':completion:*' menu select=2                        # menu if nb items > 2
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
#zstyle ':completion:*::::' completer _expand _complete _match _ignored _approximate
zstyle ':completion:*::::' completer _expand _complete _match _ignored

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

zstyle ':completion:*:match:*' original only
#zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:functions' ignored-patterns '_*'

#zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
#zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
#zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "%U%B%d%b%u (errors %e)"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

#generic completion with --help
#compdef _gnu_generic gcc
#compdef _gnu_generic gdb

##
# Various
##
setopt auto_cd                  # if command is a path, cd into it
setopt auto_remove_slash        # self explicit
setopt chase_links              # resolve symlinks
setopt correct                  # try to correct spelling of commands
setopt extended_glob            # activate complex pattern globbing
setopt glob_dots                # include dotfiles in globbing
setopt print_exit_value         # print return value if non-zero
setopt interactivecomments      # allows comments on the command line
unsetopt beep                   # no bell on error
unsetopt bg_nice                # no lower prio for background jobs
unsetopt clobber                # must use >| to truncate existing files
unsetopt hist_beep              # no bell on error in history
unsetopt hup                    # no hup signal at shell exit
unsetopt ignore_eof             # do not exit on end-of-file
unsetopt list_beep              # no bell on ambiguous completion
unsetopt rm_star_silent         # ask for confirmation for `rm *' or `rm path/*'
unsetopt nomatch 				# allow [ or ] whereever you want
#setxkbmap -option compose:ralt  # compose-key
#print -Pn "\e]0; %n@%M: %~\a"   # terminal title

# grep colors
export GREP_COLOR='1;30;31'

# wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/.dircolors
eval $(dircolors -b $HOME/.dircolors)
eval $(dircolors -b $HOME/.dircolors.small | sed 's/LS_COLORS/MS_LS_COLORS_SMALL/')
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# oh-my-zsh plugins
# zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
#plugins=( zsh-syntax-highlighting)

#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zplug/init.zsh

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# fish-like history search
#zplug "zsh-users/zsh-history-substring-search"

# forgit
zplug 'wfxr/forgit'

# curl statistics made simple.
zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'

# Can manage local plugins
zplug "~/.zsh", from:local



# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose


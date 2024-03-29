# .zshenv is always sourced (for interactive and non-interactive sessions).
# It often contains exported variables that should be available to other programs.
# For example, $PATH, $EDITOR, and $PAGER are often set in .zshenv.
# Also, you can set $ZDOTDIR in .zshenv to specify an alternative location
# for the rest of your zsh configuration.


#export DISPLAY=10.0.2.2:0.0

# may be sometimes necessary to force the terminal type
#export TERM=xterm-256color

# use vim as the visual editor
export VISUAL=vim
export EDITOR=vim
export PAGER=less
#export PAGER=most
export LESS=FRX

export XDG_DATA_DIRS=/usr/share/unity:/usr/local/share:/usr/share:/var/lib/snapd/desktop:$XDG_DATA_DIRS

export MANPATH=$MANPATH:/usr/share/man:/usr/local/share/man:$HOME/usr/share/man:$HOME/usr/local/share/man
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/anaconda/bin:$PATH:$HOME/usr/bin:$HOME/usr/local/
# The maximum size of files written by the shell and its children
ulimit -f unlimited
# The maximum number of open file descriptors (most systems do not allow this value to be set)
ulimit -n 3200 # 3200 - highest number in cygwin?
#ulimit -n 4096
# The maximum size of core files created
ulimit -c unlimited

# pygmentize works fine for small files but not that great for big one
#export LESSOPEN='|pygmentize -f 256 -g %s'

#export PATH=/sbin:/usr/sbin:/usr/local/sbin:$PATH

#export LESS='-CxQai4' # for binary view -- use xless alias instead

#export CCACHE_DIR="$HOME/tmp/ccache-${USER}"
#export CCACHE_SLOPPINESS=time_macros
#export CCACHE_PREFIX=distcc

# @ before host name changes the protocol to ssh
#export DISTCC_HOSTS="--randomize --localslots=3 --localslots_cpp=6 @md/16 @mu/16"

# This is to avoid annoying error in distcc when connection over ssh in non-interactive mode.
# Note that interactive shell (.zshrc) clears this variable
#export DISTCC_TCP_CORK=0
#
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:range1=32:range2=34:locus=01:quote=01:path=01;36:fixit-insert=32:fixit-delete=31:diff-filename=01:diff-hunk=32:diff-delete=31:diff-insert=32:type-diff=01;32'

NCPU=2
command -v nproc >/dev/null 2>&1 && NCPU=$(nproc)
export MAKEFLAGS="-j${NCPU}"

function _ms_get_opts
{
	echo ""
}

function _ms_mark_opt
{
	OPT=$1
	FILE=$2
	MS_MARKED_OPT=$OPT
	PS1_MS_MARKED_OPT=$OPT
	echo $OPT >! $FILE
}

function _ms_print_opt
{
	i=$1
	o=$2
	s=$3
	infile=$4
	invar=$5

	if [ ".$infile" = ".$o" ] ; then f="-"; else f=" "; fi
	if [ ".$invar"  = ".$o" ] ; then v="*"; else v=" "; fi

	echo "[$i]$f$v $o$s"
}

function _ms_get_max_len
{
	r=0
	for o in $@ ; do
		p=${#o}
		if [ $p -gt $r ] ; then r=$p; fi
	done
	echo $r
}

function _ms_get_spaces
{
	n=$1
	r=""
	for ((i=0; i<n; i=i+1)) do
		r=" $r"
	done
	echo "$r"
}

function _ms_select_opt
{
	_ms_get_opts_fun=${1:-_ms_get_opts}
	_ms_mark_opt_fun=${2:-_ms_mark_opt}
	_ms_print_opt_fun=${3:-_ms_print_opt}
	file=${4:-$HOME/.last-ms-marked-opt}
	selected=${5}

    opts=( `$_ms_get_opts_fun` )
    test -r "$file" && infile=$(cat $file)
    invar=$MS_MARKED_OPT

	maxoptlen=$(_ms_get_max_len ${opts[*]})
    i=0
    for o in ${opts[*]}; do
        i=$((i+1))
		suffix=$(_ms_get_spaces $((maxoptlen-${#o})))
		$_ms_print_opt_fun $i "$o" "$suffix" "$infile" "$invar"
    done

	if [[ ".$selected" != ".-" ]] ; then
		if [[ $i -ge 1 ]] ; then
			echo
			opt="$selected"
			test -z "$selected" && { echo -n "Select option [1-$i]: "; read opt ; }

			if test -n "$opt"; then
				if [[ "$opt" -gt 0 ]] ; then
					val=${opts[${opt}]}
					if [[ -n "$val" ]] ; then
						echo "Selected option: ${val}"
						$_ms_mark_opt_fun "${val}" $file
					else
						echo "Wrong option: $opt"
					fi
				else
					echo "Wrong option: $opt"
				fi
			fi
		else
			echo "No option to select"
		fi
	fi
}

function _ms_get_work_dirs
{
	#ls -1d ~/dev/*
    find ~/dev/* -maxdepth 0 -type d
}

function _ms_set_work_dir
{
	OPT="$1"
	FILE="$2"
	_ms_mark_opt "$OPT" "$FILE"

    cd "$OPT"
}

function _ms_print_work_dir
{
	num=$1
	dir=$2
	suffix=$3
	infile=$4
	invar=$5

	if [ ".$infile" = ".$dir" ] ; then f="-"; else f=" "; fi
	if [ ".$invar"  = ".$dir" ] ; then v="*"; else v=" "; fi

	branch=$( (cd $dir ; git rev-parse --abbrev-ref HEAD) 2> /dev/null )
	#lastupdate=$( (cd $dir ; git log -1 --format="%ad, %h, %cn, %s" ) 2>/dev/null )
	lastupdate=$( (cd $dir ; git log -1 --color=always --format="%C(yellow)%h%Creset - %s %C(bold blue)<%an>%Creset %C(green)%aI%Creset" ) 2>/dev/null )
	echo "[$num]$f$v $dir$suffix [$branch] ($lastupdate)"
}

alias select_work_dir='_ms_select_opt _ms_get_work_dirs _ms_set_work_dir _ms_print_work_dir "$HOME/.last-marked-work-dir"' # accepts one extra arg
alias P=select_work_dir # accepts extra arg

function repeat
{
  n=$1
  shift
  while [ $(( n -= 1 )) -ge 0 ]
  do
    "$@"
  done
}


test -f "$HOME/.cargo/env" && source "$HOME/.cargo/env"

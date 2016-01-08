# .zshenv is always sourced (for interactive and non-interactive sessions).
# It often contains exported variables that should be available to other programs.
# For example, $PATH, $EDITOR, and $PAGER are often set in .zshenv.
# Also, you can set $ZDOTDIR in .zshenv to specify an alternative location
# for the rest of your zsh configuration.


export DISPLAY=10.0.2.2:0.0

# use vim as the visual editor
export VISUAL=vim
export EDITOR=vim
export PAGER=less

#export PATH=/sbin:/usr/sbin:/usr/local/sbin:$PATH

#export LESS='-CxQai4' # for binary view -- use xless alias instead

#export CCACHE_DIR="$HOME/tmp/ccache-${USER}"
#export CCACHE_SLOPPINESS=time_macros
#export CCACHE_PREFIX=distcc

# @ before host name changes the protocol to ssh
#export DISTCC_HOSTS="--randomize --localslots=3 --localslots_cpp=6 @md/16 @mu/16"

# This is to avoid annoying error in distcc when connection over ssh in non-interactive mode.
# Note that interactive shell (.zshrc) clears this variable
export DISTCC_TCP_CORK=0

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

    if [ $i -ge 1 ] ; then
        echo
        echo -n "Select option [1-$i]: "
        read opt

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
}

function _ms_get_work_dirs
{
	ls -1d ~/dev/*
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
	i=$1
	o=$2
	s=$3
	infile=$4
	invar=$5

	if [ ".$infile" = ".$o" ] ; then f="-"; else f=" "; fi
	if [ ".$invar"  = ".$o" ] ; then v="*"; else v=" "; fi

	g=$( (cd $o ; git rev-parse --abbrev-ref HEAD) 2> /dev/null )
	d=$( (cd $o ; git log -1 --format="%ad" ) 2>/dev/null )
	echo "[$i]$f$v $o$s [$g] ($d)"
}

alias select_work_dir='_ms_select_opt _ms_get_work_dirs _ms_set_work_dir _ms_print_work_dir "$HOME/.last-marked-work-dir"'
alias P=select_work_dir

function repeat
{
  n=$1
  shift
  while [ $(( n -= 1 )) -ge 0 ]
  do
    "$@"
  done
}



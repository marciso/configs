# `.zlogin' is sourced in login shells.
# It should contain commands that should be executed only in login shells.
# (Note: `.zprofile' is similar to `.zlogin', except that it is sourced before `.zshrc'.)

if [[ -o interactive ]] ; then
  cal

  command -v cowsay >/dev/null 2>&1 && command -v fortune >/dev/null 2>&1 && cowsay -p `fortune`

  echo "tmux sessions:"
  tmux ls
fi

#setup_autossh(){
#  sport
#}

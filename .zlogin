# `.zlogin' is sourced in login shells.
# It should contain commands that should be executed only in login shells.
# (Note: `.zprofile' is similar to `.zlogin', except that it is sourced before `.zshrc'.)

cal

cowsay -p `fortune`

echo "tmux sessions:"
tmux ls

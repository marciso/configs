
# install:
#   wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
# then run it

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/marciso/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
   eval "$__conda_setup"
else
   if [ -f "/home/marciso/anaconda3/etc/profile.d/conda.sh" ]; then
       . "/home/marciso/anaconda3/etc/profile.d/conda.sh"
   else
       export PATH="/home/marciso/anaconda3/bin:$PATH"
   fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda update conda
conda update anaconda


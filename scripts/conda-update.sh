
# install:
#   wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
# then run it

update_conda() {
    CONDA_PATH=$1
    PREFIX=$2
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('${CONDA_PATH}/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
       eval "$__conda_setup"
    else
       if [ -f "${CONDA_PATH}/etc/profile.d/conda.sh" ]; then
           . "${CONDA_PATH}/etc/profile.d/conda.sh"
       else
           export PATH="${CONDA_PATH}/bin:$PATH"
       fi
    fi
    which conda
    unset __conda_setup
    # <<< conda initialize <<<

    $PREFIX conda update conda
    $PREFIX conda update anaconda
}

#update_conda /home/marciso/anaconda3
update_conda /usr/local/anaconda sudo


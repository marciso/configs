#!/bin/bash

set -e

#test -f /opt/rh/rh-python38/enabel && source /opt/rh/rh-python38/enable
#test -f /opt/rh/devtoolset-9/enable && source /opt/rh/devtoolset-9/enable

should_patch_bin_to_be_nice=1
should_rebuild_clangd=1

ycm_dir=$HOME/.vim/bundle/YouCompleteMe
ycm_clangd_dir=$ycm_dir/third_party/ycmd/third_party/clangd/output

cd $ycm_dir
python3 install.py --clangd-completer

# override clangd - original verion requires newer libc and libstdc++,
# so we compile our version

if ((should_rebuild_clangd)) ; then
    llvm_bulild_dir=$HOME/external/llvm/build

    test -f $llvm_bulild_dir/bin/clangd || $HOME/scripts/compile-clangd.sh

    cp -av $llvm_bulild_dir/bin/clangd $ycm_clangd_dir/bin/clangd
fi

if ((should_patch_bin_to_be_nice)) ; then
    # now, let's patch it:
    mv -v $ycm_clangd_dir/bin/clangd{,.bin}

    cat > $ycm_clangd_dir/bin/clangd <<__END__
#!/bin/bash

DIR="\$( cd "\$( dirname "\${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
exec nice \$DIR/clangd.bin "\$@"
__END__

    chmod -v a+x $ycm_clangd_dir/bin/clangd
    echo "PATCHED: $ycm_clangd_dir/bin/clangd"
fi

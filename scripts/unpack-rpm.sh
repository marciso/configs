
file=${1:?"Missing argument: rpm file path"}

rpm2cpio $file | cpio -imdv

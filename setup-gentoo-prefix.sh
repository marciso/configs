dst_dir=${HOME:-~}

lynx -source https://gitweb.gentoo.org/repo/proj/prefix.git/plain/scripts/bootstrap-prefix.sh > ${dst_dir}/bootstrap-prefix.sh
chmod a+x ${dst_dir}/bootstrap-prefix.sh

${dst_dir}/bootstrap-prefix.sh



# DIR="$( cd "$( dirname "$( readlink -f ${BASH_SOURCE[0]})" )" >/dev/null 2>&1 && pwd )"

dst_dir=${HOME:-~}

lynx -source https://gitweb.gentoo.org/repo/proj/prefix.git/plain/scripts/bootstrap-prefix.sh > ${dst_dir}/bootstrap-prefix.sh
chmod a+x ${dst_dir}/bootstrap-prefix.sh

${dst_dir}/bootstrap-prefix.sh


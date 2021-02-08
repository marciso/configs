#!/bin/sh

input=compile_commands.json
output_for_vim=include_paths.vim
output_txt=include_paths.txt

sed -e 's/-isystem /-isystem_/g' "$input" | tr ' ' '\n' | grep '^-isystem_' | sed -e 's/-isystem_//' | sort -u > $output_txt
# does not handle relative paths correctly e.g. _build/generated.files are
# relative to the compile_commands.json _original_ position (the version
# at the root directory is a copy from the build dir)
cat $output_txt | sed 's/^/set path+=/' > $output_for_vim

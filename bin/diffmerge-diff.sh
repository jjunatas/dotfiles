#!/bin/sh

path=$1
old=$1
new=$2
diffMerge="/Users/cjharrelson/Applications/DiffMerge.app/Contents/MacOS/DiffMerge"

# echo -e "path\n$path"
# echo -e "old\n$old"
# echo -e "new\n$new"

$diffMerge "$old" "$new" --title1="Old" --title2="New"
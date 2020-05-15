#!/usr/bin/env sh

git fetch --quiet

checkout(){
    
    local i=1
    for branch in "$($1 2>&1)"
    do
        if [ -z "$2" ]
        then
            echo "[$i] $branch"
        else
            echo $2
        fi
        ((i=i+1))
    done
}

checkout "git branch -a --column"
exit 0

my_string=$(git branch -a 2>/dev/null | colrm 1 2  )
my_array=($(echo $my_string | tr "\n" "\n"))
i=1
for branch in "${my_array[@]}"
do
    echo "[$i] $branch"
    ((i=i+1))
done

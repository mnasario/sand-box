#!/usr/bin/env sh

GREEN='\033[0;32m'
NC='\033[0m' # No Color

showCurrent(){
    currentBranch=$(git branch --show-current)
    echo "\n\t${GREEN} *  $currentBranch ${NC}"
}

checkout(){
    
	local branchString=$($1 2>/dev/null | colrm 1 2  | perl -pe 's/remotes\/origin\/HEAD\s\->\s/remotes\/origin\/HEAD\->/g' )
	local branchArray=($(echo $branchString | tr "\n" "\n"))
	local i=1
	for branch in "${branchArray[@]}"
	do
	    if [[ $branch != *"HEAD"* ]] && [ "$branch" != "$currentBranch" ]
	    then
            if [ -z $2 ]
            then
                
                echo "\t[$i] $branch"

            elif [ "$i" == "$2" ]
            then
                
                git checkout "$branch"
                exit 0
                
            fi
	        ((i=i+1))
	    fi
	done
	echo ""
}

git fetch --quiet
showCurrent
checkout "git branch -a"
read -p 'Select branch number: ' branchNumber
checkout "git branch -a" $branchNumber
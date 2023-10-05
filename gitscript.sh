#!/bin/bash
readarray -t my_array < <(git ls-files)
for i in "${my_array[@]}"
do
	git commit -m "$i" $i
	git push -u origin main
done

#Commits and pushes all files one by one.
#Used when commits would otherwise exceed 2GB of size, causing refusal by git.
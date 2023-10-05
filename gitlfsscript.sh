#!/bin/bash
readarray -t my_array < <(git ls-files)
for i in "${my_array[@]}"
do
	FILENAME="./"
	FILENAME+=$i
	FILESIZE=$(stat -c%s "$FILENAME")
	if [[ $FILESIZE -ge 104857600 ]]
	then
		git lfs track $i
		git commit -m "Commit LFS-File" $i
		git push -u origin main
	else
		git commit -m "Commit Regular File" $i
		git push -u origin main
	fi
done

#Commits and pushes all files one by one, respecting git lfs requirements.
#Used when commits would otherwise exceed 2GB of size, causing refusal by git.

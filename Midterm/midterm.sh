#!/bin/bash
#creates a list of directories from the $PATH variable (in $PATH the names are colon separated)
IFS=: read -ra pathlist <<< "$PATH"

#checks command option
if [[ $1 == 'b' ]]
then
	#creates the parent directory in HOME to store the sticky bit files
	[[ -d $HOME/midterm ]] || mkdir $HOME/midterm
	for dir in "${pathlist[@]}"; do
		#creates a local copy of the PATH directory structure
		[[ -d $HOME/midterm$dir ]] || mkdir -p $HOME/midterm$dir
		for file in "$dir"/*; do
			#checks to ensure the file is a program with the owner sticky bit set
			if [[ -x $file && -f $file && -g $file ]]
			then
				#echo filename for debugging and create a local copy of the file
				#with permissions retained (including sticky bit), then remove the bit
				#from the original file
				echo "$file"
				cp -rp $file $HOME/midterm$dir
				chmod g-s $file
			fi
		done
	done
#checks command option
elif [[ $1 == 'r' ]]
then
	for dir in "${pathlist[@]}"; do
		#copies every stored file with permissions back to their
		#respective locations in PATH
		for file in $HOME/midterm$dir/*; do
			cp -rp $file $dir
		done
	done
#if no options are selected
else
	echo "please either use b option for backup or r for recover"
fi


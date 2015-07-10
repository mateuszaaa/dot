#!/bin/bash
# v0.05

projectName=""
pathToProject=""
pathToConf="$HOME/.config/nsn-config.conf"
bm_info_mode_src="bm/info_model/src"
BTS_SC_BM_dir=""
Platform_Env_path="Platform_Env"
Global_Env_path="Global_Env"
DEPTH_FOR_RECURSIVE_SEARCH_OF_PROJECT_FILES="4"
already_have_project_files=0

if [ -f $pathToConf ]; then
	source $pathToConf
else
	echo "There is no config file: $HOME/.config/nsn-config.conf"
fi

info(){
	echo -e "\n\tScript for (re)generating project files used by qtcreator\nUsage: $0 path_to_proj"
	echo -e "or run it in project's dir\n"
}

removeTrailingSlash(){
	echo ${1%/}
}

checkIfBTS_SC_BM(){
	if [[ `ls $pathToProject` =~ "BTS_SC_BM" ]]; then
		BTS_SC_BM_dir="BTS_SC_BM/"
	fi
}

findProjectName(){
	if [ "$projectName" == "" ]; then
		for file in `ls $pathToProject`
		do
			if [[ $file =~ ".creator" ]] || [[ $file =~ ".files" ]] || [[ $file =~ ".includes" ]]  || [[ $file =~ ".creator.user" ]]; then
				projectName=`echo $file | sed 's/.creator.*//g' | sed 's/.files.*//g' | sed 's/.includes.*//g' | sed 's/.creator.user.*//g'`
				echo "Old project file: $file"
				already_have_project_files=1
			fi
		done
	fi
	if [ "$projectName" == "" ]; then
		if [ "$pathToProject" == "." ] || [ "$pathToProject" == "" ] ; then
			placeOf=`pwd`
			echo "PlaceOf: $placeOf"
			projectName=$(basename "$placeOf")
		else
			echo "pathToProject: $pathToProject"
			projectName=`basename $pathToProject`
		fi
	fi
	echo "Project name: $projectName"
	if [ "$projectName" == "" ]; then
		echo "Something went wrong, projectName is empty!!"
		exit 1
	fi
}

checkIfAnythingToDo(){
	if [ ! $BTS_SC_BM_dir == "" ];then
		echo "Have BTS_SC_BM dir, acting then"
		return
	elif [ $already_have_project_files -eq 1 ]; then
		echo "Have old project files, acting then"
		return
	elif [[ ! $(find $pathToProject -maxdepth $DEPTH_FOR_RECURSIVE_SEARCH_OF_PROJECT_FILES -name *.h -o -name *.cpp) == "" ]]; then
		echo "Found c++ code files, acting then"
		return
	elif [[ ! $(find $pathToProject -maxdepth 1 -name *.sh) == "" ]]; then
		echo "Found sh files, acting then"
		return
	else
		echo "Can't find project's dir. Dying"
		exit 1;
	fi
}

getProtobuf(){
	echo -e "\t Protobufs"
	if [ "$pathToWrlingsBmCode" == "" ]; then
		echo -e "Path to bm on wrling not set, \n\tdo ex. echo \"pathToWrlingsBmCode=/work/$USER/some_path/bm\" >> $HOME/.config/nsn-config.conf"
		return
	fi
	if [ "$userOnWrling" == "" ]; then
		echo -e "Username on wrling not set, \n\tdo ex. echo \"userOnWrling=$USER\" >> $HOME/.config/nsn-config.conf"
		echo "Using your local name"
		userOnWrling=$USER
	fi
	if [ "$hostWrling" == "" ]; then
		echo -e "Hostname of wrling not set, \n\tdo ex. echo \"hostWrling=wrling110.emea.nsn-net.net\" >> $HOME/.config/nsn-config.conf"
		return
	fi
	if [ -d "$pathToOutput""$BTS_SC_BM_dir""$bm_info_mode_src" ]; then
		echo "Generating protobuf on wrling"
		cmdToGenProto="make -C $pathToWrlingsBmCode protogen"
		ssh $userOnWrling@$hostWrling "$cmdToGenProto" > /dev/null
		echo "Copying proto to ""$pathToOutput""$BTS_SC_BM_dir""$bm_info_mode_src"
		SSH="-e \"ssh\""
		rsync $SSH -a --no-o --no-g $userOnWrling@$hostWrling:$pathToWrlingsBmCode/info_model/src/proto "$pathToOutput""$BTS_SC_BM_dir""$bm_info_mode_src"
	else
		echo -e "\n\tThere is no "$pathToOutput""$BTS_SC_BM_dir""$bm_info_mode_src" in project_dir!\n\t You can't have protobufs!\n"
	fi
}

createCreator(){
	if [ ! -e $pathToOutput$projectName.creator ]; then
		touch $pathToOutput$projectName.creator
	fi
}

createFiles(){
	# Files
	echo -e "\tCreating $pathToOutput$projectName.files"
	backupFile $pathToOutput$projectName.files
	if [ "$pathToProject" == "" ]; then 
		pathToProjectsFind="."
	else
		pathToProjectsFind="$pathToProject"
	fi
	 find $pathToProjectsFind -not -path $pathToProjectsFind/"$BTS_SC_BM_dir"3rdparty"/*" -not -path $pathToProjectsFind/"$BTS_SC_BM_dir"3rdparty_tools"/*" -not -path $pathToProjectsFind/"$Global_Env_path""/*" -not -path $pathToProjectsFind/"$Platform_Env_path""/*" -not -path $pathToProjectsFind/"$BTS_SC_BM_dir""tools""/*" "(" -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.ttcn3" ")" | sed 's/^.\///g' >   $pathToOutput$projectName.files
}

createIncludes(){
	# Includes
	echo -e "\tCreating $pathToOutput$projectName.includes"
	backupFile $pathToOutput$projectName.includes
	if [ "$pathToProject" == "" ]; then
		pathToProjectsFind="."
	fi
	find $pathToProjectsFind -not -path $pathToProjectsFind/"$BTS_SC_BM_dir"3rdparty"/*" -not -path $pathToProject"$BTS_SC_BM_dir"3rdparty_tools"/*" \( -name "*.h*" -not -name "*3rdparty_tools" -not -name "*.svn*" -not -name "k3" \) -exec dirname {} \; |grep -v 'boost\|.svn\|3rdparty' |sort | uniq | sed 's/^.\///g' > $pathToOutput$projectName.includes

	# Include upper dirs also
	allDirs=`cat $pathToOutput$projectName.includes`
	for line in $allDirs
	do
		upperDirs="$upperDirs\n$line\n`dirname $line`"
	done
	echo -e $upperDirs | sort |uniq > $pathToOutput$projectName.includes

	# Include Global_Env and Platform_Env if they are higher than git
	addEnvsIfAvailable
	
	# Include 3rdparty
	echo "$pathToOutput""$BTS_SC_BM_dir""3rdparty/include" >> $pathToOutput$projectName.includes
}

addEnvsIfAvailable(){
	echo "Looking for envs"
	upperContent="Global_Env"
	FOUNDED_DIRS=`find "$pathToProjectsFind/.." -maxdepth 1 -type d -name "$Platform_Env_path" -o -name "$Global_Env_path"`
	if [ "$FOUNDED_DIRS" != "" ]; then
		echo "BTS_SC_BM_dir $BTS_SC_BM_dir"
		for i in $FOUNDED_DIRS; do
			find $i  -maxdepth 5 -not -path $pathToProjectsFind/"$BTS_SC_BM_dir" \( -name "*.h*" -not -name "*.svn*" \) -exec dirname {} \; |sort | uniq | sed 's/^.\///g' >> $pathToOutput$projectName.includes
		done
	else
		echo "There is no envs in $pathToProjectsFind/.."
	fi
}

backupFile(){
	if [ -f $1_bak ] && [ -f $1 ]; then
		echo "rmBackuping: $1"
		rm $1_bak
		mv $1 $1_bak
	elif [ -f $1 ]; then
		echo "Backuping: $1"
		mv $1 $1_bak
	else
		echo "Unable to backup: $1"
	fi
}

if [ $# -lt 1 ]; then
	info
	pathToOutput=""
elif [[ $1 =~ "help" ]]; then
	info
	exit 0
else
	pathToProject="$1"
	pathToProject=`removeTrailingSlash $pathToProject`
	pathToOutput="$pathToProject/"
fi

echo -e "\nProject's root: $pathToProject \nCreating files in: $pathToOutput"

checkIfBTS_SC_BM
findProjectName
checkIfAnythingToDo
getProtobuf
createCreator
createFiles
createIncludes

echo -e "$0 \tDone"

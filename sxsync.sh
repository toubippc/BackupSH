#!/bin/bash

# sxsync by Christophe Casalegno / Brain 0verride
# https://www.christophe-casalegno.com
# https://twitter.com/Brain0verride
# review by Gilles Jean-Marie @toubippc

excludedfile="exclude.txt"
typesync="$1"
sshport="$6"
sshkey="$7"

function antesync()

{
	declare -A tab

	user=$1
	ipdst=$2
	dirsrc=$3
	dirdst=$4

	if [ -e $sshkey ]
	then
		sshkeyfile="-i $sshkey"
	fi

	if [ -e $excludedfile ]

	then

		excludeme=$(cat $excludedfile)

		for expression in $excludeme
		do
			tab["$expression"]=" --exclude=$expression "

		done

	else
		 echo "Exclude file not present"
	fi

	rsync -Harouv --stats --progress --delete -e "ssh $sshkeyfile -p $sshport" ${tab[@]} "$dirsrc" "$user"@"$ipdst":"$dirdst"
}


function retrosync()

{
	declare -A tab

	user=$1
	ipsrc=$2
	dirsrc=$3
	localdirdst=$4

        if [ -e $sshkey ]
	then
                sshkeyfile = "-i $sshkey"
        fi

	if [ -e $excludedfile ]

	then

		excludeme=$(cat $excludedfile)

		for expression in $excludeme
		do
			tab["$expression"]=" --exclude=$expression "

		done

	else
		 echo "Exclude file not present"
	fi

	rsync -Harouv --stats --progress --delete -e "ssh $sshkeyfile -p $sshport" ${tab[@]} "$user"@"$ipsrc":"$dirsrc" "$localdirdst" 

}

if [[ $typesync = "antesync" ]]

then

	antesync "$2" "$3" "$4" "$5"

elif [[ $typesync = "retrosync" ]]

then

	retrosync "$2" "$3" "$4" "$5"

else

	echo "./sxsync.sh typesync(antesync or retrosync) user ip/host srcdirectory dstdirectory sshport sshkeyfile"
	echo ""
	echo "example: ./sxsync.sh retrosync brain 192.168.0.1 /home/brain/ /home/chris/ 65022 .ssh/id_rsa"
	echo ""
	echo "Note: if you have exclude liste create exclude.txt and one line par rule cf:"
	echo "
	/home/toto
	/home/tata/exclude.cfg
	/home/titi/blabla
	/home/www/sites
	"

fi

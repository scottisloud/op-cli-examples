#!/bin/bash

# this script will list a group and every vault that group has access to. 

opGroups=$(op list groups -- cache | jq -r '.[].uuid')

groupVaultAccess(){
	while read -r line 
	do
		groupName=$(op get group $line | jq -r '.name')
		echo 'GROUP: ' $groupName
		
		groupVaults=$(op list vaults --group $line | jq -r '.[].name')
		echo 'VAULTS: ' $groupVaults "\n\n"
		
	done < <(printf '%s\n' $opGroups)
}


groupVaultAccess
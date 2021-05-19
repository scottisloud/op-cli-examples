#!/bin/bash



# Get a list of all group UUIDs
opGroups=$(op list groups -- cache | jq -r '.[].uuid')

# List each group and every vault that group has access to
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
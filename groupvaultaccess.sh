#!/bin/bash



# Get a list of all group UUIDs
opGroups=($(op1 list groups --cache | jq -r '.[].uuid'))

# List each group and every vault that group has access to

for group in $opGroups
do
	groupName=$(op1 get group $group | jq -r '.name')
	echo 'GROUP: ' $groupName
	
	groupVaults=$(op1 list vaults --group $group | jq -r '.[].name')
	echo 'VAULTS: ' $groupVaults "\n\n"
	
done

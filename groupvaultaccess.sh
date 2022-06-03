#!/bin/bash

# Get a list of all group UUIDs
opGroups=($(op list groups --cache | jq -r '.[].uuid'))

# List each group and every vault that group has access to

for group in $opGroups
	do
		groupName=$(op get group $group | jq -r '.name')
		echo 'GROUP: ' $groupName
		
		groupVaults=$(op list vaults --group $group | jq -r '.[].name')
		echo 'VAULTS: ' $groupVaults "\n\n"
		
	done

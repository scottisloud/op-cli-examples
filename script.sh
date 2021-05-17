#!/bin/bash

# This will output to a CSV formatted as:
# user [user name]
# groups [group1,group2....]
# vaults [vault1,vault2...]
# user [user name]
# groups [group1,group2....]
# vaults [vault1,vault2...]

opusers=$(op list users --cache | jq --raw-output '.[].uuid')


whileExport(){
	while read -r line
		do
			userName=$(op get user $line | jq --raw-output '.name')  # gets user's name based on UUID
			echo 'USER:' $userName >> useraccess.txt
		
			# GROUPS - For each group the person is a member of, append it to a variable separated by a comma, then append the entire string to a csv file
			userGroups=$(op list groups --user $line | jq --raw-output '.[].name')
			echo 'GROUPS:' ${userGroups//$'\n'/', '} >> useraccess.txt
		
			# VAULTS - For each vault the person has access to, append it to a variable separated by a comma, then append the entire string to a csv file
			userVaults=$(op list vaults --user $line | jq --raw-output '.[].name')
			echo 'VAULTS:' ${userVaults//$'\n'/', '} "\n\n" >> useraccess.txt
	
		done < <(printf '%s\n' $opusers)
}

whileExport









# simpleExport(){
# 
# 	for user in $opusers
# 		do
# 			userName=$(op get user $user --cache | jq --raw-output '.name')  # gets user's name based on UUID
# 			echo 'user', $userName,  >> test.csv
# 			
# 			# GROUPS - For each group the person is a member of, append it to a variable separated by a comma, then append the entire string to a csv file
# 			userGroups=$(op list groups --user $user --cache | jq --raw-output '"\(.[].name),"')
# 			echo 'groups', ${userGroups/'" "'/','} >> test.csv
# 		
# 			# VAULTS - For each vault the person has access to, append it to a variable separated by a comma, then append the entire string to a csv file
# 			userVaults=$(op list vaults --user $user --cache | jq --raw-output '"\(.[].name),"')
# 			echo 'vaults', ${userVaults/'" "'/'","'} >> test.csv	
# 		done
# 
# }



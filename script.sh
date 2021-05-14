#!/bin/bash

# function_test(){
# 	echo "this is the first line of the function"
# 	test="variable value"
# 	echo $test
# }
# 
# function_test

opusers=$(op list users --cache | jq --raw-output '.[].uuid')
opusernames=$(op list users --cache | jq --raw-output '.[].name')

	

# This will output to a CSV formatted as:
# user [user name]
# groups [group1,group2....]
# vaults [vault1,vault2...]
# user [user name]
# groups [group1,group2....]
# vaults [vault1,vault2...]
simpleExport(){

	for user in $opusers
		do
			userName=$(op get user $user --cache | jq --raw-output '.name')  # gets user's name based on UUID
			echo 'user', $userName >> test.csv
			
			# GROUPS - For each group the person is a member of, append it to a variable separated by a comma, then append the entire string to a csv file
			userGroups=$(op list groups --user $user --cache | jq --raw-output '"\(.[].name),"')
			echo 'groups', ${userGroups/'" "'/','} >> test.csv
		
			# VAULTS - For each vault the person has access to, append it to a variable separated by a comma, then append the entire string to a csv file
			userVaults=$(op list vaults --user $user --cache | jq --raw-output '"\(.[].name),"')
			echo 'vaults', ${userVaults/'" "'/'","'} >> test.csv	
		done

}


whileExport(){
	while IFS='' read -r line
	do
		userName=$(op get user $line --cache | jq --raw-output '.name')  # gets user's name based on UUID
		echo 'user', $userName >> test.csv
		
		# GROUPS - For each group the person is a member of, append it to a variable separated by a comma, then append the entire string to a csv file
		userGroups=$(op list groups --user $line --cache | jq --raw-output '"\(.[].name),"')
		echo 'groups', ${userGroups/'" "'/','} >> test.csv
		
		# VAULTS - For each vault the person has access to, append it to a variable separated by a comma, then append the entire string to a csv file
		userVaults=$(op list vaults --user $line --cache | jq --raw-output '"\(.[].name),"')
		echo 'vaults', ${userVaults/'" "'/'","'} >> test.csv
	done < <(echo $opusers)
}

whileExport


# testVariable="one
# two
# three"
# 
# 
# 
# while read -r line 
# 	do
# 		echo $line
# 	done < <(echo $opusers)
# simpleExport

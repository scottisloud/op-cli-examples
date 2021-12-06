#!/bin/bash

vaultUUID='pkkyevap5rwsscvulp56zlxcqq'
newURL='https://bluemountainsit.com/holidays/index.php'
myItem='comkpot2qvbiox47o6bjvthkeu'

# Get all UUID's into a variable
itemUUID=($(op item list --vault $vaultUUID --format=json | jq --raw-output '.[].id'))

#Loop through and add URL - CURRENTLY ADDS A NEW SECTION INSTEAD OF MODIFYING
# for item in $itemUUID 
# do
# 	op item edit $item \ website=https://bluemountainsit.com/holidays/index.php --dry-run
# done


for item in $itemUUID
do
	op item edit $item url[delete] --dry-run
done
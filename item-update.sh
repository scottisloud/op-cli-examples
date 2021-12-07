#!/bin/bash
#THIS SCRIPT UPDATES OR ADDS THE VALUE OF THE WEBSITE FIELD FOR ALL ITEMS IN A SPECIFIED VAULT

vaultUUID=<some vault UUID>
newURL='https://example.com'

# Get all UUID's into a variable
itemUUID=($(op item list --vault $vaultUUID --format=json | jq --raw-output '.[].id'))

#Loop through and add URL
for item in $itemUUID
do
	op item edit $item website=$newURL
done
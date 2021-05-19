

# List all items in private vault
op list items --categories Login --vault Private | jq

# Get a list of all users' first names 
op list users | jq '.[] | {fname: .firstName}'

# Create Item in Private Vault
op create item Login --title "OmniFocus" username="scottisloud" password=--generate-password url="https://omnigroup.com"

# Invite a new user
op create user "[some real email address]" "[some great name]"

# Confirm Users
op confirm --all

# Get name and email of everyone that belongs to the Team Leads group
op list users --group "Team Leads" | op get user - | jq '.name, .email'

# get the details for all vaults that the Managers group has access to
op list vaults --group Managers | op get vault - | jq


# Create a csv with specific fields for items in a specific vault.  
op list items --categories Login --vault Private | op get item - --fields title,website,username,password --format CSV

# Get event ID, action, actor, and time in CSV format. 
op list events | jq -r 'map([.eid, .action, .actorUuid, .time] | join(", ")) | join("\n")'

## run the custom script to get users, vaults, groups
. ./uservaultaccess.sh

. ./groupvaultaccess.sh

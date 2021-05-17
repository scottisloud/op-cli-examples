# Get to correct directory
cd /Users/scottatwork/op-cli-examples

# Sign into 1Password
eval $(op signin onboarding)


# List all items in private vault
op list items --categories Login --vault Private | jq

# Get a list of all users' first names 
op list users | jq '.[] | {fname: .firstName}'

# Create Item in Private Vault
op create item Login --title "OmniFocus" username="scottisloud" password=--generate-password url="https://omnigroup.com"

# Invite a new user
op create user "scott.lougheed+cli@agilebits.com" "1Password Rulez"

# Confirm Users
op confirm --all

# Get name and email of everyone that belongs to the Team Leads group
op list users --group "Team Leads" | op get user - | jq '.name, .email'




### Live Demo ###
#################
# get to correct directory
cd /Users/scottatwork/op-cli-examples

# Create a csv with specific fields for items in a specific vault.  
op list items --categories Login --vault Private | op get item - --fields website,username,password --format CSV > export.csv

# get the details for all vaults that the Managers group has access to
op list vaults --group Managers | op get vault - | jq

## run the custom script to get users, vaults, groups
. ./script.sh
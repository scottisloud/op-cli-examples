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



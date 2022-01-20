#!/bin/bash

<<<<<<< HEAD
source "${BASH_SOURCE%/*}/.scripts/required.sh"

DFX_IDENTITY_PRINCIPAL=""

# The extra space is intentional, used for alignment
read -r -p "🤖 Is it ok to set dfx to use the default identity (required) [Y/n]? " CONT

if [ "$CONT" = "Y" ]; then
  dfx identity use default

  DFX_IDENTITY_PRINCIPAL=$(dfx identity get-principal)

  printf "🌈 The DFX Identity is set to (%s)\n\n" "$DFX_IDENTITY_PRINCIPAL"
else
  printf "🚩 The default Identity is a requirement, I'm afraid.\n\n"

  exit 1;
fi

dfxDir="$HOME/.config/dfx"
NftCandidFile="./nft/candid/nft.did"

NftID=""

# PEM files
=======
cd "$(dirname "${BASH_SOURCE[0]}")" || exit;

dfxDir="$HOME/.config/dfx"
<<<<<<<< HEAD:healthcheck.sh
NftCandidFile="./nft/candid/nft.did"
========
candidDir="../../nft/candid"
>>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck):nft/scripts/test.sh

NftID=""
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
DefaultPem=""
AlicePem=""
BobPem=""

<<<<<<< HEAD
=======
NftCandidFile="${candidDir}/nft.did"
DefaultPrincipalId=$(dfx identity use Default 2>/dev/null;dfx identity get-principal)
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
AlicePrincipalId=""
BobPrincipalId=""
CharliePrincipalId=""

AliceAccountId=""
BobAccountId=""
CharlieAccountId=""
<<<<<<< HEAD

IcxPrologueNft="--candid=${NftCandidFile}"

deploy() {
  printf "🤖 Deploying the NFT Canister\n"

  dfx deploy --no-wallet nft --argument "(principal \"$DFX_IDENTITY_PRINCIPAL\", \"tkn\", \"token\", principal \"$CANISTER_CAP_ID\")"

  printf "\n\n"
=======
IcxPrologueNft="--candid=${NftCandidFile}"
<<<<<<<< HEAD:healthcheck.sh

# dfx identity use default 2>/dev/null

nameToPrincipal=""

deploy() {  
  eval "dfx deploy cap"

  principal=$(dfx identity get-principal)
  # cap_principal=$(cat .dfx/local/canister_ids.json | jq ".cap.local" -r)
  cap_principal=$(cat ./.temp/ic-history-router-id)
========
dfx identity use default 2>/dev/null

nameToPrincipal=""

deploy() {
  eval "dfx deploy cap"
  principal=$(dfx identity get-principal)
  cap_principal=$(cat .dfx/local/canister_ids.json | jq ".cap.local" -r)
>>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck):nft/scripts/test.sh
  
  echo "principal: $principal"
  echo "cap_principal: $cap_principal"
  #fn init(owner: Principal, symbol: String, name: String, history: Principal)
  echo "dfx deploy nft --argument '(principal \"$principal\", \"tkn\", \"token\", principal \"$cap_principal\")'"

  eval "dfx deploy nft --argument '(principal \"$principal\", \"tkn\", \"token\", principal \"$cap_principal\")'"
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
}

# deploy

init() {
<<<<<<< HEAD
  printf "🤖 Initialisation of environment process variables\n"
=======
  # DefaultAccountId=$(dfx identity use default 2>/dev/null;dfx ledger account-id)
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)

  DefaultPem="${dfxDir}/identity/default/identity.pem"

  NftID=$(dfx canister id nft)

<<<<<<< HEAD
  # ⚠️ Warning: This changes the identity state, set back to initial state afterwards
=======
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
  AlicePrincipalId=$(dfx identity use Alice 2>/dev/null;dfx identity get-principal)
  BobPrincipalId=$(dfx identity use Bob 2>/dev/null;dfx identity get-principal)
  CharliePrincipalId=$(dfx identity use Charlie 2>/dev/null;dfx identity get-principal)

  AlicePem="${dfxDir}/identity/Alice/identity.pem"
  BobPem="${dfxDir}/identity/Bob/identity.pem"
<<<<<<< HEAD
=======
  # CharliePem="${dfxDir}/identity/Charlie/identity.pem"
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)

  AliceAccountId=$(dfx identity use Alice 2>/dev/null;dfx ledger account-id)
  BobAccountId=$(dfx identity use Bob 2>/dev/null;dfx ledger account-id)
  CharlieAccountId=$(dfx identity use Charlie 2>/dev/null;dfx ledger account-id)

<<<<<<< HEAD
  # ⚠️ Warning: Resets the identity state
  dfx identity use default

  printf "\n"
}

info() {
  printf "🤖 Process Principal info\n"

  printf "🙋‍♀️ Principal ids\n"
  printf "Alice: %s\n" "$AlicePrincipalId"
  printf "Bob: %s \n" "$BobPrincipalId"
  printf "Charlie %s\n" "$CharliePrincipalId"

  printf "\n"

  printf "🙋‍♀️ Account ids\n"
  printf "Alice: %s\n" "$AliceAccountId"
  printf "Bob: %s\n" "$BobAccountId"
  printf "Charlie: %s\n" "$CharlieAccountId"

  printf "\n"
}

####################################
#
# BEGIN OF DIP-721
# Find the specification in https://github.com/Psychedelic/DIP721/main/docs/spec.md
#
####################################

mintDip721() {
  printf "🤖 Call the mintDip721\n"

  mint_for="${AlicePrincipalId}"

  icx --pem="$DefaultPem" update "$NftID" mintDip721 "(principal \"$mint_for\", vec{})" "$IcxPrologueNft"

  printf "\n"
}

supportedInterfacesDip721() {
  printf "🤖 Call the supportedInterfacesDip721\n"

  icx --pem="$DefaultPem" query "$NftID" supportedInterfacesDip721 "()" $IcxPrologueNft
}

nameDip721() {
  printf "🤖 Call the nameDip721\n"
  
  icx --pem="$DefaultPem" query "$NftID" nameDip721 "()" $IcxPrologueNft
}

symbolDip721() {
  printf "🤖 Call the symbolDip721\n"
  
  icx --pem="$DefaultPem" query "$NftID" symbolDip721 "()" $IcxPrologueNft
}

balanceOfDip721() {
  printf "🤖 Call the balanceOfDip721\n"

  user="${AlicePrincipalId}"

  icx --pem="$DefaultPem" query "$NftID" balanceOfDip721 "(principal \"$user\")" $IcxPrologueNft
}

ownerOfDip721() {
  printf "🤖 Call the ownerOfDip721\n"

  token_id="0"
  icx --pem="$AlicePem" query "$NftID" ownerOfDip721 "($token_id)" $IcxPrologueNft
}

safeTransferFromDip721() {
  printf "🤖 Call the safeTransferFromDip721\n"

  from_principal="${BobPrincipalId}"
  to_principal="${AlicePrincipalId}"
  token_id="0"

  icx --pem="$BobPem" update "$NftID" safeTransferFromDip721 "(principal \"$from_principal\", principal \"$to_principal\", $token_id)" "$IcxPrologueNft"
}

transferFromDip721() {
  printf "🤖 Call the transferFromDip721\n"
  
  from_principal="${AlicePrincipalId}"
  to_principal="${BobPrincipalId}"
  token_id="0"

  icx --pem="$AlicePem" update "$NftID" transferFromDip721 "(principal \"$from_principal\", principal \"$to_principal\", $token_id)" "$IcxPrologueNft"
}

logoDip721() {
  printf "🤖 Call the logoDip721\n"

  icx --pem="$DefaultPem" query "$NftID" logoDip721 "()" "$IcxPrologueNft"
}

totalSupplyDip721() {
  printf "🤖 Call the totalSupplyDip721\n"

  icx --pem="$DefaultPem" query "$NftID" totalSupplyDip721 "()" "$IcxPrologueNft"
}

getMetadataDip721() {
  printf "🤖 Call the getMetadataDip721\n"

  token_id="0"
  
  icx --pem="$DefaultPem" query "$NftID" getMetadataDip721 "($token_id)" "$IcxPrologueNft"
}

getMetadataForUserDip721() {
  printf "🤖 Call the getMetadataForUserDip721\n"

  user="${AlicePrincipalId}"

  icx --pem="$DefaultPem" query "$NftID" getMetadataForUserDip721 "(principal \"$user\")" "$IcxPrologueNft"
=======
  nameToPrincipal=( ["Alice"]="$AlicePrincipalId" ["Bob"]="$BobPrincipalId" ["Charlie"]="$CharliePrincipalId" ["default"]="$DefaultPrincipalId")
  # nameToPem=( ["Alice"]="$AlicePem" ["Bob"]="$BobPem" ["Charlie"]="$CharliePem" ["Default"]="$DefaultPem")

  dfx identity use default  
}

info() {
  printf "\n\nPrincipal ids\n"
  printf "Alice: ${AlicePrincipalId}\n"
  printf "Bob: ${BobPrincipalId}\n"
  printf "Charlie: ${CharliePrincipalId}\n"

  printf "\n\nAccount ids\n"
  printf "Alice: ${AliceAccountId}\n"
  printf "Bob: ${BobAccountId}\n"
  printf "Charlie: ${CharlieAccountId}\n\n\n"

  printf "Principal ids: ${nameToPrincipal}\n\n\n"
  # printf "Name PEMs in order Alice, Bob, Charlie and Default \n"
  # for each in "${nameToPem[@]}"
  # do
  #   echo "$each"
  # done
}

### BEGIN OF DIP-721 ###
mintDip721() {
  mint_for="${AlicePrincipalId}"

  echo "🤖 [debug] $mint_for"

  icx --pem=$DefaultPem update $NftID mintDip721 "(principal \"$mint_for\", vec{})" $IcxPrologueNft
}

balanceOfDip721() {
  user="${AlicePrincipalId}"
  icx --pem=$DefaultPem query $NftID balanceOfDip721 "(principal \"$user\")" $IcxPrologueNft
}

ownerOfDip721() {
  token_id="0"
  icx --pem=$AlicePem query $NftID ownerOfDip721 "($token_id)" $IcxPrologueNft
}

safeTransferFromDip721() {
  from_principal="${BobPrincipalId}"
  to_principal="${AlicePrincipalId}"
  token_id="0"
  icx --pem=$BobPem update $NftID safeTransferFromDip721 "(principal \"$from_principal\", principal \"$to_principal\", $token_id)" $IcxPrologueNft
}

transferFromDip721() {
  from_principal="${AlicePrincipalId}"
  to_principal="${BobPrincipalId}"
  token_id="0"
  icx --pem=$AlicePem update $NftID transferFromDip721 "(principal \"$from_principal\", principal \"$to_principal\", $token_id)" $IcxPrologueNft
}

supportedInterfacesDip721() {
  icx --pem=$DefaultPem query $NftID supportedInterfacesDip721 "()" $IcxPrologueNft
}

logoDip721() {
  icx --pem=$DefaultPem query $NftID logoDip721 "()" $IcxPrologueNft
}

nameDip721() {
  icx --pem=$DefaultPem query $NftID nameDip721 "()" $IcxPrologueNft
}

symbolDip721() {
  icx --pem=$DefaultPem query $NftID symbolDip721 "()" $IcxPrologueNft
}

totalSupplyDip721() {
  icx --pem=$DefaultPem query $NftID totalSupplyDip721 "()" $IcxPrologueNft
}

getMetadataDip721() {
  token_id="0"
  icx --pem=$DefaultPem query $NftID getMetadataDip721 "($token_id)" $IcxPrologueNft
}

getMetadataForUserDip721() {
  user="${AlicePrincipalId}"
  icx --pem=$DefaultPem query $NftID getMetadataForUserDip721 "(principal \"$user\")" $IcxPrologueNft
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
}

### END OF DIP-721 ###

mintNFT() {
<<<<<<< HEAD
  printf "🤖 Call the mintNFT\n"

  mint_for="${AlicePrincipalId}"

  icx --pem="$DefaultPem" update "$NftID" mintNFT "(record {metadata= opt variant {\"blob\" = vec{1;2;3}}; to= variant {\"principal\"= principal \"$mint_for\"}})" "$IcxPrologueNft"
}

metadata() {
  printf "🤖 Call the metadata\n"

  token_id="0"

  icx --pem="$DefaultPem" query "$NftID" metadata \"$token_id\" "$IcxPrologueNft"
}

bearer() {
  printf "🤖 Call the bearer\n"

  token_id="0"

  icx --pem="$DefaultPem" query "$NftID" bearer \"$token_id\" $IcxPrologueNft
}

supply() {
  printf "🤖 Call the supply\n"

  token_id="0"
  icx --pem="$DefaultPem" query "$NftID" supply \"$token_id\" "$IcxPrologueNft"
}

getAllMetadataForUser() {
  printf "🤖 Call the getAllMetadataForUser\n"

  user="${AlicePrincipalId}"
  icx --pem="$DefaultPem" query "$NftID" getAllMetadataForUser "(variant {\"principal\" = principal \"$user\"})" "$IcxPrologueNft"
}

transfer() {
  printf "🤖 Call the transfer\n"

=======
  mint_for="${AlicePrincipalId}"
  icx --pem=$DefaultPem update $NftID mintNFT "(record {metadata= opt variant {\"blob\" = vec{1;2;3}}; to= variant {\"principal\"= principal \"$mint_for\"}})" $IcxPrologueNft
}

metadata() {
  token_id="0"
  icx --pem=$DefaultPem query $NftID metadata \"$token_id\" $IcxPrologueNft
}

bearer() {
  token_id="0"
  icx --pem=$DefaultPem query $NftID bearer \"$token_id\" $IcxPrologueNft
}

supply() {
  token_id="0"
  icx --pem=$DefaultPem query $NftID supply \"$token_id\" $IcxPrologueNft
}

getAllMetadataForUser() {
  user="${AlicePrincipalId}"
  icx --pem=$DefaultPem query $NftID getAllMetadataForUser "(variant {\"principal\" = principal \"$user\"})" $IcxPrologueNft
}

transfer() {
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
  from_principal="${AlicePrincipalId}"
  from_pem="${AlicePem}"
  to_principal="${BobPrincipalId}"
  token_id="0"
<<<<<<< HEAD

  icx --pem="$from_pem" update "$NftID" transfer "(record {amount = 1; from = variant {\"principal\" = principal \"$from_principal\"}; memo = vec{}; notify = true; SubAccount = null; to = variant {\"principal\" = principal \"$to_principal\"}; token = \"$token_id\"})" "$IcxPrologueNft"
}

tests() {
  deploy
  init
  info
  mintDip721
  supportedInterfacesDip721
  nameDip721
  symbolDip721
  getMetadataDip721
  getMetadataForUserDip721
  bearer
  supply
  totalSupplyDip721
  balanceOfDip721
  ownerOfDip721
  transferFromDip721
  safeTransferFromDip721
=======
  icx --pem=$from_pem update $NftID transfer "(record {amount = 1; from = variant {\"principal\" = principal \"$from_principal\"}; memo = vec{}; notify = true; SubAccount = null; to = variant {\"principal\" = principal \"$to_principal\"}; token = \"$token_id\"})" $IcxPrologueNft
}

tests() {
  printf "Running deploy..."
  deploy
  printf "Init..."
  init
  printf "info..."
  info
  printf "Running mintDip721..."
  mintDip721
  printf "Running supportedInterfacesDip721..."
  supportedInterfacesDip721
  printf "Running nameDip721..."
  nameDip721
  printf "Running symbolDip721..."
  symbolDip721
  printf "Running getMetadataDip721..."
  getMetadataDip721
  printf "Running getMetadataForUserDip721 for Alice..."
  getMetadataForUserDip721
  printf "Running bearer..."
  bearer
  printf "Running supply..."
  supply
  printf "Running totalSupply..."
  totalSupplyDip721
  printf "Running balanceOfDip721..."
  balanceOfDip721
  printf "Rinning ownerOfDip721..."
  ownerOfDip721
  printf "Running transferFromDip721 Alice to Bob..."
  transferFromDip721
  printf "Running safeTransferFromDip721 Bob to Alice..."
  safeTransferFromDip721
  printf "Running transfer Alice to Bob..."
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
  transfer

  ### not testable
  # printf "Running mintNFT"
  # mintNFT
  # printf "Running logoDip721..."
  # logoDip721
  # printf "Running metadata...."
  # metadata
  # printf "Running getAllMetadataForUser..."
  # getAllMetadataForUser
}

tests

exit 0
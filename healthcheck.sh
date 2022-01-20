#!/bin/bash

<<<<<<< HEAD
<<<<<<< HEAD
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
=======
if [ -d ./.dfx/local/canisters/nft ];
then
  printf "🚩 The process seem to have run before, it's probably best to reset the state and only after run the healthcheck, please!\n\n"  

  # The extra space is intentional, used for alignment
  read -r -p "🤖 Would you like me to reset it now (the local-replica will be stopped) [Y/n]? " CONT

  if [ "$CONT" = "Y" ]; then
    yarn reset
  else
    exit 1;
  fi

  printf "🙏 Remember to re-start the local-replica, before starting this process\n\n"  
  
  exit 0;
fi

cd "$(dirname "${BASH_SOURCE[0]}")" || exit;

TEMP_DIR="./.temp"

printf "🙏 Verifying the Cap Service status, please wait...\n\n"

CAP_ROUTER_ID_PATH="$TEMP_DIR/ic-history-router-id"

if [ ! -e "$CAP_ROUTER_ID_PATH" ];
then
  # The extra space is intentional, used for alignment
  printf "⚠️  Warning: The Cap Service is required.\n"

  # The extra space is intentional, used for alignment
  read -r -p "🤖 Would you like me to start the Cap Service for you [Y/n]? " CONT

  if [ "$CONT" = "Y" ]; then
    yarn cap:start
  else
    printf "🚩 The Cap Service is a requirement, I'm afraid.\n\n"

    exit 1;
  fi
fi

CANISTER_CAP_ID=$(cat "$CAP_ROUTER_ID_PATH")

IS_CAP_SERVICE_RUNNING=$(dfx canister id "$CANISTER_CAP_ID")

if [ -z "$IS_CAP_SERVICE_RUNNING" ];
then
  printf "🤖 Oops! The Cap Service Canister (%s) is not running...\n\n" "$CANISTER_CAP_ID"

  exit 1
fi

printf "🌈 Cap Service running as canister id (%s)\n\n" "$CANISTER_CAP_ID"
=======
source "${BASH_SOURCE%/*}/.scripts/required.sh"
>>>>>>> ce311b7 (fix: 🐛 use no-wallet when nft deploy and some refactoring)

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
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)

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
<<<<<<< HEAD
=======
NftCandidFile="${candidDir}/nft.did"
DefaultPrincipalId=$(dfx identity use Default 2>/dev/null;dfx identity get-principal)
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
=======
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
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
<<<<<<< HEAD

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
=======

  dfx deploy --no-wallet nft --argument "(principal \"$DFX_IDENTITY_PRINCIPAL\", \"tkn\", \"token\", principal \"$CANISTER_CAP_ID\")"

  printf "\n\n"
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
}

# deploy

init() {
<<<<<<< HEAD
<<<<<<< HEAD
  printf "🤖 Initialisation of environment process variables\n"
=======
  # DefaultAccountId=$(dfx identity use default 2>/dev/null;dfx ledger account-id)
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
=======
  printf "🤖 Initialisation of environment process variables\n"
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)

  DefaultPem="${dfxDir}/identity/default/identity.pem"

  NftID=$(dfx canister id nft)

<<<<<<< HEAD
<<<<<<< HEAD
  # ⚠️ Warning: This changes the identity state, set back to initial state afterwards
=======
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
=======
  # ⚠️ Warning: This changes the identity state, set back to initial state afterwards
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
  AlicePrincipalId=$(dfx identity use Alice 2>/dev/null;dfx identity get-principal)
  BobPrincipalId=$(dfx identity use Bob 2>/dev/null;dfx identity get-principal)
  CharliePrincipalId=$(dfx identity use Charlie 2>/dev/null;dfx identity get-principal)

  AlicePem="${dfxDir}/identity/Alice/identity.pem"
  BobPem="${dfxDir}/identity/Bob/identity.pem"
<<<<<<< HEAD
<<<<<<< HEAD
=======
  # CharliePem="${dfxDir}/identity/Charlie/identity.pem"
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
=======
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)

  AliceAccountId=$(dfx identity use Alice 2>/dev/null;dfx ledger account-id)
  BobAccountId=$(dfx identity use Bob 2>/dev/null;dfx ledger account-id)
  CharlieAccountId=$(dfx identity use Charlie 2>/dev/null;dfx ledger account-id)

<<<<<<< HEAD
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
=======
  # ⚠️ Warning: Resets the identity state
  dfx identity use default
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)

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

<<<<<<< HEAD
  echo "🤖 [debug] $mint_for"

  icx --pem=$DefaultPem update $NftID mintDip721 "(principal \"$mint_for\", vec{})" $IcxPrologueNft
=======
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
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
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
<<<<<<< HEAD
  icx --pem=$DefaultPem query $NftID getMetadataForUserDip721 "(principal \"$user\")" $IcxPrologueNft
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
=======

  icx --pem="$DefaultPem" query "$NftID" getMetadataForUserDip721 "(principal \"$user\")" "$IcxPrologueNft"
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
}

### END OF DIP-721 ###

mintNFT() {
<<<<<<< HEAD
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
=======
  printf "🤖 Call the mintNFT\n"

>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
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
<<<<<<< HEAD
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
=======
  printf "🤖 Call the transfer\n"

>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
  from_principal="${AlicePrincipalId}"
  from_pem="${AlicePem}"
  to_principal="${BobPrincipalId}"
  token_id="0"
<<<<<<< HEAD
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
=======

  icx --pem="$from_pem" update "$NftID" transfer "(record {amount = 1; from = variant {\"principal\" = principal \"$from_principal\"}; memo = vec{}; notify = true; SubAccount = null; to = variant {\"principal\" = principal \"$to_principal\"}; token = \"$token_id\"})" "$IcxPrologueNft"
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
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
<<<<<<< HEAD
  printf "Running transfer Alice to Bob..."
>>>>>>> 22c9dd1 (refactor: 💡 improve bootstrap service, verified, move tests as healthcheck)
=======
>>>>>>> 68f6331 (refactor: 💡 split required as separate script, update docs, improve readability of process)
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
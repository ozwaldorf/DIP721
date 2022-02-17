#!/bin/bash

if [[ -z $1 ]];
then
    printf "💎 DIP-721 Deploy Script:\n\n   usage: npm run dip721:deploy <local|ic|other> [reinstall]\n\n"
    exit 1;
fi

NETWORK=$1
NETWORK_FULL="http://$(cat dfx.json | jq -r .networks.${NETWORK}.bind)"

ASSET_DIR="assets"
NFT="nft" # canister name
TOKENSTRING="TKN"
TOKENNAME="Non Fungable Token"
PRINCIPALID=$(dfx identity get-principal)
YARNORNPM="npm run" #`npm run` or `yarn`

printf "💎 DIP-721 Deploy\n\n"
printf " 💡 Network: %s,\n 💡 Name: %s,\n 💡 Token: %s,\n 💡 OwnerPrincipalID: \n      %s\n\n" "$NETWORK" "$TOKENNAME" "$TOKENSTRING" "$PRINCIPALID"

# This only applies to local replica
if [ -d ./.dfx/local/canisters/nft ]; then
	printf "🚩 The process seems to have run before, it is recommended to reset dfx and the local replica.\n\n"  

	if [[ ! SKIP_PROMPTS -eq 1 ]]; then
		read -r -p "🤖 Would you like me to reset the environment? [y/n]? " CONT
		if [ "$CONT" = "y" ]; then
			$YARNORNPM reset
			printf "🤖 Please start your local replica with `dfx start --clean`"
            exit 0
		fi
	fi
fi

CAP_ROUTER_ID_PATH="./.temp/ic-history-router-id"

if [[ $NETWORK == "local" ]];
then
    printf "🙏 Verifying the Cap Service status, please wait...\n\n"

    if [ ! -e "$CAP_ROUTER_ID_PATH" ]; then
        # The extra space is intentional, used for alignment
        printf "⚠️  Warning: The Cap Service is required.\n\n"

        # The extra space is intentional, used for alignment
        read -r -p "🤖 Would you like me to start the Cap Service for you [y/n]? " CONT

        if [ "$CONT" = "y" ]; then
            $YARNORNPM cap:start
        else
            read -r -p "🤖 Enter the local Cap container ID: " CONT
            mkdir -p .temp
            echo $CONT > $CAP_ROUTER_ID_PATH
        fi
    fi

    CANISTER_CAP_ID=$(cat "$CAP_ROUTER_ID_PATH")
    IS_CAP_SERVICE_RUNNING=$(dfx canister id "$CANISTER_CAP_ID")

    if [ -z "$IS_CAP_SERVICE_RUNNING" ]; then
        printf "🤖 Oops! The Cap Service Canister (%s) is not running...\n\n" "$CANISTER_CAP_ID"

        exit 1
    fi

    printf "🌈 Cap Service running as canister id (%s)\n\n" "$CANISTER_CAP_ID"

    CANISTER_CAP_ID=$(cat .temp/ic-history-router-id)
else
    CANISTER_CAP_ID=lj532-6iaaa-aaaah-qcc7a-cai
fi

# deploy, redeploy, or reinstall
CANISTER_NFT_ID=$(dfx canister --network $NETWORK id $NFT)
if [[ ! $? -eq 0 ]]; then
    printf "🤖 Deploying new canister!\n\n"
    dfx canister --network $NETWORK create --all
    dfx deploy --no-wallet --network $NETWORK $NFT --argument "(principal \"$PRINCIPALID\", \"$TOKENSTRING\", \"$TOKENNAME\", principal \"$CANISTER_CAP_ID\")"
    CANISTER_NFT_ID=$(dfx canister --network $NETWORK id $NFT)
    dfx canister --no-wallet --network $NETWORK update-settings $NFT --controller $PRINCIPALID --controller $CANISTER_NFT_ID
elif [[ "$2" == "reinstall" ]]; then
    printf "🤖 Reinstalling canister!\n\n"
    dfx deploy --no-wallet --network $NETWORK nft --argument "(principal \"$PRINCIPALID\", \"$TOKENSTRING\", \"$TOKENNAME\", principal \"$CANISTER_CAP_ID\")" -m reinstall
else
    printf "🤖 Redeploying canister!\n\n"
    dfx deploy --no-wallet --network $NETWORK $NFT --argument "(principal \"$PRINCIPALID\", \"$TOKENSTRING\", \"$TOKENNAME\", principal \"$CANISTER_CAP_ID\")"
fi

if [[ $? -eq 0 ]]; then
    # Sync asset directory
    icx-asset --pem ~/.config/dfx/identity/$(dfx identity whoami)/identity.pem --replica $NETWORK_FULL sync $CANISTER_NFT_ID $ASSET_DIR
fi
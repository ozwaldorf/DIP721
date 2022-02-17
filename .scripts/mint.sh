#!/bin/bash
if [[ -z $1 ]];
then
    echo "usage: npm run dip721:mint <local|ic> <principalid>"
    exit 1;
fi

NETWORK=$1
PRINCIPALID=$2
NFTID="$(dfx canister --network $NETWORK id nft)"
INDEX="$(grep -oP '\(\K.*?(?= :)' <<< \"$(dfx canister --no-wallet call nft totalSupplyDip721)\")"

printf "💎 Minting NFT to principal id: %s\n" "$PRINCIPALID"

dfx canister --no-wallet --network $NETWORK call $NFTID mintDip721 "(principal \"${PRINCIPALID}\", vec {
    record {
        data=blob \"\00\";
        key_val_data=vec {
            record {key=\"location\"; val=variant {TextContent=\"https://${NFTID}.raw.ic0.app/${INDEX}/preview.jpg\"}};
        };
        purpose=variant {Preview}
    };
    record {
        data=blob \"\00\";
        key_val_data=vec {
            record {key=\"location\"; val=variant {TextContent=\"https://${NFTID}.raw.ic0.app/${INDEX}/rendered.jpg\"}};
            record {key=\"vrm\"; val=variant {TextContent=\"https://${NFTID}.raw.ic0.app/${INDEX}/${INDEX}.vrm\"}};
        };
        purpose=variant {Rendered}
    }
})"
#!/bin/bash
DATADIR="./blockchain"
CURDIRNAME=${PWD##*/}

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi
. ./keys.conf
nodeos \
--genesis-json $DATADIR"/../genesis.json" \
--signature-provider $PUBKEY=KEY:$PRIVKEY \
--plugin eosio::producer_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::history_api_plugin \
--data-dir $DATADIR"/data" \
--blocks-dir $DATADIR"/blocks" \
--config-dir $DATADIR"/config" \
--producer-name $CURDIRNAME \
--http-server-address 0.0.0.0:8888 \
--p2p-listen-endpoint 0.0.0.0:9010 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
--max-transaction-time 50 \
--chain-state-db-size-mb 4096 \
--p2p-peer-address 54.39.23.130:9010 \
--p2p-peer-address 192.99.154.55:9010 \
--p2p-peer-address 51.38.70.208:9010 \
--chain-state-db-size-mb 4096 \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid"

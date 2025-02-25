#!/bin/sh

# Query whether the validator has signed the last 100 blocks and publish the result


TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S %Z"`
UPTIME_FILE=status/uptime_status.txt

echo checking Validator status at $TIMESTAMP > $UPTIME_FILE

#CURL_CMD='curl -s  https://undexer.namada.coverlet.io/v4/validator?publicKey=5399BC0F27BB74E104A74C4123AEA8CC90FF9A1EC66AA988D17CE11B835CAAAE&uptime'
CURL_CMD='curl -s  https://api.namada.valopers.com/validators/details/tnam1qyvc8n7ufmpan4yy3nemm3td2c6uff4m6s72g3eg'

VALIDATOR_STATUS=`$CURL_CMD`

echo $VALIDATOR_STATUS >> $UPTIME_FILE


#COUNTED_BLOCKS=$(echo $VALIDATOR_STATUS | jq -r .countedBlocks )
COUNTED_BLOCKS=$(echo $VALIDATOR_STATUS | jq -r .uptime )

if [ "$COUNTED_BLOCKS" -gt 80 ]; then
   echo "OK_ALL_BLOCK_SIGNED" >> $UPTIME_FILE
else
  echo "WARN_MISSING_BLOCKS" >> $UPTIME_FILE
fi


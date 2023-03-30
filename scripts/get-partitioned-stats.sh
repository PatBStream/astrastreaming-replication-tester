#!/bin/bash

PULSAR_WEB_URL=$1
TOPIC=$2
#echo "Debug $PULSAR_WEB_URL $TOPIC"
curl --location --request GET "${PULSAR_WEB_URL}/admin/v2/persistent/${TOPIC}/partitioned-stats" --header "Authorization: Bearer $BEARER_TOKEN" | python3 -mjson.tool

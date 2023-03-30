#!/bin/bash

# Define the path to your Java properties file
#properties_file="../conf/config.properties"
properties_file=$1

# Read the properties file and parse its contents
while IFS='=' read -r key value; do
    # Remove leading/trailing whitespace from the key and value
    key=$(echo $key | sed 's/^[ \t]*//;s/[ \t]*$//')
    value=$(echo $value | sed 's/^[ \t]*//;s/[ \t]*$//')
   
    # Do something with the key and value, for example print them out
    #echo "Key: $key, Value: $value"
    if [ "$key" == "webServiceUrl" ]; then
        export PULSAR_SOURCE_URL=$(echo $value)
#        echo "Value for PULSAR_SOURCE_URL: $PULSAR_SOURCE_URL"
    fi
    if [ "$key" == "authParams" ]; then
        token="token:"
        newString="${value#$token}"
        export PULSAR_SOURCE_JWT=$(echo $newString)
#        echo "Value for PULSAR_SOURCE_JWT: $PULSAR_SOURCE_JWT"
    fi
    if [ "$key" == "pulsar.tenant" ]; then
        export PULSAR_TENANT=$(echo $value)
#        echo "Value for PULSAR_TENANT: $PULSAR_TENANT"
    fi
    if [ "$key" == "pulsar.namespace" ]; then
        export PULSAR_NAMESPACE=$(echo $value)
#        echo "Value for PULSAR_NAMESPACE: $PULSAR_NAMESPACE"
    fi
    if [ "$key" == "pulsar.topic" ]; then
        export PULSAR_TOPIC=$(echo $value)
#        echo "Value for PULSAR_TOPIC: $PULSAR_TOPIC"
    fi
    if [ "$key" == "pulsar.topic.type" ]; then
        export PULSAR_TOPIC_TYPE=$(echo $value)
#        echo "Value for PULSAR_TOPIC_TYPE: $PULSAR_TOPIC_TYPE"
    fi
done < "$properties_file"

export BEARER_TOKEN=$PULSAR_SOURCE_JWT
echo "Stats from $PULSAR_SOURCE_URL"
if [ "$PULSAR_TOPIC_TYPE" == "partitioned" ]; then
    ./get-partitioned-stats.sh $PULSAR_SOURCE_URL $PULSAR_TENANT/$PULSAR_NAMESPACE/$PULSAR_TOPIC
else
    ./get-nonpartitioned-stats.sh $PULSAR_SOURCE_URL $PULSAR_TENANT/$PULSAR_NAMESPACE/$PULSAR_TOPIC
fi
echo "Stats from $PULSAR_SOURCE_URL"

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
    if [ "$key" == "brokerServiceUrl" ]; then
        export PULSAR_SOURCE_URL=$(echo $value)
#        echo "Value for PULSAR_SOURCE_URL: $PULSAR_SOURCE_URL"
    fi
    if [ "$key" == "authParams" ]; then
         export PULSAR_SOURCE_JWT=$(echo $value)
#        echo "Value for PULSAR_SOURCE_JWT: $PULSAR_SOURCE_JWT"
    fi
    if [ "$key" == "authPlugin" ]; then
         export AUTHPLUGIN=$(echo $value)
#        echo "Value for AUTHPLUGIN: $AUTHPLUGIN"
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
    if [ "$key" == "pulsar.perf.location" ]; then
        export PULSAR_PERF_LOC=$(echo $value)
        echo "Value for PULSAR_PERF_LOC: $PULSAR_PERF_LOC"
    fi    
    if [ "$key" == "message.pub.size" ]; then
        export MESSAGE_PUB_SIZE=$(echo $value)
#        echo "Value for MESSAGE_PUB_SIZE: $MESSAGE_PUB_SIZE"
    fi   
    if [ "$key" == "message.pub.rate" ]; then
        export MESSAGE_PUB_RATE=$(echo $value)
#        echo "Value for MESSAGE_PUB_RATE: $MESSAGE_PUB_RATE"
    fi          
done < "$properties_file"
eval $PULSAR_PERF_LOC/pulsar-perf produce --service-url $PULSAR_SOURCE_URL --auth-plugin $AUTHPLUGIN --auth-params "$PULSAR_SOURCE_JWT" -m -1 -n 1 -r $MESSAGE_PUB_RATE -s $MESSAGE_PUB_SIZE $PULSAR_TENANT/$PULSAR_NAMESPACE/$PULSAR_TOPIC

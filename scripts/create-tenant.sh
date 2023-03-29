#!/bin/bash
properties_file=$1

# Read the properties file and parse its contents
while IFS='=' read -r key value; do
    # Remove leading/trailing whitespace from the key and value
    key=$(echo $key | sed 's/^[ \t]*//;s/[ \t]*$//')
    value=$(echo $value | sed 's/^[ \t]*//;s/[ \t]*$//')
   
    # Do something with the key and value, for example print them out
    #echo "Key: $key, Value: $value"
    if [ "$key" == "pulsar.source.weburl" ]; then
        PULSAR_SOURCE_URL=$(echo $value)
        echo "Value for PULSAR_SOURCE_URL: $PULSAR_SOURCE_URL"
    fi
    if [ "$key" == "pulsar.source.jwt" ]; then
        PULSAR_SOURCE_JWT=$(echo $value)
        echo "Value for PULSAR_SOURCE_JWT: $PULSAR_SOURCE_JWT"
    fi
    if [ "$key" == "pulsar.source.org.jwt" ]; then
        PULSAR_SOURCE_ORG_JWT=$(echo $value)
        echo "Value for PULSAR_SOURCE_ORG_JWT: $PULSAR_SOURCE_ORG_JWT"
    fi
    
done < "$properties_file"
#PULSAR_SOURCE_ORG_JWT=$1
astraurl="https://api.astra.datastax.com/v2/streaming/tenants"
H1="Authorization: Bearer "$PULSAR_SOURCE_ORG_JWT""
H2="'Content-Type: application/json'"
DATA_RAW="{\"cloudProvider\": \"aws\",\"cloudRegion\": \"uswest2\",\"tenantName\": \"testcreate\",\"userEmail\": \"joshua@example.com\"}"
#curl --location --request POST 'https://api.astra.datastax.com/v2/streaming/tenants' --header 'Content-Type: application/json' --header "Authorization: Bearer $BEARER_TOKEN" --data-raw '{
#    "cloudProvider": "aws",
#    "cloudRegion": "useast2",
#    "tenantName": "testcreate",
#    "userEmail": "joshua@example.com"
#}'
response=$(curl --location --header "$H2" --header "$H1" --data-raw "$DATA_RAW" --request POST "$astraurl")
echo $response
echo "curl --location --header "$H2" --header "$H1" --data-raw "$DATA_RAW" --request POST "$astraurl""
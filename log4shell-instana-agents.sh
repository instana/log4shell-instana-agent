#!/bin/bash

if [ "x$API_TOKEN" == "x" ]; then
    echo "Please provide an Instana API token as API_TOKEN=<your-token-here>. Information on how to set up a valid token can be found here: https://www.instana.com/docs/api/web"
fi

if [ "x$TENANT_UNIT" == "x" ]; then
    echo "Please provide the Instana tenant unit in the form TENANT_UNIT=<tenant-name>, e.g. 'TENANT_UNIT=qa-instana'"
fi

HOST='instana.io'
if [ "x$INSTANA_HOST" != "x" ]; then
    HOST=$INSTANA_HOST
fi


URL="${TENANT_UNIT}.${HOST}"
curl --fail --silent --show-error --url https://${URL}/api/host-agent --header "authorization: apiToken $API_TOKEN" \
    | jq -r '.items[].snapshotId' \
    | xargs -I '{}' curl --fail --silent --show-error --url https://${URL}/api/host-agent/'{}' --header "authorization: apiToken $API_TOKEN" \
    | jq --arg url "$URL" '. | select(any(.data.capabilities[]; . == "log4j-safe-lib") // any(.data.capabilities[]; . == "log4j-safe-config") | not) | {"snapshotId":.snapshotId, "hostname":.data.hostname}'

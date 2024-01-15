#!/bin/bash

/opt/graphdb/dist/bin/graphdb &
PID=$!

IS_UP=1

# Wait for graphdb to be running
while [  $IS_UP != 0 ]; do
    wget --spider --header 'Accept: application/json' 'http://localhost:7200/rest/repositories'
    sleep 5
    IS_UP=$?
done
wget --spider --header 'Accept: application/json' 'http://localhost:7200/rest/repositories/test-repo'
if [ $? != 0 ]
then
    curl -X PUT http://localhost:7200/rest/repositories/test-repo -H 'Accept: application/json' -H 'Content-Type: application/json' --data "@/opt/graphdb/dist/bin/repo-config.json"
fi

curl -X POST http://localhost:7200/rest/locations/active/default-repository -H 'Content-Type: application/json' -d '{"repository": "test-repo"}'
curl http://localhost:7200/rest/locations/active/default-repository -H 'Content-Type: application/json' -d '{"repository": "test-repo"}'
curl http://localhost:7200/rest/monitor/test-repo/operations -H 'Content-Type: application/json'
curl http://localhost:7200/repositories/test-repo/namespaces

wait $PID
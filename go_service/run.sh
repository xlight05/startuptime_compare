#!/bin/bash

docker build -t go_service:latest .

# Define the container name
container_name="go_service"

# Step 1: Run docker container with a name
docker run -d --name "$container_name" go_service:latest 

sleep 10

# Step 2: Store the time for the log containing "Startup completed"
docker logs "$container_name" > temp_logs.txt 2>&1

# sleep 5
endTime=$(grep "Server started" temp_logs.txt | awk '{print $6" "$7}' | sed 's/.$//')
echo "Endtime : $endTime"

# # Step 3: Get the start time of the container from docker
startTime=$(docker container inspect --format '{{ .State.StartedAt }}' "$container_name")
echo "StartTime : $startTime"

rm temp_logs.txt

# Cleanup: Stop and remove the container
docker stop "$container_name" > /dev/null
docker rm "$container_name" > /dev/null

if [ -f "../results.json" ]; then
    # Update existing JSON
    jq --arg container "$container_name" --arg start "$startTime" --arg end "$endTime" '. + { ($container): { "startTime": $start, "endTime": $end } }' ../results.json > temp.json && mv temp.json ../results.json
else
    # Create new JSON
    echo "{\"$container_name\": {\"startTime\": \"$startTime\", \"endTime\": \"$endTime\"}}" > ../results.json
fi

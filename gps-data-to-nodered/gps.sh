#!/bin/sh

# Parse arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        --url)
            if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
                TARGET_URL="$2"
                shift 2
            else
                echo "Error: Missing value for --url. Please specify a URL."
                exit 1
            fi
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

# Check if the URL is provided
if [ -z "$TARGET_URL" ]; then
    echo "Error: No URL provided. Use --url to specify the target URL."
    exit 1
fi

# Get GPS data
GPS_LAT=$(gpsctl -i -x -e | sed -n '1p')  # Extract latitude
GPS_LON=$(gpsctl -i -x -e | sed -n '2p')  # Extract longitude
GPS_TIME=$(gpsctl -i -x -e | sed -n '3p') # Extract timestamp

# Format GPS data as JSON
GPS_JSON=$(printf '{"latitude": "%s", "longitude": "%s", "timestamp": "%s"}' "$GPS_LAT" "$GPS_LON" "$GPS_TIME")

# Send the GPS data to the target URL without waiting for a response
curl -X POST -H "Content-Type: application/json" -d "$GPS_JSON" \
    --silent --output /dev/null "$TARGET_URL" &

# Exit cleanly
exit 0

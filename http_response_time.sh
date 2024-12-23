#!/bin/bash

# Default URLs (can be overridden by arguments)
URLS=("${@:-${DEFAULT_URLS[@]}}")

# Check HTTP response times for the provided URLs
for URL in "${URLS[@]}"; do
    if curl -o /dev/null -s --head --fail "$URL"; then
        RESPONSE_TIME=$(curl -o /dev/null -s -w '%{time_total}\n' "$URL")
        echo "Response Time for $URL: $RESPONSE_TIME seconds"
    else
        echo "Error: Unable to reach $URL"
    fi
done
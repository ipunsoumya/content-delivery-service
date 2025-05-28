#!/bin/bash

# Stop Spring Boot application
echo "Stopping Spring Boot application..."

# Find and kill the Spring Boot process
SPRING_PID=$(pgrep -f "content-service" || pgrep -f "content-service*.jar")

if [ -n "$SPRING_PID" ]; then
    echo "Found Spring Boot process with PID: $SPRING_PID"
    kill -15 $SPRING_PID
    
    # Wait for graceful shutdown (max 30 seconds)
    for i in {1..30}; do
        if ! kill -0 $SPRING_PID 2>/dev/null; then
            echo "Spring Boot application stopped gracefully"
            break
        fi
        echo "Waiting for graceful shutdown... ($i/30)"
        sleep 1
    done
    
    # Force kill if still running
    if kill -0 $SPRING_PID 2>/dev/null; then
        echo "Force killing Spring Boot application..."
        kill -9 $SPRING_PID
    fi
else
    echo "No Spring Boot process found running"
fi

# Remove PID file if it exists
if [ -f "/opt/content-service/app.pid" ]; then
    rm -f /opt/content-service/app.pid
    echo "Removed PID file"
fi

echo "Stop server script completed"
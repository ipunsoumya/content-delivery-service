#!/bin/bash

# Validate Spring Boot application is running
echo "Validating Spring Boot application..."

APP_DIR="/opt/content-service"
MAX_ATTEMPTS=5
ATTEMPT=1

# Check if PID file exists
if [ ! -f "$APP_DIR/app.pid" ]; then
    echo "ERROR: PID file not found"
    exit 1
fi

PID=$(cat $APP_DIR/app.pid)

# Check if process is running
if ! kill -0 $PID 2>/dev/null; then
    echo "ERROR: Spring Boot process (PID: $PID) is not running"
    exit 1
fi

echo "Spring Boot process is running with PID: $PID"

# Wait for application to be ready (check health endpoint or port)
# Default Spring Boot runs on port 8080, adjust if different
PORT=8080

echo "Checking if application is responding on port $PORT..."

while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    echo "Attempt $ATTEMPT/$MAX_ATTEMPTS..."
    
    # Check if port is listening
    if netstat -tuln | grep ":$PORT " > /dev/null; then
        echo "Port $PORT is listening"
        
        # Try to make HTTP request to health endpoint (if available)
        if command -v curl &> /dev/null; then
            HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/actuator/health 2>/dev/null || echo "000")
            
            if [ "$HTTP_STATUS" = "200" ]; then
                echo "Health check passed (HTTP 200)"
                echo "Spring Boot application is running and healthy!"
                exit 0
            elif curl -s -o /dev/null http://localhost:$PORT 2>/dev/null; then
                echo "Application is responding on port $PORT"
                echo "Spring Boot application is running!"
                exit 0
            fi
        else
            # If curl is not available, just check if port is open
            echo "Application appears to be running on port $PORT"
            exit 0
        fi
    fi
    
    sleep 2
    ATTEMPT=$((ATTEMPT + 1))
done

echo "ERROR: Application validation failed after $MAX_ATTEMPTS attempts"
echo "Check application logs: $APP_DIR/logs/application.log"
exit 1
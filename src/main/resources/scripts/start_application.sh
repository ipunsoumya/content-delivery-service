#!/bin/bash

# Start Spring Boot application
echo "Starting Spring Boot application..."

# Set application directory
APP_DIR="/opt/content-service"
cd $APP_DIR

# Find the JAR file (adjust pattern if your JAR has a specific name)
JAR_FILE=$(find $APP_DIR -name "*.jar" -type f | head -1)

if [ -z "$JAR_FILE" ]; then
    echo "ERROR: No JAR file found in $APP_DIR"
    exit 1
fi

echo "Found JAR file: $JAR_FILE"

# Set Java options (adjust as needed)
JAVA_OPTS="-Xmx512m -Xms256m -server"

# Set Spring Boot profiles (adjust as needed)
SPRING_PROFILES="dev"

# Start the application in background
nohup java $JAVA_OPTS \
    -Dspring.profiles.active=$SPRING_PROFILES \
    -jar $JAR_FILE \
    > $APP_DIR/logs/application.log 2>&1 &

# Save PID
echo $! > $APP_DIR/app.pid

# Wait a moment and check if process started
sleep 5

PID=$(cat $APP_DIR/app.pid)
if kill -0 $PID 2>/dev/null; then
    echo "Spring Boot application started successfully with PID: $PID"
    echo "Log file: $APP_DIR/logs/application.log"
else
    echo "ERROR: Failed to start Spring Boot application"
    exit 1
fi
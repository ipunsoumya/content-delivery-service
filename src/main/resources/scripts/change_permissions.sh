#!/bin/bash

# Change file permissions for Spring Boot application
echo "Setting file permissions..."

APP_DIR="/opt/content-service"

# Change ownership to ec2-user
chown -R ec2-user:ec2-user $APP_DIR
echo "Changed ownership to ec2-user:ec2-user"

# Set directory permissions
find $APP_DIR -type d -exec chmod 755 {} \;
echo "Set directory permissions to 755"

# Set file permissions
find $APP_DIR -type f -exec chmod 644 {} \;
echo "Set file permissions to 644"

# Make JAR files executable
find $APP_DIR -name "*.jar" -exec chmod 755 {} \;
echo "Made JAR files executable"

# Make script files executable
find $APP_DIR -name "*.sh" -exec chmod 755 {} \;
echo "Made shell scripts executable"

# Set permissions for logs directory
if [ -d "$APP_DIR/logs" ]; then
    chmod 755 $APP_DIR/logs
    chmod 644 $APP_DIR/logs/*.log 2>/dev/null || true
    echo "Set permissions for logs directory"
fi

# Set permissions for PID file
if [ -f "$APP_DIR/app.pid" ]; then
    chmod 644 $APP_DIR/app.pid
    echo "Set permissions for PID file"
fi

echo "File permissions set successfully"
#!/bin/bash

# Install dependencies for Spring Boot application
echo "Installing dependencies..."

# Update system packages
yum update -y

# Install Java 17 (adjust version as needed for your Spring Boot app)
if ! command -v java &> /dev/null; then
    echo "Installing Java 17..."
    yum install -y java-17-amazon-corretto-headless
else
    echo "Java is already installed"
    java -version
fi

# Create application directory if it doesn't exist
if [ ! -d "/opt/content-service" ]; then
    mkdir -p /opt/content-service
    echo "Created application directory"
fi

# Create logs directory
if [ ! -d "/opt/content-service/logs" ]; then
    mkdir -p /opt/content-service/logs
    echo "Created logs directory"
fi

# Install additional dependencies if needed
# Uncomment below if your app needs specific packages
# yum install -y wget curl

echo "Dependencies installation completed"
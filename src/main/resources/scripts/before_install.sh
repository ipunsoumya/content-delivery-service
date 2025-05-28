#!/bin/bash
# Stop the application if running
if [ -f /etc/init.d/content-service ]; then
  /etc/init.d/content-service stop
fi

# Create application directory if it doesn't exist
mkdir -p /opt/content-service
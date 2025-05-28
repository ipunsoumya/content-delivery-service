#!/bin/bash
# Set up application as a service
cp /opt/content-service/content-service.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable content-service.service
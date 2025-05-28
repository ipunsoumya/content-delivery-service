#!/bin/bash
# Health check for Java application
HEALTH_CHECK_URL=http://localhost:8080/actuator/health  # Spring Boot Actuator endpoint
# Or use your custom health endpoint: HEALTH_CHECK_URL=http://localhost:8080/api/health

# Number of retries
MAX_RETRIES=3
RETRY_INTERVAL=5

# Try to reach the health endpoint
for i in $(seq 1 $MAX_RETRIES); do
  HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_CHECK_URL || true)

  if [ $HTTP_STATUS -eq 200 ]; then
    echo "Health check passed"
    exit 0
  fi

  if [ $i -lt $MAX_RETRIES ]; then
    echo "Health check failed (attempt $i of $MAX_RETRIES). Retrying in $RETRY_INTERVAL seconds..."
    sleep $RETRY_INTERVAL
  fi
done

echo "Health check failed after $MAX_RETRIES attempts"
exit 1
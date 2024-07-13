#!/bin/sh

# Wait for MinIO to be up and running on localhost:9000
while ! nc -z s3 9000; do   
  echo "Waiting for MinIO to start..."
  sleep 1
done

# Create alias
echo "Command to run in the container: mc alias set local http://s3:9000 ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY}"
docker exec mlflow_s3 /bin/sh -c "mc alias set local http://s3:9000 ${AWS_ACCESS_KEY_ID} ${AWS_SECRET_ACCESS_KEY}"

# Start the cron tab in the foreground and tail the backup log
crond -f -l 2 & tail -f /var/log/backup.log
FROM docker:stable

# Install necessary packages (e.g., cron, logging tools)
RUN apk add --no-cache dcron wget ca-certificates logrotate 

# Create a log file to check the cron logs
RUN touch /var/log/backup.log

# Add your scripts and cron file
COPY ./backup_mlflow_data.sh /scripts/backup_mlflow_data.sh
COPY ./mlflow_backup_cron /etc/crontabs/mlflow_backup_cron
COPY ./entrypoint.sh /scripts/entrypoint.sh

# Give execution rights to the script
RUN chmod +x /scripts/backup_mlflow_data.sh
RUN chmod +x /scripts/entrypoint.sh

# Load the cron file
RUN crontab /etc/crontabs/mlflow_backup_cron

# Start crond and tail the log file to keep the container running
ENTRYPOINT ["sh", "/scripts/entrypoint.sh"]
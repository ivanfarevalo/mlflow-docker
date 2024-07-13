#!/bin/sh

# Backup date
BACKUP_DATE=$(date +%Y%m%d_%H%M%S)

# Backup Configuration
RETENTION_COUNT=10
MINIO_BACKUP=/backup/minio
DB_BACKUP=/backup/mlflow_db

# MinIO Configuration
MINIO_ALIAS="local"
MINIO_SOURCE_BUCKET="$AWS_BUCKET_NAME"
MINIO_TARGET_DIR="${MINIO_BACKUP}/${MINIO_SOURCE_BUCKET}"

# PostgreSQL Configuration
DB_USER="$PG_USER"
DB_NAME="$PG_DATABASE"
POSTGRES_BACKUP_FILE="${DB_BACKUP}/${DB_NAME}_${BACKUP_DATE}.sql"

# Create backup directories if they do not exist
mkdir -p ${MINIO_BACKUP}
mkdir -p ${DB_BACKUP}

# Function to perform MinIO backup
backup_minio() {
    echo "Starting MinIO backup..."
    docker exec mlflow_s3 /bin/sh -c "mc mirror ${MINIO_ALIAS}/${MINIO_SOURCE_BUCKET} ${MINIO_TARGET_DIR}"
    echo "MinIO backup completed."
}

# Function to perform PostgreSQL backup
backup_postgres() {
    echo "Starting PostgreSQL backup..."
    docker exec mlflow_db /bin/sh -c "pg_dump -U ${DB_USER} ${DB_NAME} > ${POSTGRES_BACKUP_FILE}"
    echo "PostgreSQL backup completed."
}

# Function to clean up old backups
cleanup_backups() {
    echo "Cleaning up old backups..."
    # Clean up PostgreSQL backups
    ls -t ${DB_BACKUP}/* | tail -n +$((RETENTION_COUNT+1)) | xargs -I {} rm -rf {}
    echo "Cleanup completed."
}

# Perform the backups
backup_minio
backup_postgres

# Clean up old backups
cleanup_backups

echo "All backups completed successfully."


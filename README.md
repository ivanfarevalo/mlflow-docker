# MLFlow Docker Setup 

> Includes MLFlow 2.14, postgreSQL 14, minio, and data backup service.
> Setup for on-prem object storage
> The only requirement is docker installed on your system and we are going to use Bash on linux/windows.

# 🚀 1-2-3! Setup guide 
1. Configure `.env` file for your choice. You can put there anything you like, it will be used to configure your services
2. Run `docker compose up`
3. Open up http://localhost:5000 for MlFlow, and http://localhost:9001/ to browse your files in S3 artifact store

# Features
 - One file setup (.env)
 - Minio S3 artifact store with GUI
 - PostgreSQL 14 mlflow storage
 - MLFlow 2.14
 - Ready to use bash scripts for python development!
 - Automatically-created s3 buckets
 - Automatically create backups of database and object store


## Credits
Forked from https://github.com/Toumash/mlflow-docker

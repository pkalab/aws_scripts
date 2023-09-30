#!/bin/bash

# Specify your AWS region
aws_region="region"
retention_days=30  

# Get a list of all RDS clusters
cluster_list=$(aws rds describe-db-clusters --query 'DBClusters[*].DBClusterIdentifier' --output text --region "$aws_region")

# Loop through each RDS cluster and set the backup retention period
for cluster in $cluster_list; do
  echo "Setting backup retention period to $retention_days days for cluster: $cluster"
  aws rds modify-db-cluster \
    --db-cluster-identifier "$cluster" \
    --backup-retention-period $retention_days \
    --region "$aws_region"
done

echo "Backup retention period set to $retention_days days for all RDS clusters"

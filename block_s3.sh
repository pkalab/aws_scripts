#!/bin/bash


echo "Blocking public access for S3 buckets..."


s3_buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)
echo s3_buckets
for bucket in $s3_buckets; do
  echo "Blocking public access for bucket: $bucket"
  aws s3api put-public-access-block --bucket $bucket --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
done

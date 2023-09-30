#!/bin/bash

# List all SNS topics
topics=$(aws sns list-topics --query 'Topics[].TopicArn' --output text)

# Specify the KMS key ID for encryption 
kms_key_id="kms-key-id"

# Loop through each topic and check encryption settings
for topic_arn in $topics; do
  echo "Topic ARN: $topic_arn"
  
  # Get the topic attributes
  topic_attributes=$(aws sns get-topic-attributes --topic-arn "$topic_arn")
  
  # Check if encryption is already enabled
  encryption_enabled=$(echo "$topic_attributes" | jq -r '.Attributes | .["KmsMasterKeyId"] != null')
  
  if [ "$encryption_enabled" == "true" ]; then
    echo "Encryption is already enabled."
  else
    echo "Enabling encryption..."
    
   
    aws sns set-topic-attributes --topic-arn "$topic_arn" --attribute-name KmsMasterKeyId --attribute-value "$kms_key_id"
    
    echo "Encryption is now enabled with KMS key: $kms_key_id"
  fi
  
  echo "-------------------------"
done

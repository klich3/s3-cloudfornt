#!/bin/sh

#Author: <Anthony Sychev> (hello at dm211 dot com)
#deploy.sh (c) 2022
#Desc: Auto upload and create invalidate for cloudfront

#Dependences: Is nedded to do:
#brew install jq
#apt i jq
#yaml install jq

#aws cli
#See this documentatio: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

#For create aws profile see: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

#Created:  2022-01-17T11:37:46.532Z
#Modified: !date!
#Usage: ./deploy.sh <profile_name> <domain_name> <folder_to_upload> <region>

PROFILE=$1
S3=$2
FOLDER=$3

if [ -z "$4" ]; then
    REGION=$4
else
    REGION='eu-central-1'
fi

echo "[->] UPLOADING TO S3"
aws --profile $PROFILE --region eu-central-1 s3 sync $FOLDER s3://$S3 --delete
echo "[->] DONE"
echo "[->] GET IDS FROM CLOUDFRONT"
AWSDISTR=$(aws --profile $PROFILE cloudfront list-distributions)
DISTRIBUTIONS=$(echo $AWSDISTR | jq -r '.DistributionList.Items[] | "\(.Id) \(.Aliases.Items[0])"' | awk -v S3="$S3" '$2==S3 { print $1 }')

# {
#    "DistributionList": {
#        "Items": [
#            {
#                "Id": "E3XXXXXXZOXK1",
#                "ARN": "arn:aws:cloudfront::24XXXXX12:distribution/E3OYXXXXXXXK1",
#                "Status": "Deployed",
#                "LastModifiedTime": "2022-01-13T17:42:31.921000+00:00",
#                "DomainName": "dstaXXXXXX.cloudfront.net",
#                "Aliases": {
#                    "Quantity": 1,
#                    "Items": [
#                        "deXXXXXXXo"
#                   ]
#                },

echo "[->] CLOUDFRONT DISTRIBUTION ID:$DISTRIBUTIONS"
echo "[->] INVALIDATE DISTRIBUTION ON CLOUDFRONT"
aws --profile $PROFILE cloudfront create-invalidation --distribution-id $DISTRIBUTIONS --invalidation-batch '{ "Paths": { "Quantity": 1, "Items": [ "/*" ] }, "CallerReference": "beame-invalidation-'"$(date +%s)"'"}'
echo "[->] DONE"
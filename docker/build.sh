#!/bin/bash -l

# exit on error
set -e

source .env

# handle all non-zero exit status codes with a slack notification
trap 'handler $? $LINENO' EXIT

handler () {
    if [ "$1" != "0" ]; then
        printf "%b" "${OKB}Notifying slack channel of snap build failure.${NC}\n"
        curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"Snap build server job failed with exit status: $1 on line $2\"}" https://hooks.slack.com/services/"$SLACK_IDENTIFIER"
        printf "%b" "${OKG} ✓ ${NC}complete\n"
    fi
}

# pull .snap file from s3 bucket
printf "%b" "${OKB}Pulling $OBJECT to S3 bucket $BUCKET as $OBJECT${NC}\n"
./s3_pull.py -t "$OBJECT" -o "$OBJECT" -b "$BUCKET"
printf "%b" "${OKG} ✓ ${NC}complete\n"

# login to snap store for push
snapcraft login --with .snapcraft

# Notify slack channel of build success
printf "%b" "${OKB}Notifying slack channel of snap build success.${NC}"
curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"Snap build server job complete. Download and install the snap file and the build logs here: https://s3.console.aws.amazon.com/s3/buckets/snapbuilds?region=ca-central-1&tab=objects\"}" https://hooks.slack.com/services/"$SLACK_IDENTIFIER"
printf "%b" "${OKG} ✓ ${NC}complete"

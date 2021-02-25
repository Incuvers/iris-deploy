#!/bin/bash -l

# exit on error
set -e

source .env

# handle all non-zero exit status codes with a slack notification
trap 'handler $?' EXIT

handler () {
    if [ "$1" != "0" ]; then
        printf "%b" "${OKB}Notifying slack channel of snap build failure.${NC}\n"
        curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"Snap deploy server job failed with exit status: $1\"}" https://hooks.slack.com/services/"$SLACK_IDENTIFIER"
        printf "%b" "${OKG} ✓ ${NC}complete\n"
    fi
}

# pull .snap file from s3 bucket
printf "%b" "${OKB}Pulling $OBJECT to S3 bucket $BUCKET as $OBJECT${NC}\n"
./s3_pull.py -t "$OBJECT" -o "$OBJECT" -b "$BUCKET"
printf "%b" "${OKG} ✓ ${NC}complete\n"

# login to snapcraft and release to edge
printf "%b" "${OKB}Publishing ${OBJECT} to ${RELEASE_CHANNEL}${NC}\n"
echo "${SNAP_TOKEN}" | snapcraft login --with -
snapcraft upload *.snap --release="${RELEASE_CHANNEL}"
printf "%b" "${OKG} ✓ ${NC}complete\n"

# Notify slack channel of build success
printf "%b" "${OKB}Notifying slack channel of snap build success.${NC}"
curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"Snap deployment complete. View the latest snap release: https://snapcraft.io/iris-incuvers/releases\"}" https://hooks.slack.com/services/"$SLACK_IDENTIFIER"
printf "%b" "${OKG} ✓ ${NC}complete"

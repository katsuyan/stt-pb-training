#!/bin/sh

set -e

while [ $# -gt 0 ];
do
    case ${1} in
        "--env")
            ENV=${2}
            shift
        ;;
        *)
            echo "[ERROR] Invalid option '${1}'"
            usage
            exit 1
        ;;
    esac
    shift
done

PROJECT_ROOT_DIR=$(cd $(dirname $0); pwd)

case ${ENV} in
    "saito")
        SYNC_BUCKET="static-new-employee-1-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E2GJZQBB9GPVLZ"
    ;;
    "jo")
        SYNC_BUCKET="static-new-employee-2-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E15Q55MT71GRII"
    ;;
    "murata")
        SYNC_BUCKET="static-new-employee-3-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E1SJFFE0FDMQ4B"
    ;;
    "takewaka")
        SYNC_BUCKET="static-new-employee-4-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E1SJFFE0FDMQ4B"
    ;;
    "tajima")
        SYNC_BUCKET="static-new-employee-5-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E1SJFFE0FDMQ4B"
    ;;
    "maki")
        SYNC_BUCKET="static-new-employee-6-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E1SJFFE0FDMQ4B"
    ;;
    *)
        echo "[ERROR] Invalid value --env: '${ENV}'"
        usage
        exit 1
    ;;
esac

deploy() {    
    aws s3 cp ${PROJECT_ROOT_DIR} s3://$SYNC_BUCKET --recursive --exclude '*.sh' --exclude '.*'
}

invalidation() {
    aws cloudfront create-invalidation \
        --distribution-id $CLOUDFRONT_DISTRIBUTION_ID \
        --paths "/*"
}

deploy
invalidation

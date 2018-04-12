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
        CLOUDFRONT_DISTRIBUTION_ID="E1BE61XLJJRZST"
    ;;
    "murata")
        SYNC_BUCKET="static-new-employee-3-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E1S908RG1B6OCG"
    ;;
    "takewaka")
        SYNC_BUCKET="static-new-employee-4-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E3BKXIO30YEJFF"
    ;;
    "tajima")
        SYNC_BUCKET="static-new-employee-5-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E3SNZ0HSDMAQIW"
    ;;
    "maki")
        SYNC_BUCKET="static-new-employee-6-290203874812"
        CLOUDFRONT_DISTRIBUTION_ID="E30Y6TWR4YHEGY"
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

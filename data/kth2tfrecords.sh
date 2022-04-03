#!/usr/bin/env bash

# exit if any command fails
set -e

IMAGE_SIZE=64
TARGET_DIR=./data/kth
python video_prediction/datasets/kth_dataset.py ${TARGET_DIR}/processed ${TARGET_DIR} ${IMAGE_SIZE}
rm -rf ${TARGET_DIR}/raw
rm -rf ${TARGET_DIR}/processed

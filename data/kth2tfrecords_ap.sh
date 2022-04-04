#!/usr/bin/env bash

# exit if any command fails
set -e

IMAGE_SIZE=64
TARGET_DIR=./data/kth
python video_prediction/datasets/kth_dataset.py ${TARGET_DIR}/processed ${TARGET_DIR} ${IMAGE_SIZE}
python video_prediction/datasets/kth_dataset_ap.py ${TARGET_DIR}/processed_ap ${TARGET_DIR} ${IMAGE_SIZE}
python video_prediction/datasets/kth_dataset_nap.py ${TARGET_DIR}/processed_nap ${TARGET_DIR} ${IMAGE_SIZE}
rm -rf ${TARGET_DIR}/raw
rm -rf ${TARGET_DIR}/processed
rm -rf ${TARGET_DIR}/processed_ap
rm -rf ${TARGET_DIR}/processed_nap
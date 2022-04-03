#!/usr/bin/env bash

# exit if any command fails
set -e
IMAGE_SIZE=64
TARGET_DIR=./data/kth
DRAG_DIR=./data
echo ${TARGET_DIR} ${IMAGE_SIZE}
mkdir -p ${TARGET_DIR}
mkdir -p ${TARGET_DIR}/raw
echo "Unzipping KTH dataset (this takes a while)"
for ACTION in walking jogging running boxing handwaving handclapping; do
	ZIP_FNAME=${ACTION}.zip
	unzip ${DRAG_DIR}/${ZIP_FNAME} -d ${TARGET_DIR}/raw/${ACTION}
done
FRAME_RATE=25
mkdir -p ${TARGET_DIR}/processed
TAR_FNAME=kth_meta.tar.gz
tar -xzvf ${DRAG_DIR}/${TAR_FNAME} --strip 1 -C ${TARGET_DIR}/processed
for ACTION in walking jogging running boxing handwaving handclapping; do
	for VIDEO_FNAME in ${TARGET_DIR}/raw/${ACTION}/*.avi; do
		FNAME=$(basename ${VIDEO_FNAME})
		FNAME=${FNAME%_uncomp.avi}
		while [ ! -d "${TARGET_DIR}/processed/${ACTION}/${FNAME}" ]; do
			mkdir -p ${TARGET_DIR}/processed/${ACTION}/${FNAME}
		done
		ffmpeg -i ${VIDEO_FNAME} -r ${FRAME_RATE} -f image2 -s ${IMAGE_SIZE}x${IMAGE_SIZE} \
		${TARGET_DIR}/processed/${ACTION}/${FNAME}/image-%03d_${IMAGE_SIZE}x${IMAGE_SIZE}.png
	done
done
echo "Successfully finished preprocessing dataset KTH"

#! /bin/bash

set -ex

export IMAGE_FAMILY="pytorch-1-0-cu92-experimental"
# For non-GPU instances, use
# export IMAGE_FAMILY="pytorch-1-0-cpu-experimental"
export ZONE="us-west1-b"
export INSTANCE_NAME="fastai-instance"
export INSTANCE_TYPE="n1-highmem-4"

gcloud compute instances create $INSTANCE_NAME \
        --zone=$ZONE \
        --image-family=$IMAGE_FAMILY \
        --image-project=deeplearning-platform-release \
        --maintenance-policy=TERMINATE \
        --accelerator="type=nvidia-tesla-k80,count=1" \
        --machine-type=$INSTANCE_TYPE \
        --boot-disk-size=200GB \
        --metadata="install-nvidia-driver=True" \
        --preemptible

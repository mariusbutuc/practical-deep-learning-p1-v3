#! /bin/bash

set -ex

export INSTANCE_NAME="fastai-instance"

gcloud compute instances start $INSTANCE_NAME
gcloud compute ssh jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080

# # On the instance
# sudo /opt/anaconda3/bin/conda install -c fastai fastai -y
# cd tutorials/fastai/course-v3
# git pull

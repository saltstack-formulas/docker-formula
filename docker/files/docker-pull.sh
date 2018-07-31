#!/bin/bash

IMAGE=$1

PULL=$(docker pull $IMAGE | grep "Downloaded newer image")
STRING="Downloaded newer image"

if [[ "$PULL" == *$STRING* ]]; then
  echo "" 
  echo "changed=yes comment='New image has been pulled'"
else
  echo "" 
  echo "changed=no comment='No new image has been pulled'"
fi
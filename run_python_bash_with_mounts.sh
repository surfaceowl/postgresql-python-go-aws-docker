#!/usr/bin/env bash
# run this from current directory
# quick script to run the python container, mount the local directories as persistent mounts, open ports for jupyter, and open a terminal window
CMD="docker run -it -v ${PWD}/docker-python-jupyter:/home/docker-python-jupyter -v ${PWD}/data-python:/home/data-python -p 8888:8888 docker-python38 /bin/bash"
echo 'Starting jupyter notebook server with commmand: '$CMD
eval $CMD

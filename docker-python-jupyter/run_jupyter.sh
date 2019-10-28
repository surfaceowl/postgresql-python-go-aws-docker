#!/usr/bin/env bash

# hack to print notebook address which is cut off in docker terminal
CMD0="The jupyter notebook will run at http://127.0.0.1:8888"
CMD1="The password is `test`"
eval $CMD0
eval $CMD1

# CMD fails without --ip and --allow root flags in this location
CMD="jupyter notebook --allow-root --no-browser --ip 0.0.0.0 --port=8888 --NotebookApp.token='test'"
echo 'Starting jupyter notebook server with commmand: '$CMD
eval $CMD

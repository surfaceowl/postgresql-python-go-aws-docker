#!/usr/bin/env bash

# hack to print notebook address which is cut off in docker terminal
CMD0="The jupyter notebook will run at http://127.0.0.1:8888"
CMD1="The password is `test`"
eval $CMD0
eval $CMD1

# CMD fails without --ip and --allow root flags in this location
# --no-browser flag used because user should use browser from their local machine
# add password with this snippet to end of jupyter CMD in next line: --NotebookApp.token='test'
CMD="jupyter notebook --NotebookApp.token='test' --no-browser --allow-root --ip 0.0.0.0 --port=8888"
echo 'Starting jupyter notebook server with commmand: '$CMD
eval $CMD

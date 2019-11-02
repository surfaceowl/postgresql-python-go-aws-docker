#!/usr/bin/env bash
# persistent mounts are not working correctly in docker for windows as of Oct 2019, this script is a workaround
# to build all containers using specifications from current Dockerfiles in each respective dir, AND
# launch separate child processes to run docker containers using direct CLI RUN commands which are correctly persisting mounts in Windows

CMD_BUILD_POSTGRES="cd ./docker-postgres && docker build -t docker-postgres . && cd .."
CMD_BUILD_PGADMIN4="cd ./docker-pgadmin4 && docker build -t docker-pgadmin4 . && cd .."
CMD_BUILD_PYTHON="cd ./docker-python38 && docker build -t docker-python38 . && cd .."

CMD_RUN_POSTGRES="docker run -it -v ${PWD}/docker-postgres:/var/lib/pgadmin -v ${PWD}/data-postgres:/home/data-postres -p 5432:5432 docker-postgres"
CMD_RUN_PGADMIN4="docker run -it --env PGADMIN_DEFAULT_EMAIL=1234@admin.com --env PGADMIN_DEFAULT_PASSWORD=1234 -v ${PWD}/docker-pgadmin4:/home/docker-pgadmin4 -v ${PWD}/data-postgres:/home/data-postres -p 5050:80 docker-pgadmin"
CMD_RUN_PYTHON="docker run -it -v ${PWD}/docker-python38:/home/docker-python38 -v ${PWD}/data-python:/home/data-python -p 8888:8888 docker-python38"

# build containers - run in series
CMD_BUILD_ALL="eval $CMD_BUILD_POSTGRES && eval $CMD_BUILD_PGADMIN4 && eval $CMD_BUILD_PYTHON && ls"

# run all containers - run in parallel, as separate child processes
CMD_RUN_ALL="eval $CMD_RUN_POSTGRES & eval $CMD_RUN_PGADMIN4 & eval $CMD_RUN_PYTHON &"

# put build in series, wait for completion, eval RUNALL in parallel and wait
eval $CMD_BUILD_ALL

eval $CMD_RUN_ALL

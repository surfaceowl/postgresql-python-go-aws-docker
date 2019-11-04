FROM dpage/pgadmin4

USER root

WORKDIR /home/
# configure local directories and mount points
# make persistent postgres directory in docker container
RUN mkdir -p ./docker-postgres && mkdir -p ./data-postgres && ls -al

# Add volumes for postgres database
VOLUME  ["./docker-postgres", "./data-postgres"]

# set env vars
# assume docker build context is project root using `-f` flag, not run from same folder as Dockfile (which is common)
# example comand; `docker build -f docker-pgadmin4/Dockerfile -t docker-pgadmin4 .`
COPY .env.list /home/.env.list
RUN /bin/sh -c "set -o allexport && source .env.list"

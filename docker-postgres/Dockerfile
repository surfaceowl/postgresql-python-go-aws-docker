FROM postgres:12.0

USER root

WORKDIR /home/

LABEL vendor=Postgres12_Official_Image \
      com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2019-10-25"

# configure local directories and mount points
# make persistent postgres directory in docker container
RUN mkdir -p ./docker-postgres && mkdir -p ./data-postgres && ls -al

# install linux and git tools; last line cleans up install dir for smaller docker image
RUN apt install -y apt &&\
    apt update && apt upgrade -y &&\
    apt install -y \
    bash-completion \
    curl \
    git-core \
    software-properties-common \
    sudo \
    wget &&\
    rm -r /var/lib/apt

# Add volumes for backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql", "./docker-postgres", "./data-postgres"]

# set env vars
# assume docker build context is project root using `-f` flag, not run from same folder as Dockfile (which is common)
# example comand; `docker build -f docker-postgres/Dockerfile -t docker-postgres .`
COPY .env.list /home/.env.list
RUN /bin/bash -c "set -o allexport && source ./.env.list && printenv"

# Run the rest of the commands as the ``postgres`` user
RUN useradd -s /bin/bash postgresdba

# set ownership of persistent mount to current user so we can write files
RUN chown postgresdba:postgresdba ./data-postgres

# Expose the PostgreSQL port
EXPOSE 5432

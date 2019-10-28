FROM postgres:12.0

USER root

WORKDIR /root/

LABEL vendor=Postgres12_Official_Image \
      com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2019-10-25"

# configure local directories and mount points
# make persistent postgres directory in docker container
RUN mkdir -p /data-postgres && ls -al

# install linux and git tools
RUN apt install -y apt &&\
    apt update && apt upgrade -y &&\
    apt install -y \
    curl \
    git-core \
    software-properties-common \
    sudo \
    wget

    # packages for building python from source
    # apt-get install build-essential libffi-devsudo libreadline-gplv2-dev libncursesw5-dev \
    # libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

# Add volumes for backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql", "../data-postgres"]

# set env vars
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB test_db
ENV INITIAL_DB_USER user00
ENV INITIAL_DB_PASSWORD user00
ENV INITIAL_DB_DATABASE user00_db

ADD init /docker-entrypoint-initdb.d/

# Run the rest of the commands as the ``postgres`` user
RUN useradd -s /bin/bash postgresondocker
# set ownership of persistent mount to current user so we can write files
RUN chown postgresondocker:postgresondocker /data-postgres

# Expose the PostgreSQL port
EXPOSE 5432

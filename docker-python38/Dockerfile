FROM python:3.8.0-slim-buster

USER root

WORKDIR /home

LABEL vendor=Python38_Official_Image \
      com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2019-10-25"

# configure local directories and mount points - under ~, so folders are under use $HOME
# make persistent postgres directory in docker container
RUN mkdir -p /home/data-python && mkdir -p /home/docker-python38 && ls -al

# install linux and git tools; last line cleans up install dir for smaller docker image
RUN apt-get install -y apt &&\
    apt-get update && apt-get upgrade -y &&\
    apt-get install -y \
    bash-completion \
    curl \
    git-core \
    software-properties-common \
    sudo \
    wget \
    nodejs \
    npm \
    python3-numpy \
    python3-scipy \
    python3-dateutil \
    python3-pkg-resources \
    python3-tz \
    python3-bs4 &&\
    rm -r /var/lib/apt

# install python dependencies - include custom libs for database work
COPY ./docker-python38/requirements.txt /home/docker-python38/requirements.txt

RUN echo "" && python -m pip install --upgrade pip && python -m pip install -r /home/docker-python38/requirements.txt --src /usr/local/lib/python3.8/site-packages && rm -r /root/.cache/pip
RUN echo "" && echo "running python version:  " && python -V && echo "" && echo "at: " && which python && echo ""

# set env vars
# assume docker build context is project root using `-f` flag, not run from same folder as Dockfile (which is common)
# example comand; `docker build -f docker-python38/Dockerfile -t docker-python38 .`
# file is duplicated in each docker directory to enable docker run command from that folder individually
COPY .env.list /home/.env.list
WORKDIR /home
RUN /bin/bash -c "set -o allexport && source ./.env.list"

COPY ./docker-python38/run_jupyter_notebook.sh /home/docker-python38/run_jupyter_notebook.sh

CMD ["./docker-python38/run_jupyter_notebook.sh"]

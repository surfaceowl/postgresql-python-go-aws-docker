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
RUN apt install -y apt &&\
    apt update && apt upgrade -y &&\
    apt install -y \
    bash-completion \
    curl \
    git-core \
    software-properties-common \
    sudo \
    wget \
    nodejs \
    npm \
    python3-pandas \
    python3-numpy \
    python3-scipy \
    python3-dateutil \
    python3-pkg-resources \
    python3-tz \
    python3-bs4 \
    python3-lxml &&\
    rm -r /var/lib/apt

# install python dependencies - include custom libs for database work
COPY ./requirements.txt /home/docker-python38/requirements.txt

RUN echo "" && sudo python3 -m pip install --upgrade pip && sudo python3 -m pip install -r /home/docker-python38/requirements.txt
RUN echo "" && echo "running python version:  " && python3 -V && echo "" && echo "at: " && which python3 && echo ""

# set env vars
ENV POSTGRES_PORT 5432
ENV JUPYTER_PORT 8888

COPY ./run_jupyter_notebook.sh /home/docker-python38/run_jupyter_notebook.sh

WORKDIR /home/docker-python38

CMD ./run_jupyter_notebook.sh

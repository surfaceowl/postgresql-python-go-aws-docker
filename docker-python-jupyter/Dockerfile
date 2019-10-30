FROM python:3.8.0-slim-buster

USER root

WORKDIR /home/

LABEL vendor=Python38_Official_Image \
      com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2019-10-25"

# configure local directories and mount points - under ~, so folders are under use $HOME
# make persistent postgres directory in docker container
RUN mkdir -p ./data-python && mkdir -p ./docker-python-jupyter && ls -al

# install linux and git tools
RUN apt install -y apt &&\
    apt update && apt upgrade -y &&\
    apt install -y \
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
    python3-lxml

# install python dependencies - include custom libs for database work
COPY ./requirements.txt ./docker-python-jupyter/requirements.txt

RUN python3 -V && sudo python3 -m pip install --upgrade pip && sudo python3 -m pip install -r ./docker-python-jupyter/requirements.txt
RUN which python3

# set env vars
ENV POSTGRES_PORT 5432
ENV JUPYTER_PORT 8888

# mount volumes
# Add volumes for backup of files created/edited
VOLUME  ["./docker-python-jupyter", "./data-python"]

COPY ./run_jupyter_notebook.sh ./docker-python-jupyter/run_jupyter_notebook.sh

CMD ["./docker-python-jupyter/run_jupyter_notebook.sh"]

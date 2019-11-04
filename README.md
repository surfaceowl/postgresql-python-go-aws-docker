# postgresql-python-go-aws-docker
___


Prototype of data science pipeline on a certain tech stack, in a single docker image.  This project is a quick prototype of a data pipeline using the following technologies:  postgressql, python, go,aws on docker.
<br><br>

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

0. Docker - at a minimum you need to install and have a working installation of Docker on your system.  Installation instructions are [here](https://docs.docker.com/v17.09/engine/installation/).
1. Git client - git is our version control system, you'll need a working git client as well.  [Install instructions for Git.](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
2. Python 3.7+ installed locally (Python 3.8+ preferred)
3. Python virtualenv installed locally  [Pypi virtualenv:  pip install virtualenv](https://pypi.org/project/virtualenv/)

### Installing this repo

A step by step series of examples that tell you how to get a development env running

*0. Navigate to your development directory* - Using your terminal, navigate to the top level of your development directly.

*1. Git clone this repo* - From the terminal
```
git clone https://github.com/surfaceowl/postgresql-python-go-aws-docker.git
```

*2. Create a virtualenv named `venv` at project root using Python 3.8.*  <br>Assuming Python 3.8 is your system python, the command would be `python -m virtualenv venv`, otherwise - the command would be:  `<<absolutepath to python38 -m virtualenv venv`.  As an example, on a Windows system with Python3.8 installed but NOT the system Python, installed in default location, the command might be something like: <br>  `C:\"Program Files"\Python38\python -m virtualenv venv`.<br><br>
*3. Review login methods and credentials for these containers*  This is a demonstration repo, and credential security can quickly become complicated - so in the interest of making this repo usable and operation easily reproducible **this repo uses an insecure approach to managing login credentials.  This approach is not appropriate for production systems**.  <br><br>*For this project, we have chosen to store credentials in a single `.env` file located at project root - so they are in a single place, and docker can include these as ENV VARS in all containers created by the project.*  This is NOT secure because these credentials become available publicly in the github repo when code is committed.  *fortunately this is just a demo repo*.  <br><br>Dockerfiles are also insecure, as they too are stored in Github.  Further, docker images bake credentials and ENV vars into their images, which are also easily assessable and could be potentially available if the images are ever pushed to dockerhub.  <br><br>Another alternative - having the user manually create a known list of ENV VARs with values they privately choose, was considered but rejected.  Using local ENV vars quickly becomes unwieldy when users have large numbers of ENV VARS.  This is hard to maintain, and can be confusing - especially when similar ENV VARS are required by multiple different projects.  Finally, this approach would have introduced an error prone manual process, which is also different across different operating systems.<br><br>
*4 From the top-level folder of this project, build the Docker images* for each project containers from the included dockerfiles*<br>
*A - database container - postgresql v12.*  Navigate into `/docker-postgres`, and run <br>
```
docker build -t docker-postgres . 
```
<br>

*B - pgadmin4 - database admin GUI container.*  Navigate into `docker-pgadmin4*, and run <br>
```
docker build -t docker-pgadmin4 .
```
<br>

*C - python/jupyter notebook container.*  So you can work with the postgres database progammatically <br>
```
docker build -t docker-python38 .

```
*D - create docker volumes.*
```
docker volume create --driver local --opt type=bind --opt device=:${pwd}/docker-python38 docker-python38
```
<br><br>
*5- If you are running on windows, unfortunately `docker-compose up` does not correctly create persistent shared mounts to the folders you need access too for data persistence such as `data-postgres` for database persistence, and `docker-python38` for jupyter notebooks.  <br><br>  Therefore, from the project root folder, you can run the Docker images you just built in a new container on your local machine*<br> 
As an example, this command will run the `docker-python38` image, and create a persistent mount point for the entire project structure underneath the `home` directory in the docker container. <br><br>
`$(pwd)` finds the *current working directory*, and should work cross-platform.<b><br>
Open up three new terminal windows, and run each commands separately in it's own terminal window.
```
docker run -it -v ${PWD}:/home -p 8888:8888 docker-python38
```
Another version of this command will also run the `docker-python38` image, but only map lower level working directories as persistent volumes
```
docker run -it -v ${PWD}/docker-python38:/home/docker-python38 -v ${PWD}/data-python:/home/data-python -p 8888:8888 docker-python38
```
Note:  use `${PWD}` to build persistent shared volumes with the host inside the root dir of the project.<br>
Be sure to use docker port mapping `-p 8888:8888` so you can access the notebook from your host machine

To run the other containers, you will need to change the location you are invoking the command from, the port mapping (e.g. 8888:8888) and the name of the docker image name.
```
docker run -it -v ${PWD}/docker-postgres:/var/lib/pgadmin -v ${PWD}/data-postgres:/home/data-postres -p 5432:5432 docker-postgres
```

```
docker run -it --env PGADMIN_DEFAULT_EMAIL=1234@admin.com --env PGADMIN_DEFAULT_PASSWORD=1234 -v ${PWD}/docker-pgadmin4:/home/docker-pgadmin4 -v ${PWD}/data-postgres:/home/data-postres -p 5050:80 docker-pgadmin
```
*6 - To run all the containers at once.*  Navigate to the project root folder, and run `docker-compose up` from the terminal.  That command will invoke the docker configuration specified in the file `docker-compose.yml`, which in turn links to the `Dockerfiles` which were illustrated in the previous steps.
e.g for postgresql - the terminal commands including persistent mounts would be:
```

```

## Running the tests

Pass - tests to be developed later.


## Deployment

Project currently assumes that we will use the automatically provided Docker `bridge` network on local machines, which opens all ports to all local containers - facilitating communication between containers.  Our project does include opening specific ports now, as we anticipate adding a custom local bridge and automated setup/teardown scripts at a later date.
From a terminal at the root directory of this project, run `docker-compose up`.  Then open multiple browser tabs, and point them to the containers (e.g. the python jupyter notebooks is at http://127.0.0.1:8888 (password is `test`); pgadmin4 is at 127.0.0.1:5050, etc.)


## Using this repo

After building the docker images and successfully running the cluster of containers with `docker-compose up`, you can administer the system with:<br>
*terminal* - used to run `docker-compose up` will show stdout, all system messages from all containers<br>
*browser:*  http://127.0.0.1:5050/browser/#  -- pgadmin4, GUI to administer postgresql<br>
*browser:*  http://127.0.0.1:8888  -- jupyter notebook, to run python programs against the postgresql database<br>

## Built With

* [Docker](https://docs.docker.com/v17.09/engine/installation/) - The OS virtualization platform
* [Git / Github](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) - Software version control
* [Python 3.8](https://www.python.org/downloads/release/python-380/) - Core programming language
* [Postgresql](https://www.postgresql.org/) - Open source object relational database
* [Docker Hub - postgres](https://hub.docker.com/_/postgres) - Official images for OS, Postgresql, Python, etc.
* [Pycharm](https://www.jetbrains.com/pycharm/download/#section=windows) - IDE used to create this project, not required just to clone and run; PyCharm Community Edition is free to use 

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Chris Brousseau** - *Initial work* - [SurfaceOwl](https://github.com/surfaceowl)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc

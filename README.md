# postgresql-python-go-aws-docker
___


Prototype of data science pipeline on a certain tech stack, in a single docker image.


## command to run with persistent mounts from project root (pwd)
docker run -it --rm -v ${pwd}/postgres-data:/postgres-data postgres-docker:latest /bin/bash

# Illustrate postgresql-python-go-aws-docker

This project is a quick prototype of a data pipeline using the following technologies:  postgressql, python, go,aws on docker.
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

0. Docker - at a minimum you need to install and have a working installation of Docker on your system.  Installation instructions are [here](https://docs.docker.com/v17.09/engine/installation/).
1. Git client - git is our version control system, you'll need a working git client as well.  [Install instructions for Git.](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)


### Installing this repo

A step by step series of examples that tell you how to get a development env running

*0. Navigate to your development directory* - Using your terminal, navigate to the top level of your development directly.

*1. Git clone this repo* - From the terminal
```
git clone https://github.com/surfaceowl/postgresql-python-go-aws-docker.git
```

*2. From the top-level folder of this project, build the Docker image from the included dockerfile*
```
docker build -t postgres-docker . 
```

*3- From the same location, run the Docker image you just built in a new container on your local machine*<br> 
This command will create create a persistent mount point at `postgres-data`, so your database will be retained between uses of the Docker container.  `$(pwd)` finds the *current working directory*, and should work cross-platform.
```
docker run -it --rm -v ${pwd}/postgres-data:/postgres-data postgres-docker:latest /bin/bash 
```

## Running the tests

Pass - tests to be developed later.


## Deployment

Pass - deployment instructions to be developed later


## Using this repo
Python path is:  `/usr/local/bin#`<br>
Postgresql path is:  
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

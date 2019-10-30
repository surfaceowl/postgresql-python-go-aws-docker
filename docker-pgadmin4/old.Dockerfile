FROM dpage/pgadmin4

USER root

WORKDIR /home/
# configure local directories and mount points
# make persistent postgres directory in docker container
RUN mkdir -p ./docker-postgres && mkdir -p ./data-postgres && ls -al

# Add volumes for postgres database
VOLUME  ["./docker-postgres", "./data-postgres"]

# pgadmin required environment vars
ENV PG_MODE=primary
ENV PG_PRIMARY_USER=user00
ENV PG_PRIMARY_PASSWORD=user00
ENV PG_DATABASE=testdb
ENV PG_USER=user00
ENV PG_PASSWORD=user00
ENV PG_ROOT_PASSWORD=postgres
ENV PG_PRIMARY_PORT=5432
ENV PGADMIN_SETUP_EMAIL=youremail@yourdomain.com
ENV PGADMIN_SETUP_PASSWORD=yoursecurepassword
ENV SERVER_PORT=5050

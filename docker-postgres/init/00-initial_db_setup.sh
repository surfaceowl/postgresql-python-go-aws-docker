#!/bin/bash
# script to create an empty db when docker container run

# script exits immediately on any error during the script
set -o errexit

# create array for env vars - this can be consumed later via array variable expansion ${REQUIRED_ENV_VARS[@]}.
readonly REQUIRED_ENV_VARS=(
  "INITIAL_DB_USER"
  "INITIAL_DB_PASSWORD"
  "INITIAL_DB_DATABASE"
  "POSTGRES_USER")


# Main execution:
# - verifies all env vars are set
# - runs the SQL to create user and database
main() {
  check_env_vars_set
  init_user_and_db
}

# Checks if all required environment vars are set.
# If FALSE, script echoes a text explaining which env vars are missing
check_env_vars_set() {
  for required_env_var in ${REQUIRED_ENV_VARS[@]}; do
    if [[ -z "${!required_env_var}" ]]; then
      echo "Error:
    Environment variable '$required_env_var' is not set.
    Modify your Dockerfile to set the following ENV vars:
      ${REQUIRED_ENV_VARS[@]}
...aborting script."
      exit 1
    fi
  done
}


# Initializes the already-started Postgresql server using POSTGRES_USER user.
init_user_and_db() {
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
     CREATE USER $INITIAL_DB_USER WITH PASSWORD '$INITIAL_DB_PASSWORD';
     CREATE DATABASE $INITIAL_DB_DATABASE;
     GRANT ALL PRIVILEGES ON DATABASE $INITIAL_DB_DATABASE TO $INITIAL_DB_USER;
EOSQL
}

# Executes the main routine with environment variables
# passed through the command line. We don't use them in
# this script but now you know 🤓
main "$@"

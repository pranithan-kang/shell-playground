#!/bin/bash

# Default Values
LOAD_FIXTURE=true;
ENVIRONMENT="dev";
HOST="localhost";
PORT=10000;


# NOTE:
# ${i#*=}
# Substring Removal topic in https://tldp.org/LDP/abs/html/string-manipulation.html

# From
# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
for i in "$@"; do
    case $i in
        -e=*|--environment=*)
            ENVIRONMENT="${i#*=}"
            ;;
        -h=*|--host=*)
            HOST="${i#*=}"
            ;;
        -p=*|--port=*)
            PORT="${i#*=}"
            ;;
        -?|--help)
            cat << EHELP
Runserver with Django manage.py
usage: source runserver.py [options]

-e|--environment=(dev|prod)     fixture source environment name
-h|--host=(hostname|ip)         hostname that the server will running
-p|--port=number                port that the server will running
EHELP
            ;;
        -*|--*)
            echo "Unknown option $i";
            exit 0;
            ;;
        *)
            ;;
    esac
done

if [ $LOAD_FIXTURE = true ] ; then
    ./manage.py loaddata "./core/fixtures/$ENVIRONMENT/*"
fi

./manage.py runserver "$HOST:$PORT"

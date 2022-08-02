#!/bin/bash

# A shell script because I am too lazy to type a couple of extra lines every single time I want to create a new Django project
# Obviously, without being said, it's a requirement for the script to have virtualenv installed.... and Python....
# Do what you want with the script, I won't lose any sleep over it. 

command=$1

create_venv() {
    echo "Creating virtual environment..."
    python3 -m venv venv
    echo "Done!"
}
source_venv() {
    echo "\nActivating virtual environment..."
    . ./venv/bin/activate
    echo "Done!"
}
create_config() {
    . ./venv/bin/activate
    echo -e '\nInstalling Django:\n'
    pip install django
    echo '\nDone!\n'
    echo -e '\nWhat would you like to name the project?'
    read project_name
    django-admin startproject $project_name .
}
migrate() {
    python manage.py makemigrations
    python manage.py migrate
}
skeleton() {
    # Will git clone a basic skeleton for a django app
}

if [[ -z $command ]]
    then
        echo 'This script needs an argument in order to run the script. Or you can use help as the argument.'
elif [[ $command == 'help' ]]
    then
        echo '\nThe following is a list of arguments for this script:'
        echo '\ncreate\n\nThis starts a new Django project within a virtual environment and starts the core project\n'
        echo 'migrate\n\nThis calls Djangos built-in makemigrations and migrate sub-commands\n'
elif [[ $command == 'create' ]]
    then
        create_venv
        source_venv
        create_config
elif [[ $command == 'migrate' ]]
    then
        migrate
fi

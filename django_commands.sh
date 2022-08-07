#!/bin/bash
# A shell script because I am too lazy to type a couple of extra lines every single time I want to create a new Django project
# A couple requirements are virtual environment, python, and git

command=$1

create_venv() {
    echo "\nCreating virtual environment..."
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
    echo '\nWhich type of project?\n1) Regular Django Project\n2) Django API'
    read project_type

    if [[ $project_type == '1' ]]
        then
            echo "\nCloning Django project..."
            git clone git@github.com:EclecticOwl/django-skeleton.git
            cd django-skeleton
            create_venv
            source_venv
            echo '\nInstalling dependencies'
            pip install -r requirements.txt
    else
            echo "\nCloning Django project..."
            git clone git@github.com:EclecticOwl/django-skeleton-api.git
            cd django-skeleton-api
            create_venv
            source_venv
            echo '\nInstalling dependencies'
            pip install -r requirements.txt
    fi
    gi python
}

if [[ -z $command ]]
    then
        echo 'This script needs an argument in order to run the script. Or you can use help as the argument.'
elif [[ $command == 'help' ]]
    then
        echo '\nThe following is a list of arguments for this script:'
        echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        echo '\ncreate: This starts a new Django project within a virtual environment and starts the core project\n'
        echo "migrate: This calls Django\'s built-in makemigrations and migrate sub-commands\n"
        echo 'skeleton: This gives an option of git clone for a regular django project or the api version using django-rest-framework'
        echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
elif [[ $command == 'create' ]]
    then
        create_venv
        source_venv
        create_config
elif [[ $command == 'migrate' ]]
    then
        migrate
elif [[ $command == 'skeleton' ]]
    then
        skeleton
fi



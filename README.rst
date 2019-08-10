#######################################
Django setup for container environment
#######################################

For a beginner Django user may be hard to start using containers. Besides having to deal with a web server and static files, it is necessary to understand how the stack will work in containers.

This base project is configured with Postgres as a database, Gunicorn as a dynamic server, and Nginx as static server and reverse proxy.

To use, the developer needs to clone this repository, to create the apps and associate them to the portal Django project. So it is time to run the dockerfile, docker-compose, and docker-machine commands.

For the first contact with containers developers, this repository offers one of the possible options of deployment a simple Django project in containers, to serve as a base in the process of learning of the docker tool.

After understanding the basic container development process, the developer can use his process or go further and start using some container orchestrator.

*****************************
Release notes - version 1.1.1
*****************************

Changes
=======

It was changed the python environment manager from **venv** to **pipenv**.

It was removed the **testing step**. TDD approach, testing in all steps.

It was reduced from two to one **nginx container**.

Docker images versions updated and other minor changes.

Requirements
============

Python installed in the host (developer computer).

Linux Operating System on the host. For Windows or Mac, small adjustments are needed.

VPS (Virtual Private Server) provider.

Docker-engine installed on server.

Docker-machine installed on host.

Domain Address (like www.example.com).

********
Road map
********

#. Traefic as reverse proxy.
#. Ansible to automate VPN configurations.
#. Swarm to deal with secrets and conf files.

************
Contribution
************

It is just a personal project to share experiences.

Any issue reports are welcome, but it maybe takes a while to answer.

New features are difficult to implement for a matter of priorities, but feel free to ask help.

***********
Preparation
***********

Clone the repository.

.. code-block:: bash

  # Git configurations.
  git config --local user.email "user@example.com"
  git config --local user.name "User Name"

  # Download the code from the repository.
  git clone https://gitlab.com/raill/django_container_setup.git .

  # Remove the README and git folder.
  rm -rf .git README.rst

.. note:: Create a new git repository in the ``code`` folder, if you wish to control the versions of your code.

Folder tree
===========

The main directories
--------------------

The repository is organized with one folder for Django files ``code/``, and other to environment files ``environment/``.

The static folder only appears after the ``python manage.py collectstatic`` command be executed.

.. code-block:: bash

  .
  ├── code              # application code.
  │   ├── dev-static    # static files in development.
  │   ├── manage.py
  │   ├── Pipfile       # pipenv configuration file.
  │   ├── Pipfile.lock  # pipenv configuration file.
  │   └── portal        # Django project.
  ├── environment       # Containers and key generation.
  │   ├── containers
  │   └── secrets
  ├── letsencrypt        # Cetificate keys.
  ├── README.rst
  ├── stag-static       # static files in staging.
  └── static            # static files in produciton.

The full directories tree
-------------------------

After cloning the repository, the structure of directories and files will be like below.

.. code-block:: bash

  .
  ├── code
  │   ├── dev-static
  │   ├── manage.py
  │   ├── Pipfile
  │   ├── Pipfile.lock
  │   └── portal
  │       ├── db.sqlite3
  │       ├── __init__.py
  │       ├── settings
  │       │   ├── base.py
  │       │   ├── dev.py
  │       │   ├── __init__.py
  │       │   ├── prod.py
  │       │   └── stag.py
  │       ├── urls.py
  │       └── wsgi.py
  ├── environment
  │   ├── containers
  │   │   ├── django-dev.dockerfile
  │   │   ├── django-prod.dockerfile
  │   │   ├── django-stag.dockerfile
  │   │   ├── docker-compose-prod.yml
  │   │   ├── docker-compose-stag.yml
  │   │   ├── nginx-prod.conf
  │   │   ├── nginx-prod.dockerfile
  │   │   ├── nginx-stag.conf
  │   │   └── nginx-stag.dockerfile
  │   └── secrets
  │       ├── assign_secrets.sh
  │       └── create_secrets.py
  ├── letsencrypt
  ├── README.rst
  ├── stag-static
  └── static


Create a python environment and install packages 
================================================

.. note:: Run the command inside the ``code`` folder.

.. code-block:: bash

  cd code

  # Create a virtualenv
  pipenv install

  # Start the pipenv shell interface
  pipenv shell

Create secrets
==============

Run the command below to create the SECRET_KEY and SECRET_DB variables.

The command should be run inside assign_secrets.sh and create_secrets.py folder.

.. code-block:: bash

  cd environment/secrets

  # This script will call the create_secrets.py
  source assign_secrets.sh

    the SECRET_KEY was set.
    the SECRET_DB was set.

  # Return to root folder.
  cd ../..

If Django is NOT installed, the message will be:

.. code-block:: bash

  source assign_secrets.sh

  Django package is NOT installed.
  the SECRET_KEY was NOT set.
  the SECRET_DB was NOT set.

Steps details
=============

The procedures of development were divided into steps. Each step has its own configurations and purpose, as described in each section.

To define, just include the ``--settings`` option in the Django commands.

The default **setting** is **production**. So it isn't necessary to use the ``--settings`` flag.

Examples:

.. code-block:: bash

  python manage.py runserver --settings=portal.settings.dev

  python manage.py migrate --settings=portal.settings.dev

  python manage.py makemigrations --settings=portal.settings.stag

  # The production is the default settings.
  python manage.py createsuper user --email some@address.com --username admin

***********
Development
***********

The purpose of the **development step** is to write code.

    **Server environment**: local computer.

    **Dynamic server**: Django test webserver.

    **Static server**: Django test webserver.

    **Reverse proxy**: No.

    **Database**: sqlite3.

    **Network**: HTTP localhost.

    **Container interface**: no.

Check the development settings
==============================

.. note:: Run the commands from the ``code`` directory.

The secrets need to be created. See **Create secrets** section.

The commands above will run the Django project in development settings.

.. code-block:: bash

  # Install the packages.
  pipenv install 

  python manage.py collectstatic --settings=portal.settings.dev
  python manage.py makemigrations --settings=portal.settings.dev
  python manage.py migrate --settings=portal.settings.dev
  python manage.py runserver --settings=portal.settings.dev

Then check in your browser the address `localhost:8000 <http://localhost:8000/>`_ the
default mesage of the Django webserver.

To create the admin, run the command below.

.. code-block:: bash

  python manage.py createsuperuser --user admin --email admin@example.com --settings=portal.settings.dev

Create an app
=============

If everything works fine, it's time to create an app.

.. code-block:: bash

  # From code directory
  django-admin startapp app_name

Write code
==========

With the development server working, it is time to **write code** :)

*******
Staging
*******

The purpose of the **staging step** is to check the application in a container configuration.

The secrets need to be created. See **Create secrets** section in this file.

  **Server environment**: local computer.
  
  **Dynamic server**: Nginx.

  **Static server**: gunicorn.

  **Reverse proxy**:  Nginx.

  **Database**: Postgres.

  **Network**: HTTP localhost.

  **Container interface**: docker-engine.

docker container commands
=========================

Collect static
--------------

.. note:: Run the command inside the ``code`` folder.

.. code-block:: bash

  python manage.py collectstatic --settings=portal.settings.stag

Create the images and the containers
------------------------------------

.. note:: Run the command from the ``root`` folder.

.. code-block:: bash

  # Create django image
  docker build -t django-stag -f environment/containers/django-stag.dockerfile .
  
  # Create nginx image
  docker build -t nginx-stag -f environment/containers/nginx-stag.dockerfile .
  
  
  # Run composed containers in background
  docker-compose -p source -f environment/containers/docker-compose-stag.yml up -d

  # Stop containers
  docker-compose -p source -f environment/containers/docker-compose-stag.yml stop
  
  # Remove containers
  docker-compose -p source -f environment/containers/docker-compose-stag.yml rm


  # Remove images
  docker rmi django-stag nginx-stag
  
  # Remove volume
  docker volume rmi source_db-web
  
Create the Django admin access
------------------------------- 
  
.. code-block:: bash

  docker exec -it blog bash
  
  python manage.py createsuperuser --user admin --email admin@local.host --settings=portal.settings.stag


**********
Production
**********

The purpose of the **Production step** is to deploy the service.

The **DNS and domain** should be configured after create a droplet.

I'll be used the **Digital Ocean** as an example.

The secrets need to be created. See **Create secrets** section in this file.
 
  **Server environment**: provider (Like Digital Ocean).

  **Dynamic server**: Nginx.

  **Static server**: Gunicorn.

  **Reverse proxy**:  Nginx.

  **Database**: Postgres.

  **Network**: HTTPS (Internet).
 
  **Container interface**: docker-machine.

Obtain the Let's Encrypt authentication files
=============================================

Follow the steps in this `repository <https://gitlab.com/raill/lets-encrypt-certificate-from-container/>`_ to obtain the certificates files.

Copy the folder ``live/`` to the letsencrypt folder in the root directory.

Collect static
==============

.. note:: Run the command inside the ``code`` folder.

.. code-block:: bash

  python manage.py collectstatic

Access Digital Ocean
====================

After obtaining the Digital Ocean Token API from your account configurations,
run the commands below to create a droplet.

.. code-block:: bash
  
  # Insert your password between the single quotation marks.
  DIGITAL_OCEAN_TOKEN='token_password_to_access_digital_ocean' 

  docker-machine create --driver digitalocean --digitalocean-access-token $DIGITAL_OCEAN_TOKEN production

  eval $(docker-machine env production)

Include the domain in nginx configurations
==========================================

Change the **EXAMPLE.COM** to the project domain in the file

``environment/staging/nginx-prod.conf``.


docker container commands
=========================

.. note:: Run the command from the ``root`` folder.

.. code-block:: bash

  # Create django image
  docker build -t django-prod -f environment/containers/django-prod.dockerfile .

  # Create nginx image
  docker build -t nginx-prod -f environment/containers/nginx-prod.dockerfile .


  # Run composed containers in background
  docker-compose -p source -f environment/containers/docker-compose-prod.yml up -d

  # stop containers
  docker-compose -p source -f environment/containers/docker-compose-prod.yml stop

  # Remove containers
  docker-compose -p source -f environment/containers/docker-compose-prod.yml rm

  # Remove images
  docker rmi django-stag nginx-stag

  # Remove volume
  docker volume rmi source_db-web


Create the Django admin access
------------------------------

.. code-block:: bash

  docker exec -it blog bash

  python manage.py createsuperuser --user admin --email admin@example.com


Removing the droplet
--------------------

.. code-block:: bash

  # Stop droplet
  docker-machine stop production

  # Remove droplet
  docker-machine rm production

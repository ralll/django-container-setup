#######################################
Django setup for container environment
#######################################

For a beginner django user may be hard to start using containers. Besides having to deal a with web server and static files, it is necessary to understand how the stack will work in containers.

This base project is configured with Postgres as database, Gunicorn as dinamic server, and Nginx as static server and reverse proxy.

The developer just need to clone this repository, to create the apps and associate them to the **portal** project, and run the dockerfile, docker-compose and docker-machine commands.

For the first contact with containers developers, this repository offers one of the possible options of deployment a simple django project in containers, to serve as base in the process of learning of the docker tool.

After understanding the basic container development process, the developer can use his own proces or go further and start using some container orchestrator.

******************
Index
******************

Command line environment reference.

`Preparation`_

`Development`_

`Testing`_

`Staging`_

`Production`_

#######################################
Steps details
#######################################

The procedures of development were divided in Steps. Each step has its own configurations and purpose, as describe bellow.

To define, just include the ``--settings`` option in the django commands. Examples:

.. code-block:: bash

  python manage.py runserver --settings=portal.settings.development

  python manage.py runserver migrate --settings=portal.settings.testing

  python manage.py makemigrations --settings=portal.settings.staging

  python manage.py createsuper user --email some@address.com --username some_name --settings=portal.setttings.deployment


******************
Development step
******************
  For writing code.

* **Server environment:** local host.
* **Dinamic server:** django test webserver.
* **Static server:** django test webserver.
* **Reverse proxy:** No.
* **Database:** sqlite3.
* **Network:** HTTP localhost.
* **Container inteface**: no.

******************
Testing step
******************
  For testing the code in the container, local machine.

* **Server environment:** localhost.
* **Dinamic server:** Nginx.
* **Static server:** Gunicorn.
* **Reverse proxy:**  Nginx.
* **Database:** Postgres.
* **Network:** HTTP (local network).
* **Container inteface**: docker cli (command line interface).

******************
Staging step
******************
  **warning:** This step will be finished soon...

  For testing the code in the container, included with internet access, in the remote server.

* **Server environment:** provider (Like Digital Ocean).
* **Dinamic server:** Nginx.
* **Static server:** Gunicorn.
* **Reverse proxy:**  Nginx.
* **Database:** Postgres.
* **Network:** HTTPS (Internet).
* **Container inteface**: docker-machine.

******************
Production step
******************
  **warning:** This step will be finished soon...

  For deployment in the remote server.

* **Server environment:** provider (Like Digital Ocean).
* **Dinamic server:** Nginx.
* **Static server:** Gunicorn.
* **Reverse proxy:**  Nginx.
* **Database:** Postgres.
* **Network:** HTTPS (Internet).
* **Container inteface**: docker-machine.

#######################################
Command line sequence
#######################################

******************
Preparation
******************

Execute preparation commands before the environments commands bellow.

.. code-block:: bash

  # Create a folder for python environments.
  mkdir ~/.envs
  cd ~/.envs/

  # Create a virtualenv name "portal".
  python -m venv portal
  mkdir portal/source
  cd portal/source
  source ../bin/activate

  # Git configurations.
  git config user.email "user@example.com"
  git config user.name "User Name"

  # Download the code from the repository.
  git clone git@gitlab.com:raill/django_container_setup.git .

  # Remove existing git data.
  rm -rf .git
  echo "" > README.rst

  # git configurations.
  git init
  git add .dockerignore .gitignore README.rst code/ environment
  git commit -m "Project started."
  git remote add origin git@gitlab.com:some_user/project_name.git
  git push --set-upstream -u origin master


Folder tree
================

The main directories:
------------------------------------------

The repository is organized with one folder for django files ``code/``, and other to environment files ``environment/``.

::

    project
    .
    ├── code
    ├── environment
    ├── README.rst
    ├── .dockerignore
    └── .gitignore

The full directories tree:
------------------------------------------

After clonning the repository, the structure of directories and files will be like bellow.

::

    project
    .
    ├── code
    │   ├── db.sqlite3
    │   ├── manage.py
    │   └── portal
    │       ├── settings
    │       │   ├── __init__.py
    │       │   ├── base.py
    │       │   ├── development.py
    │       │   ├── staging.py
    │       │   └── testing.py
    │       ├── urls.py
    │       └── wsgi.py
    ├── environment
    │   ├── requirements
    │   │   ├── base.pip
    │   │   ├── development.pip
    │   │   ├── production.pip
    │   │   ├── staging.pip
    │   │   └── testing.pip
    │   ├── secrets
    │   │   ├── assign_secrets.sh
    │   │   └── create_secrets.py
    │   ├── staging
    │   │   ├── django.dockerfile
    │   │   ├── docker-compose.yml
    │   │   ├── nginx_proxy.conf
    │   │   ├── nginx_proxy.dockerfile
    │   │   ├── nginx_static.conf
    │   │   └── nginx_static.dockerfile
    │   └── testing
    │       ├── django.dockerfile
    │       ├── docker-compose.yml
    │       ├── nginx.conf
    │       ├── nginx_proxy.dockerfile
    │       └── nginx_static.dockerfile
    ├── README.rst
    ├── .dockerignore
    └── .gitignore

Create secrets
=====================

Run the command bellow to create the SECRET_KEY and SECRET_DB variables.

The command should be run inside assign_secrets.sh and create_secrets.py folder.

.. code-block:: bash

  cd environment/secrets

  # This script will call the create_secrets.py
  source assign_secrets.sh

    the SECRET_KEY was set.
    the SECRET_DB was set.

  cd ../..

If django is NOT installed, the message will be:

.. code-block:: bash

  source assign_secrets.sh

  Django package is NOT installed.
  the SECRET_KEY was NOT set.
  the SECRET_DB was NOT set.

******************
Development
******************

  **warning:** Run the commands from the ``code`` directory.

The secrets need to be created. See `Create secrets`_

.. code-block:: bash

  pip install -r ../environment/requirements/development.pip

  python manage.py makemigrations --settings=portal.settings.development

  python manage.py migrate --settings=portal.settings.development

  python manage.py runserver --settings=portal.settings.development

Then check in your browser the address `localhost:8000 <http://localhost:8000/>`_ the
default mesage of the django webserver.


Create an app
================

If everything works fine, it's time to create an app.

.. code-block:: bash

  # From code directory
  django-admin startapp app_name

Write code
==========

With the development server working, it is time to write code.

******************
Testing
******************

  **warning:** The django commands should be run from the ``code`` directory,
  The environment commands from the root project directory.

The secrets need to be created. See `Create secrets`_

.. code-block:: bash

  ## FROM THE CODE DIRECTORY ##

  # Collect static files.
  cd code
  python manage.py collectstatic --settings=portal.settings.development
  cd ..

  ## FROM THE ROOT PROJECT DIRECTORY ##

  # Creating images
  docker build -t django_testing -f environment/testing/django.dockerfile .

  docker build -t nginx_static_testing -f environment/testing/nginx_static.dockerfile .

  docker build -t nginx_proxy_testing -f environment/testing/nginx_proxy.dockerfile .

  # Starting the services
  docker-compose -f environment/testing/docker-compose.yml up --build -d

  # Stoping the services
  docker-compose -f environment/testing/docker-compose.yml stop

  # Removing the containers
  docker-compose -f environment/testing/docker-compose.yml rm

  # Deleting images
  docker rmi django_testing nginx_static_testing nginx_proxy_testing

Then check in your browser the address `localhost <http://localhost/>`_ the
default mesage of the django webserver.

******************
Staging
******************

The purpose of this step is to test the code in a remote provider.

The DNS and domain should be configured after create droplet.

I'll be used **Digital Ocean** as an example.

The secrets need to be created. See `Create secrets`_

Access Digital Ocean
=====================

After obtain the Digital Ocean Token API from your account configurations,
run the commands bellow to create a droplet.

.. code-block:: bash

  DIGITAL_OCEAN_TOKEN='token_password_to_access_digital_ocean'

  docker-machine create --driver digitalocean --digitalocean-access-token $DIGITAL_OCEAN_TOKEN staging

  eval $(docker-machine env staging)


Obtain the Let's Encrypt autentication files
============================================

Follow the steps in this `repository <https://gitlab.com/raill/lets-encrypt-certificate-from-container/>`_ to obtain the certificates files.

Copy the folder ``live/`` The from the folder tree ``_data/live/some_domain_example.com/`` to the docker volume with letsencrypt.

Insert the domain
============================================

Change the **EXAMPLE.COM** to the project domain in the files:

#. environment/staging/nginx_proxy.conf


docker container commands
==========================

.. code-block:: bash

  # Create django image
  docker build -t django_staging -f environment/staging/django.dockerfile .

  # Create nginx static and proxy images
  docker build -t nginx_static_staging -f environment/staging/nginx_static.dockerfile .

  docker build -t nginx_proxy_staging -f environment/staging/nginx_proxy.dockerfile .

  # Create composed containers
  docker-compose -f environment/staging/docker-compose.yml up -d --build

  # Stop composed containers
  docker-compose -f environment/staging/docker-compose.yml stop

  # Remove composed container
  docker-compose -f environment/staging/docker-compose.yml rm

  # Remove images
  docker rmi django_staging nginx_static_staging nginx_proxy_staging

.

  Remember to move the certificates to ``/etc/letsencrypt``.

Removing droplet
==========================

.. code-block:: bash

  # Stop droplet
  docker-machine stop staging

  # Remove droplet
  docker-machine rm staging


******************
Production
******************

The purpose of this step is to deploy the service.

The DNS and domain should be configured after create droplet.

I'll be used **Digital Ocean** as an example.

The secrets need to be created. See `Create secrets`_

Access Digital Ocean
=====================

After obtain the Digital Ocean Token API from your account configurations,
run the commands bellow to create a droplet.

.. code-block:: bash

  DIGITAL_OCEAN_TOKEN='token_password_to_access_digital_ocean'

  docker-machine create --driver digitalocean --digitalocean-access-token $DIGITAL_OCEAN_TOKEN production

  eval $(docker-machine env production)


Obtain the Let's Encrypt autentication files
============================================

Follow the steps in this `repository <https://gitlab.com/raill/lets-encrypt-certificate-from-container/>`_ to obtain the certificates files.

Copy the folder ``live/`` The from the folder tree ``_data/live/some_domain_example.com/`` to the docker volume with letsencrypt.

Insert the domain
============================================

Change the **EXAMPLE.COM** to the project domain in the files:

#. environment/staging/nginx_proxy.conf


docker container commands
==========================

.. code-block:: bash

  # Create django image
  docker build -t django_production -f environment/production/django.dockerfile .

  # Create nginx static and proxy images
  docker build -t nginx_static_production -f environment/production/nginx_static.dockerfile .

  docker build -t nginx_proxy_production -f environment/production/nginx_proxy.dockerfile .

  # Create composed containers
  docker-compose -f environment/production/docker-compose.yml up -d --build

  # Stop composed containers
  docker-compose -f environment/production/docker-compose.yml stop

  # Remove composed container
  docker-compose -f environment/production/docker-compose.yml rm

  # Remove images
  docker rmi django_production nginx_static_production nginx_proxy_production

.

  Remember to move the certificates to ``/etc/letsencrypt``.

Removing droplet
==========================

.. code-block:: bash

  # Stop droplet
  docker-machine stop production

  # Remove droplet
  docker-machine rm production

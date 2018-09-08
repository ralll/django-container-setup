from .base import *

SECRET_KEY = 'y+6u$pagc%0-uzyan&moqx0p+*(ks2rp0g@y2@-47pf^v78yg3'

DEBUG = True

ALLOWED_HOSTS = ['docker-web']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'testing_db_name',
        'USER': 'testing_user',
        'PASSWORD': 'testing_password',
        'HOST': 'db',
        'PORT': '5432',
    }
}

STATIC_URL = '/static/'

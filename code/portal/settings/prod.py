import os
from .base import *

SECRET_KEY = os.environ['SECRET_KEY']
SECRET_DB = os.environ['SECRET_DB']

DEBUG = False

ALLOWED_HOSTS = ['docker-web']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'web-db',
        'USER': 'web-user',
        'PASSWORD': SECRET_DB,
        'HOST': 'db',
        'PORT': '5432',
    }
}

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(os.path.dirname(os.path.dirname(BASE_DIR)), "static")

SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True
SECURE_BROWSER_XSS_FILTER=True
X_FRAME_OPTIONS="DENY"

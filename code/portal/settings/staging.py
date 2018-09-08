from .base import *

SECRET_KEY = os.environ['SECRET_KEY']
SECRET_DB = os.environ['SECRET_DB']

DEBUG = True

ALLOWED_HOSTS = ['docker-web', ]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'staging_db',
        'USER': 'staging_db_user',
        'PASSWORD': SECRET_DB,
        'HOST': 'db',
        'PORT': '5432',
    }
}

STATIC_URL = '/static/'

SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True
SECURE_BROWSER_XSS_FILTER=True
X_FRAME_OPTIONS="DENY"

from .base import *

SECRET_KEY = 'y+6u$pagc%0-uzyan&moqx0p+*(ks2rp0g@y2@-47pf^v78yg3'

DEBUG = True

ALLOWED_HOSTS = ['*']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

STATIC_ROOT = './dev-static/'
STATIC_URL = '/static/'

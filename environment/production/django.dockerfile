FROM python:3
ENV PYTHONUNBUFFERED 1

RUN mkdir /code
WORKDIR /code
COPY ./code/ /code/

COPY ./environment/requirements /code/requirements
RUN pip install -r requirements/staging.pip

CMD sleep 3; gunicorn portal.wsgi:application --env DJANGO_SETTINGS_MODULE=portal.settings.production --bind 0.0.0.0:8000;

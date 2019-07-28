FROM python:3.7
ENV PYTHONUNBUFFERED 1
EXPOSE 8001

COPY ./code /code
WORKDIR /code

RUN pip install pipenv; \
    pipenv install --system --deploy;

CMD sleep 5 && \
    python manage.py makemigrations --settings=portal.settings.stag && \
    python manage.py migrate --settings=portal.settings.stag  && \
    gunicorn portal.wsgi:application \
        --bind 0.0.0.0:8001 \
        --env DJANGO_SETTINGS_MODULE=portal.settings.stag;

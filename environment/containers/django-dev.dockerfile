FROM python:3.7
ENV PYTHONUNBUFFERED 1

EXPOSE 8001

COPY ./code /code
WORKDIR /code


RUN pip install pipenv; \
    pipenv install --dev --system --deploy;

RUN python manage.py makemigrations --settings=portal.settings.dev

CMD python manage.py migrate --settings=portal.settings.dev && \
    python manage.py runserver --settings=portal.settings.dev 0.0.0.0:8001

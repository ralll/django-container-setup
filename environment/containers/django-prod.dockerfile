FROM python:3.7
ENV PYTHONUNBUFFERED 1
EXPOSE 8001

COPY ./code /code
WORKDIR /code

RUN pip install pipenv; \
  pip install --upgrade pip; \
  pipenv install --system --deploy;

CMD sleep 5 && \
 python manage.py makemigrations && \
 python manage.py migrate && \
 gunicorn portal.wsgi:application \
 --bind 0.0.0.0:8001 \

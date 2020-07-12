FROM python:3.7

ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y libpq-dev musl-dev build-essential python3-dev python3-psycopg2

RUN mkdir /code
WORKDIR /code
ADD ./ /code/

RUN pip install -r requirements.txt

CMD ["python3", "first_two_email.py" ]
FROM balenalib/raspberry-pi-alpine-python:3.11.2-3.15-run

WORKDIR /usr/src/app

RUN apk add build-base zlib-dev freetype-dev libjpeg-turbo-dev

COPY ./requirements.txt .

RUN pip install -t /usr/src/python-packages -r requirements.txt --no-cache-dir --extra-index-url=https://www.piwheels.org/simple

RUN apk del build-base

COPY VERSION ./

COPY src ./src
ENV PYTHONPATH=/usr/src/python-packages/

CMD ["python3", "src/main.py"]

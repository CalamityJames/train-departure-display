FROM balenalib/raspberry-pi-alpine-python:3.11.2-3.15-build as builder

WORKDIR /usr/src/app

RUN apk add zlib-dev freetype-dev libjpeg-turbo-dev

COPY ./requirements.txt .

RUN pip install --target=/usr/src/python-packages -r requirements.txt --no-cache-dir

FROM balenalib/raspberry-pi-alpine-python:3.11.2-3.15-run

COPY --from=builder /usr/src/python-packages/ /usr/src/python-packages/

WORKDIR /usr/src/app

COPY src ./src

ENV PYTHONPATH=/usr/src/python-packages

CMD ["python3", "src/main.py"]

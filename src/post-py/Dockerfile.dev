FROM python:3.6.0-alpine

RUN apk add --no-cache gcc musl-dev

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip install -r requirements.txt


COPY . /app

ENTRYPOINT ["python3", "post_app.py"]

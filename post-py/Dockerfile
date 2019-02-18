FROM python:3.6.0-alpine

RUN pip install flask pymongo python-dotenv

WORKDIR /app
COPY . /app

ENTRYPOINT ["python3", "post_app.py"]

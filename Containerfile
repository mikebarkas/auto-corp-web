# syntax=docker/dockerfile:1.4
FROM python:3.14.0a6-alpine3.21
RUN addgroup -S nonroot && adduser -S nonroot -G nonroot -D
USER nonroot
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . /app/
EXPOSE 8081
ENTRYPOINT ["python", "/app/app.py"]

FROM cgr.dev/chainguard/python:latest-dev as base
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt --user


FROM cgr.dev/chainguard/python:latest
WORKDIR /app
COPY --from=base /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages
COPY . ./
EXPOSE 8081
ENTRYPOINT ["python", "/app/app.py"]

FROM cgr.dev/chainguard/python:latest-dev AS base
ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/app/venv/bin:$PATH"
WORKDIR /app
RUN python -m venv /app/venv
COPY requirements.txt .
RUN pip install --no-cache -r requirements.txt
RUN pip install --upgrade bottle


FROM cgr.dev/chainguard/python:latest
WORKDIR /app
ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"
COPY --from=base /app/venv /venv
COPY . ./
EXPOSE 8081
ENTRYPOINT ["python", "/app/app.py"]

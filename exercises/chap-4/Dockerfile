FROM python:3.13-alpine

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY server.py .
ENTRYPOINT ["fastapi", "dev", "--host", "0.0.0.0", "server.py"]


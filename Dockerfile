FROM python:3.11-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg fonts-liberation && rm -rf /var/lib/apt/lists/*
RUN useradd -m app
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY --chown=app . .
USER app
EXPOSE 8000
HEALTHCHECK CMD python -c "import urllib.request as u;u.urlopen('http://localhost:8000/api/health')"
CMD ["uvicorn","server:app","--host","0.0.0.0","--port","8000"]

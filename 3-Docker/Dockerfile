FROM python:3.13-slim

RUN mkdir /build
WORKDIR /build

COPY app /build

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
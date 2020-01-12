FROM python:3.7-alpine3.10

COPY requirements.txt /
COPY server.py /

RUN pip install -r requirements.txt

CMD python3 server.py

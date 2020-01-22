FROM python:3.7

LABEL maintainer="Relk Li <zxc140zxc140@gmail.com>"
WORKDIR /app
ENV FLASK_APP=autoapp.py
ENV FLASK_DEBUG=0
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 80
ENTRYPOINT ["flask"]
CMD ["flask run", "--with-threads"]

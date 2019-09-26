FROM ubuntu:18.04

RUN apt update
RUN apt install -y python3 python3-dev python3-pip
RUN apt install -y nginx uwsgi uwsgi-plugin-python3

# Setup/copy application and dependencies

RUN mkdir -p /var/app
WORKDIR /var/app

COPY requirements.txt .
RUN pip3 install -r requirements.txt

ENV FLASK_APP=project:app
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

COPY project project
# CMD ["flask", "run", "--host=0.0.0.0"]
# EXPOSE 5000


# Setup uwsgi

RUN mkdir -p /var/socket
RUN mkdir -p /run/uwsgi
RUN uwsgi -s /var/socket/app.sock --manage-script-name --mount /=project:app --plugin python3 &

# Setup nginx

RUN rm /etc/nginx/sites-enabled/default
COPY app-nginx.conf /etc/nginx/conf.d
CMD ["nginx", "-g", "daemon off;"]


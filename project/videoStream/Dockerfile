FROM ubuntu:latest

WORKDIR /app
COPY . /app 
RUN apt-get update && apt-get install -y x11-apps
RUN rm -rf /tmp/* /usr/share/doc/* /usr/share/info/* /var/tmp/*
RUN useradd -ms /bin/bash user
RUN apt-get -y install apt-utils
RUN apt-get -y install python-pip \
		&& rm -rf /var/lib/apt/lists/*
RUN pip install numpy
RUN pip install	opencv-python
EXPOSE 8888
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM=1 
USER root
#WORKDIR /videoStream
#ENTRYPOINT ["/bin/sh", "-c", "$0 \"$@\"", "xeyes"]
CMD ["python", "server.py", "-v videoplayback 192.168.1.117 60400"]

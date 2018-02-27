FROM ubuntu:latest
MAINTAINER steer629

#ENV DEBIAN_FRONTEND noninteractive


# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl\
    && apt-get install -y --no-install-recommends --allow-unauthenticated  apt-utils \
        lubuntu-desktop \
        x11vnc xvfb \
        tightvncserver lxterminal xrdp\
        sudo \ 
        spyder3 \
        fonts-wqy-microhei \
        python3-pip python3-dev build-essential \
        dbus-x11 x11-utils \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

#RUN touch ~/.bash_aliases
#RUN alias python=python3
#RUN source ~/.bash_aliases

WORKDIR /root
#ENV HOME=/home/ubuntu \
#    SHELL=/bin/bash \
ENV USER root
COPY password.txt .
RUN cat password.txt password.txt | vncpasswd && \
  rm password.txt
# Expose VNC port
EXPOSE 5901
#ENTRYPOINT ["/startup.sh"]

#RUN chmod 600 /root/.vnc/passwd
# Set XDRP to use TightVNC port
RUN sed -i '0,/port=-1/{s/port=-1/port=5901/}' /etc/xrdp/xrdp.ini
#CMD /usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && tail -f /root/.vnc/*:1.log

#EXPOSE 80
# Copy VNC script that handles restarts
COPY vnc.sh /opt/
COPY xstartup /root/.vnc/
RUN chmod 777 /opt/vnc.sh
CMD ["/opt/vnc.sh"]





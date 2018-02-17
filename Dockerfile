FROM ubuntu:17.10
MAINTAINER steer629

#ENV DEBIAN_FRONTEND noninteractive

#RUN sed -i 's#http://archive.ubuntu.com/#http://tw.archive.ubuntu.com/#' /etc/apt/sources.list

# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl\
    #&& sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list" \
    #&& curl -SL http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key | apt-key add - \
    #&& add-apt-repository ppa:fcwu-tw/ppa \
    #&& apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated  apt-utils \
        supervisor \
        openssh-server pwgen sudo vim \
        net-tools \
        lxde x11vnc xvfb \
        tightvncserver \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        firefox \
        spyder \
        fonts-wqy-microhei \
        #language-pack-zh-hant language-pack-gnome-zh-hant firefox-locale-zh-hant libreoffice-l10n-zh-tw \
        #nginx \
        python3-pip python3-dev build-essential \
        mesa-utils libgl1-mesa-dri \
        gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine pinta \
        #arc-theme \
        dbus-x11 x11-utils \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

#RUN touch ~/.bash_aliases
RUN alias python=python3
#RUN source ~/.bash_aliases

# tini for subreap                                   
#ENV TINI_VERSION v0.9.0
#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
#RUN chmod +x /bin/tini

#ADD image /
#RUN pip3 install setuptools wheel && pip3 install -r /usr/lib/web/requirements.txt
ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod 600 /root/.vnc/passwd

CMD /usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && tail -f /root/.vnc/*:1.log

EXPOSE 5901

#EXPOSE 80
#WORKDIR /root
#ENV HOME=/home/ubuntu \
#    SHELL=/bin/bash
#ENTRYPOINT ["/startup.sh"]

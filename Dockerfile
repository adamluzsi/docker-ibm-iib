FROM ubuntu:16.04

ARG VERSION
RUN test -n "$VERSION"

LABEL "ProductName"="IBM Integration Bus" "ProductVersion"=${VERSION}

# install system level dependencies
# bash to ensure bash scripts are running
# rsyslog required by IIB
# wget to fetch source in a single RUN command with cleanups
# libgtk2.0-dev is the IIB toolkit runtime dependency
RUN  apt-get update &&\
    apt-get install -y bash rsyslog wget libgtk2.0-dev libgtk2.0-0 libxtst6 gtk2-engines-pixbuf gtk2-engines-murrine &&\
    apt-get clean &&\
    touch /var/log/syslog &&\
    chown syslog:adm /var/log/syslog

# install IBM IIB
RUN mkdir -p /opt/ibm &&\
    wget -O /tmp/iib.tar.gz "http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/integration/${VERSION}-IIB-LINUX64-DEVELOPER.tar.gz" &&\
    tar --extract -zv --file /tmp/iib.tar.gz --directory /opt/ibm &&\
    rm /tmp/iib.tar.gz &&\
    mv /opt/ibm/iib-${VERSION} /opt/ibm/iib

# accept license
RUN /opt/ibm/iib/iib make registry global accept license silently

# Create user to run as
RUN useradd --create-home --home-dir /home/iibuser --groups mqbrkrs iibuser &&\
    echo "source \$HOME/.bashrc" >> /home/iibuser/.bash_profile &&\
    mkdir /home/iibuser/IBM &&\
    chown iibuser:iibuser /home/iibuser/IBM

COPY bashrc /home/iibuser/.bashrc
ENV BASH_ENV="/home/iibuser/.bashrc"

# Copy in script files
COPY entrypoint /usr/local/bin/
RUN chmod +rx /usr/local/bin/entrypoint

ENV VERSION=${VERSION}
ENV MQSI_MQTT_LOCAL_HOSTNAME=127.0.0.1
ENV NODE_NAME="IIBV10NODE"
ENV SERVER_NAME="default"
ENV IIB_BIN_PATH="/opt/ibm/iib/iib"

# Expose default admin port and http port
EXPOSE 22 4414 7800 8010

USER iibuser

ENTRYPOINT ["entrypoint"]

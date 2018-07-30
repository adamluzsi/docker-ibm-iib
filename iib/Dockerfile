FROM ubuntu:16.04

ARG PRODUCT_VERSION

LABEL "ProductName"="IBM Integration Bus" "ProductVersion"=${PRODUCT_VERSION}

# install system level dependencies
RUN  apt-get update &&\
    apt-get install -y bash rsyslog wget &&\
    apt-get clean

#COPY src/${PRODUCT_VERSION}-IIB-LINUX64-DEVELOPER.tar.gz /tmp/iib.tar.gz

# install IIB
RUN mkdir -p /opt/ibm &&\
    wget -O /tmp/iib.tar.gz "http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/integration/${PRODUCT_VERSION}-IIB-LINUX64-DEVELOPER.tar.gz" &&\
    tar --extract -zv --file /tmp/iib.tar.gz --directory /opt/ibm &&\
    rm /tmp/iib.tar.gz &&\
    mv /opt/ibm/iib-${PRODUCT_VERSION} /opt/ibm/iib

# accept license
RUN /opt/ibm/iib/iib make registry global accept license silently


# Create user to run as
RUN useradd \
    --create-home \
    --home-dir /home/iibuser \
    --groups mqbrkrs \
    iibuser

# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Copy in script files
COPY iib_manage.sh /usr/local/bin/
COPY iib-license-check.sh /usr/local/bin/
COPY setup_xauth.sh /usr/local/bin/
COPY iib_env.sh /etc/profile.d/
RUN chmod +rx /usr/local/bin/*.sh

ENV BASH_ENV="/etc/profile.d/iib_env.sh"
ENV PRODUCT_VERSION=${PRODUCT_VERSION}
ENV MQSI_MQTT_LOCAL_HOSTNAME=127.0.0.1

# Expose default admin port and http port
EXPOSE 22 4414 7800

USER iibuser

# Set entrypoint to run management script
ENTRYPOINT ["iib_manage.sh"]

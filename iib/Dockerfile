FROM ibm/base

ARG PRODUCT_VERSION

LABEL "ProductID"="447aefb5fd1342d5b893f3934dfded73" \
    "ProductName"="IBM Integration Bus" \
    "ProductVersion"=${PRODUCT_VERSION}

RUN echo "IBM IIB target version: ${PRODUCT_VERSION}"

# mk dir for iib
RUN mkdir /opt/ibm

ADD "http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/integration/${PRODUCT_VERSION}-IIB-LINUX64-DEVELOPER.tar.gz" /tmp/iib.tar.gz
RUN tar --extract --gunzip --file /tmp/iib.tar.gz --directory /opt/ibm
RUN rm /tmp/iib.tar.gz

# remove the version from the path to make life easy
RUN mv /opt/ibm/iib-${PRODUCT_VERSION} /opt/ibm/iib

# accept license
RUN /opt/ibm/iib/iib make registry global accept license silently

# Configure system
RUN echo "IIB_10:" > /etc/debian_chroot  && \
    touch /var/log/syslog && \
    chown syslog:adm /var/log/syslog

# Create user to run as
RUN useradd \
    --create-home \
    --home-dir /home/iibuser \
    --groups mqbrkrs,sudo \
    iibuser

# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Copy in script files
COPY iib_manage.sh /usr/local/bin/
COPY iib-license-check.sh /usr/local/bin/
COPY setup_xauth.sh /usr/local/bin/
COPY iib_env.sh /usr/local/bin/
RUN chmod +rx /usr/local/bin/*.sh

ENV BASH_ENV=/usr/local/bin/iib_env.sh
ENV PRODUCT_VERSION=${PRODUCT_VERSION}
ENV MQSI_MQTT_LOCAL_HOSTNAME=127.0.0.1

# Expose default admin port and http port
EXPOSE 22 4414 7800

USER iibuser

# Set entrypoint to run management script
ENTRYPOINT ["iib_manage.sh"]

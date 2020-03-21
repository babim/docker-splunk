FROM babim/debianbase:10

ENV SPLUNK_PRODUCT splunk
ENV SPLUNK_VERSION 7.0.3
ENV SPLUNK_BUILD fa31da744b51
ENV SPLUNK_FILENAME splunk-${SPLUNK_VERSION}-${SPLUNK_BUILD}-Linux-x86_64.tgz

ENV SPLUNK_HOME /opt/splunk
ENV SPLUNK_GROUP splunk
ENV SPLUNK_USER splunk
ENV SPLUNK_BACKUP_DEFAULT_ETC /var/opt/splunk
ARG DEBIAN_FRONTEND=noninteractive

# download option
RUN apt update && apt-get install curl -y && \
    curl -Ls https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh -o /option.sh && \
    chmod +x /option.sh

# install
RUN curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Splunk%20install/splunk_install.sh | bash

# Ports Splunk Web, Splunk Daemon, KVStore, Splunk Indexing Port, Network Input, HTTP Event Collector
EXPOSE 8000/tcp 8089/tcp 8191/tcp 9997/tcp 1514 8088/tcp

WORKDIR /opt/splunk

# Configurations folder, var folder for everything (indexes, logs, kvstore)
VOLUME [ "/opt/splunk/etc", "/opt/splunk/var" ]

ENTRYPOINT ["/start.sh"]
CMD ["start-service"]
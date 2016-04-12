# Kibana image
FROM ukhomeoffice/glibc:latest

# Kibana version
ARG FILEBEAT_VERSION=5.0.0-alpha1-x86_64
ENV FILEBEAT_VERSION ${FILEBEAT_VERSION}
ARG FILEBEAT_DOWNLOAD_URL=https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}.tar.gz
ENV FILEBEAT_DOWNLOAD_URL ${FILEBEAT_DOWNLOAD_URL}

# Install NodeJS and Kibana
RUN apk add --update curl
RUN curl -s ${FILEBEAT_DOWNLOAD_URL} | tar zx -C /tmp && \
    mv /tmp/filebeat-${FILEBEAT_VERSION}/filebeat /bin/filebeat
ADD config /etc/filebeat/
RUN apk del curl && \
    rm -rf /var/cache/apk/*

# Run Kibana in node.js
ENTRYPOINT ["filebeat", "-e", "-c", "/etc/filebeat/filebeat.yml"]


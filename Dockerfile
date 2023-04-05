FROM quay.io/strimzi/kafka:latest-kafka-3.4.0
USER root:root

COPY *.zip /tmp/

RUN cd /tmp/ && \
    unzip *zip && \
    mv taosdata-kafka-connect-tdengine*/ /opt/kafka/plugins/ && \
    cd / && \
    rm -rf tmp/*

RUN cd /tmp/ && \
    curl -O https://www.tdengine.com/assets-download/3.0/TDengine-client-3.0.2.6-Linux-arm64.tar.gz && \
    tar -xzvf TDengine-client-3.0.2.6-Linux-arm64.tar.gz && \
    cd TDengine-client-3.0.2.6 && \
    ./install_client.sh && \
    cd / && \
    rm -rf tmp/*

RUN echo "smlChildTableName tablename" >> /etc/taos/taos.cfg

USER 1001

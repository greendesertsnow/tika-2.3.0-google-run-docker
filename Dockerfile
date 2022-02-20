FROM apache/tika:2.3.0-full
ENV TIKA_SERVER_JAR tika-server-standard-2.3.0

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install curl \
    tesseract-ocr-all

RUN apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chown=root:root entrypoint.sh tika-config.xml /
RUN chmod +x /entrypoint.sh

HEALTHCHECK CMD curl -f http://0.0.0.0:9998/tika?hc=1 || exit 1
 

EXPOSE 9998
ENTRYPOINT [ "/bin/sh", "-c", "exec java -jar /${TIKA_SERVER_JAR}.jar -h 0.0.0.0 $0 $@ --config /tika-config.xml"]
FROM ubuntu:25.04

ARG BUILDPLATFORM
ARG TARGETPLATFORM

ARG HUGO_VERSION=0.139.3

ENV DOCUMENT_DIR=/hugo-project
ENV OUTPUT_DIR=/output

ENV HUGO_EXTENDED=/tmp/hugo_extended.deb

COPY [ "./asciidoctor.sh", "/" ]

RUN apt-get update && apt-get upgrade -y \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata ruby ruby-dev make build-essential apt-utils wget \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl openjdk-17-jre graphviz \
 && HUGO_PLATFORM=$(echo $TARGETPLATFORM | cut -d/ -f2) \
 && HUGO_URL=https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${HUGO_PLATFORM}.deb \
 && wget -O ${HUGO_EXTENDED} ${HUGO_URL} \
 && gem install --no-document asciidoctor \
                              asciidoctor-confluence \
                              asciidoctor-diagram \
                              asciidoctor-html5s \
                              coderay \
 && dpkg -i ${HUGO_EXTENDED} \
 && rm ${HUGO_EXTENDED} \
 && mv /usr/local/bin/asciidoctor /usr/local/bin/asciidoctor-real \
 && mv /asciidoctor.sh /usr/local/bin/asciidoctor \
 && chmod +x /usr/local/bin/asciidoctor \
 && mkdir ${DOCUMENT_DIR} \
 && apt-get purge -y ruby-dev make build-essential wget \
 && apt -y autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*

WORKDIR ${DOCUMENT_DIR}

VOLUME ${DOCUMENT_DIR} ${OUTPUT_DIR}

CMD [ "hugo", "server", "--disableFastRender", "--bind", "0.0.0.0" ]

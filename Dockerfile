FROM ubuntu:xenial

LABEL maintainer="FIBOS Docker Maintainers <verdana.cn@gmail.com>"

ENV FIBOS_VERSION 27
ENV DEBIAN_FRONTEND noninteractive

# if you download installer script by yourself
# COPY ./installer-linux-27.sh installer.sh

# or download from fibos.io
RUN curl -fSL https://fibos.io/installs/installer-linux-{$FIBOS_VERSION}.sh -o installer.sh

# if or not use apt mirrors
# RUN sed -i -e "s/\(security\|archive\).ubuntu/mirrors.aliyun/g" /etc/apt/sources.list

RUN apt-get update > /dev/null  \
    && apt-get install -y       \
        libgmp-dev              \
        libssl1.0.0             \
        sudo                    \
    && sh installer.sh          \
    && apt-get clean            \
    && apt-get autoclean        \
    && rm -f installer.sh

ENV DEBIAN_FRONTEND teletype

VOLUME /public

EXPOSE 8888 9876

CMD ["/usr/local/bin/fibos"]


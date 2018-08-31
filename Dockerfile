FROM ubuntu:xenial

LABEL maintainer="FIBOS Docker Maintainers <verdana.cn@gmail.com>"

ENV FIBOS_VERSION 27
ENV DEBIAN_FRONTEND noninteractive

# if you download installer script by yourself
# uncomment this line, and remove curl cmd
# COPY ./installer-linux-27.sh installer.sh

# if or not use apt mirrors
# RUN sed -i -e "s/\(security\|archive\).ubuntu/mirrors.aliyun/g" /etc/apt/sources.list

RUN apt-get update > /dev/null \
&& apt-get install -y curl libgmp-dev libssl1.0.0 sudo \
&& curl -fSL https://fibos.io/installs/installer-linux-{$FIBOS_VERSION}.sh -o installer.sh \
&& sh installer.sh \
&& rm -f installer.sh \
&& apt-get remove -y --auto-remove --purge curl \
&& apt-get clean \
&& apt-get autoclean

ENV DEBIAN_FRONTEND teletype

WORKDIR /public
VOLUME  /public

EXPOSE 8888 9876

CMD ["/usr/local/bin/fibos", "node.js"]


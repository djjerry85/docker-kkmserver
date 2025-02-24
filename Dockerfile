FROM ubuntu:20.04

ARG KKMSERVER_VERSION=2.3.12.18_04.02.2025
ARG KKMSERVER_STUFF=KkmServer_$KKMSERVER_VERSION.deb

ADD container/ /
ADD dist/$KKMSERVER_STUFF /

ENV DEBIAN_FRONTEND=noninteractive

#RUN dpkg --add-architecture armhf \
 #   && apt install libc6:armhf

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       ca-certificates \
       libc6-dev \
       libcurl4 \
       libgdiplus \
       libicu66 \
       liblttng-ust0 \
       libssl1.1 \
       netcat `# For health checks` \
       openssl

    #RUN dpkg --add-architecture amd64 \
    # &&  apt-get update

  RUN dpkg --install $KKMSERVER_STUFF

  RUN apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm --force $KKMSERVER_STUFF

ENV LANG=ru_RU.utf8

CMD ["/opt/kkmserver/kkmserver", "-s"]

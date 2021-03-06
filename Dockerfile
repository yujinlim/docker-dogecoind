FROM ubuntu:xenial
MAINTAINER Yu Jin

ARG workdir=/usr/local/dogecoin
ARG user_id=1000
ARG group_id=1000

ENV WORKDIR $workdir
ENV HOME /dogecoin

ENV USER $user_id
ENV GROUP $group_id

RUN groupadd -g $group_id dogecoin \
	&& useradd -u $user_id -g dogecoin -s /bin/bash -m -d $HOME dogecoin

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		wget

VOLUME ["/dogecoin"]

EXPOSE 22555 22556 44555 44556

WORKDIR ${HOME}

RUN mkdir -p $workdir
RUN cd $workdir && \
		wget -qO- https://github.com/dogecoin/dogecoin/releases/download/v1.10.0/dogecoin-1.10.0-linux64.tar.gz \
		| tar --strip-components=1 -xz \
		# && chown -R ${user_id} /usr/local/dogecoin/bin/* \
		&& ln -s /usr/local/dogecoin/bin/* /usr/local/bin/

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -x \
		&& dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
		&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
		&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
		&& export GNUPGHOME="$(mktemp -d)" \
		&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
		&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
		&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
		&& chmod +x /usr/local/bin/gosu \
		&& gosu nobody true

RUN apt-get purge -y --auto-remove \
		ca-certificates \
		wget \
		&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD scripts/dogecoind_start.sh /usr/local/bin
RUN chmod +x /usr/local/bin/dogecoind_start.sh

ADD scripts/setup /usr/local/bin
RUN chmod +x /usr/local/bin/setup

ENTRYPOINT ["dogecoind_start.sh"]

FROM ubuntu:xenial
MAINTAINER Yu Jin

ARG workdir=/usr/local/dogecoin
ARG user_id=1000
ARG group_id=1000

ENV WORKDIR $workdir
ENV HOME /dogecoin

RUN groupadd -g $group_id dogecoin \
	&& useradd -u $user_id -g dogecoin -s /bin/bash -m -d $HOME dogecoin

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/dogecoin"]

EXPOSE 22555 22556 44555 44556

WORKDIR $workdir

RUN wget -qO- https://github.com/dogecoin/dogecoin/releases/download/v1.10.0/dogecoin-1.10.0-linux64.tar.gz | tar --strip-components=1 -xz

RUN ln -s /usr/local/dogecoin/bin/* /usr/local/bin/

ADD scripts/dogecoind_start.sh /usr/local/bin
RUN chmod +x /usr/local/bin/dogecoind_start.sh && chown $user_id:$group_id /usr/local/bin/dogecoind_start.sh

USER $user_id

ENTRYPOINT ["dogecoind_start.sh"]

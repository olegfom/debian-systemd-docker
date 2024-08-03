FROM debian:bookworm
LABEL maintainer="olegfom"

ARG DEBIAN_FRONTEND=noninteractive

ENV pip_packages="Debian 12 systemd"

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       iproute2 \
       libffi-dev \
       libssl-dev \
       procps \
       sudo \
       systemd \
       systemd-sysv \
       wget \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Make sure systemd doesn't start agettys on tty[1-6].
RUN rm -f /lib/systemd/system/multi-user.target.wants/getty.target

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]

# VNC-based Ubuntu 20.04 LTS desktop (best-practice starter)
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=1000
ARG VNC_PASSWORD=changeme

LABEL org.opencontainers.image.title="vnc-ubuntu"
LABEL org.opencontainers.image.description="Ubuntu 20.04 LTS + XFCE + TigerVNC (development/test desktop in a container)"
LABEL org.opencontainers.image.license="MIT"

# Install minimal desktop, VNC server, supervisor and basic tools in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      xfce4 \
      xfce4-goodies \
      dbus \
      dbus-x11 \
      x11-xserver-utils \
      xauth \
      tigervnc-standalone-server \
      tigervnc-common \
      supervisor \
      sudo \
      curl \
      ca-certificates \
      iproute2 \
      netcat-openbsd \
      procps \
      git \
      python3-pip \
    && rm -rf /var/lib/apt/lists/* && \
    # Install python websockify (used by noVNC)
    pip3 install --no-cache-dir websockify && \
    # Install noVNC to /opt/noVNC
    git clone --depth 1 https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone --depth 1 https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify || true

# Create non-root user. Prefer passing real credentials at runtime (see README).
RUN groupadd -g ${USER_GID} ${USERNAME} || true && \
    useradd -m -s /bin/bash -u ${USER_UID} -g ${USER_GID} ${USERNAME} || true && \
    echo "${USERNAME}:${VNC_PASSWORD}" | chpasswd && \
    usermod -aG sudo ${USERNAME} && \
    mkdir -p /home/${USERNAME}/.vnc && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# Supervisor config and entrypoint
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 5901

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s CMD nc -z localhost 5901 || exit 1

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-n","-c","/etc/supervisor/conf.d/supervisord.conf"]

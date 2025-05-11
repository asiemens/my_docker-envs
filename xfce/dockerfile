FROM ubuntu:latest

# Update and install LXQt desktop environment and XRDP
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y lubuntu-desktop && \
    apt install -y xrdp && \
    adduser xrdp ssl-cert

# Install my build tools
RUN apt install -y build-essential git default-jdk maven build-essential python3 nodejs npm

# Install additional tools
#RUN apt install -y microsoft-edge-stable

# Install SSH server
RUN apt install -y openssh-server && \
    mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config


# Create a user and add to sudo group
RUN useradd -m me && \
    echo "me:2345" | chpasswd && \
    usermod -aG sudo me

# Expose ports for XRDP and SSH
EXPOSE 3389
EXPOSE 22

# Start services
CMD ["/bin/bash", "-c", "service xrdp start && service ssh start && /bin/bash"]
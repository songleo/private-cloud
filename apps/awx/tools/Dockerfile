FROM ubuntu

RUN apt update && apt install -y openssh-server
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd -m -s /bin/bash admin
RUN echo "admin:admin" | chpasswd

EXPOSE 22

ENTRYPOINT service ssh start && sleep 36000

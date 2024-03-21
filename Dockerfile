FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y openssh-server gnupg ca-certificates curl jq && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    # Java 21 from Azul Zulu
    curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" > /etc/apt/sources.list.d/zulu.list && \
    apt-get update && \
    apt-get install -y zulu21-jre-headless && \
    # gatling-user User \
    groupmod -g 1000 users && \
    useradd -u 911 -U -d /config -s /bin/bash gatling-user && \
    usermod -G users gatling-user && \
    mkdir -p /config && \
    # Gatling OS tuning \
    echo "*       soft    nofile  65535\n*       hard    nofile  65535" >> /etc/security/limits.conf && \
    echo "session required pam_limits.so" >> /etc/pam.d/sshd && \
    # Cleanup
    rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      $HOME/.cache

EXPOSE 22

COPY /root /

ENTRYPOINT ["/docker/docker-entrypoint"]
CMD ["/usr/sbin/sshd", "-D", "-e"]

FROM accetto/xubuntu-vnc-novnc:latest

USER root

# Install dependencies and add universe repository
RUN apt-get update && \
    apt-get install -y software-properties-common apt-transport-https gnupg2 curl && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y firefox-esr && \
    rm -rf /var/lib/apt/lists/*

USER vncuser

CMD ["/usr/bin/x11vnc", "-forever", "-display", ":1", "-nopw", "-shared"]

FROM accetto/xubuntu-vnc-novnc:latest

USER root

# Install Firefox
RUN apt-get update && \
    apt-get install -y firefox-esr && \
    rm -rf /var/lib/apt/lists/*

# Set user back to vncuser
USER vncuser

# Optional: Add a custom startup script if needed
# COPY startup.sh /home/vncuser/startup.sh
# RUN chmod +x /home/vncuser/startup.sh

CMD ["/usr/bin/x11vnc", "-forever", "-display", ":1", "-nopw", "-shared"]

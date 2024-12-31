# Dockerfile for running noVNC with Firefox
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    dbus-x11 \
    fontconfig \
    fonts-dejavu \
    git \
    xvfb \
    x11vnc \
    websockify \
    libxtst6 \
    firefox

# Install supervisor
    supervisor


# Download noVNC
RUN git clone https://github.com/novnc/noVNC.git /novnc

# Create supervisor configuration file
RUN mkdir -p /etc/supervisor/conf.d/
RUN echo "[supervisord]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "nodaemon=true" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "[program:x11vnc]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "command=/usr/bin/x11vnc -display :99 -rfbport 5900 -localhost" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "autostart=true" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "autorestart=true" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "[program:websockify]" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "command=websockify -v -v -v 6080 -- /usr/bin/x11vnc -display :99 -rfbport 5900 -localhost" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "autostart=true" >> /etc/supervisor/conf.d/supervisord.conf
RUN echo "autorestart=true" >> /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6080 5900
HEALTHCHECK --interval=30s --timeout=10s CMD /usr/bin/pgrep x11vnc || exit 1
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

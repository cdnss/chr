# Dockerfile for running noVNC with Firefox
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    dbus \
    fontconfig \
    fonts-dejavu \
    git \
    xvfb \
    x11vnc \
    websockify

# Install Firefox
RUN apt-get install -y firefox-esr

# Download noVNC
RUN git clone https://github.com/novnc/noVNC.git /novnc
CMD ["websockify", "-v", "-v", "-v", "6080", "--", "/usr/bin/x11vnc", "-display", ":99", "-rfbport", "5900"]

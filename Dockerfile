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


# Download noVNC
RUN git clone https://github.com/novnc/noVNC.git /novnc
CMD ["websockify", "-v", "-v", "-v", "6080", "--", "/usr/bin/x11vnc", "-display", ":99", "-rfbport", "5900"]

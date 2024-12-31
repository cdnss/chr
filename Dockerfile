# Dockerfile for running noVNC with Firefox
FROM alpine:latest

# Install necessary packages
RUN apk update && apk add --no-cache \
    xvfb \
    x11vnc \
    websockify \
    dbus \
    ttf-dejavu \
    fontconfig \
    git

# Install Firefox
RUN apk add --no-cache firefox-esr

# Download noVNC
RUN git clone https://github.com/novnc/noVNC.git /novnc

# Atur DISPLAY
ENV DISPLAY=:3

# Run Xvfb, x11vnc, and websockify with 800x800 resolution
CMD sh -c "Xvfb $DISPLAY -screen 0 800x800x24 & sleep 5 && \
        x11vnc -display $DISPLAY -forever -shared -nopw & \
        websockify -v --web=/novnc 6080 localhost:5900 & \
        firefox-esr & wait"

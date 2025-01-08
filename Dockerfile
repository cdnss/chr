# Use a lightweight base image
FROM dorowu/ubuntu-desktop-lxde-vnc

# Install x11vnc and firefox
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 78BD65473CB3BD13 && apt-get update && apt-get install -y --no-install-recommends x11vnc firefox && apt-get clean && rm -rf /var/lib/apt/lists/*
# Start x11vnc and firefox
CMD ["/bin/sh", "-c", "x11vnc -display :0 -forever -loop -shared -rfbport 5900 & websockify -D --web /usr/share/novnc/ 6080 localhost:5900"]

# Use Alpine Linux as the base image
FROM alpine:latest

# Install required packages
RUN apk update && apk add --no-cache \
    x11vnc \
    websockify \
    supervisor \
    wget \
    ttf-dejavu \
    fontconfig \
    libxtst
    
# Create supervisor config file directory
RUN mkdir -p /etc/supervisor.d
    
# Copy supervisor configuration file
COPY supervisord.conf /etc/supervisord.conf

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /usr/share/novnc

EXPOSE 6080 5900

# Health check
HEALTHCHECK --interval=30s --timeout=30s --retries=3 \
    CMD wget -O /dev/null http://localhost:6080 || exit 1

# Run supervisord
CMD ["supervisord", "-c", "/etc/supervisord.conf"]

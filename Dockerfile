FROM alpine:latest

# Instal dependensi
RUN apk update \
    && apk add --no-cache \
        xvfb \
        firefox \
        openjdk17-jdk \
        unzip \
        curl \
        tini \
        bash \
        ttf-freefont

# Set working directory
WORKDIR /opt

# Download Selenium Server (ganti versi jika diperlukan)
RUN curl -o selenium-server.jar https://repo1.maven.org/maven2/org/seleniumhq/selenium/selenium-server/4.11.0/selenium-server-4.11.0.jar

# Buat direktori untuk Firefox profile
RUN mkdir -p /home/firefox/.mozilla

# Copy tini untuk process management
COPY --from=tianon/tini:latest /tini /tini
ENTRYPOINT ["/tini", "--", "/bin/bash", "/start-selenium.sh"]

# Create a start script
COPY start-selenium.sh /start-selenium.sh
RUN chmod +x /start-selenium.sh


# Expose port
EXPOSE 4444

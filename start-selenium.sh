#!/bin/bash

# Start Xvfb
Xvfb :1 -screen 0 1024x768x24 &

# Set DISPLAY environment variable
export DISPLAY=:1

# Start Selenium Server
java -jar selenium-server.jar standalone

tail -f /dev/null

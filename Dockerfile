# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils && \
    apt-get install -y novnc websockify python3-numpy && \
    apt-get install -y supervisor x11vnc xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up noVNC
RUN mkdir -p /opt/novnc/utils/websockify && \
    ln -s /usr/share/novnc/vnc.html /opt/novnc/index.html

# Add configuration files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start-vnc.sh /usr/local/bin/start-vnc.sh

# Expose ports
EXPOSE 6080

# Start supervisord
CMD ["/usr/bin/supervisord"]
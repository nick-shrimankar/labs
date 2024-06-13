#!/bin/bash

# Start the X server
/usr/bin/Xvfb :99 -screen 0 1024x768x16 &

# Start the Xfce4 session
/usr/bin/startxfce4 &

# Start x11vnc server
x11vnc -display :99 -forever -nopw -listen localhost -xkb &

# Start websockify
websockify --web=/usr/share/novnc 6080 localhost:5900

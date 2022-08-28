#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"

WS_SETUP_FILE=/ros2_ws/install/setup.bash
if [ -f "$WS_SETUP_FILE" ]; then
    echo "Found install/setup.bash"
    source $WS_SETUP_FILE
fi

exec "$@"

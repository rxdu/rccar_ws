FROM ros:humble

# Set up user account
RUN useradd -ms /bin/bash ros && echo "ros:ros" | chpasswd && adduser ros sudo

# Install dependent packages
ENV DEBIAN_FRONTEND=noninteractive
RUN sudo apt-get update && \
        sudo apt-get -y install --no-install-recommends \
        python3-pip \
        libgl1-mesa-dev libglfw3-dev libcairo2-dev libtbb-dev libasio-dev \
        libboost-all-dev libgsl-dev libeigen3-dev libtbb-dev libopencv-dev libyaml-cpp-dev \
        jstest-gtk
RUN sudo apt-get install -y ros-humble-diagnostic-updater \
        ros-humble-ackermann-msgs \
        ros-humble-serial-driver \
        ros-humble-joy-linux

WORKDIR /ros2_ws
COPY src /ros2_ws
RUN bash -c "source /opt/ros/humble/setup.bash && colcon build"

# Clean up
RUN sudo apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
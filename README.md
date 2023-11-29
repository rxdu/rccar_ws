# VSCode ROS2 Workspace

[![ros](https://github.com/rxdu/ros2_ws/actions/workflows/rccar.yaml/badge.svg)](https://github.com/rxdu/ros2_ws/actions/workflows/rccar.yaml)

This repository sets up a ROS2 workspace with VSCode remote development support and it allows you to develop ROS2-based applications in containers conveniently.

## How to Setup

### Install Docker and Nvidia-Docker

* Follow [instructions to install docker](https://docs.docker.com/engine/install/ubuntu/)

* Add your user to docker group to use docker without sudo (you need to restart the computer)

```
$ sudo groupadd docker
$ sudo usermod -aG docker $USER
```

* Follow [instructions to install nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

```
$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
$ sudo apt-get update
$ sudo apt-get install -y nvidia-docker2
$ sudo systemctl restart docker
```

### Install VSCode plugin

* Remote Development (by Microsoft)

### Set up workspace

To create a new workspace:

```
$ sudo apt install python3-vcstools 
$ sudo apt purge python3.9*
$ sudo apt install libsuitesparse-dev libgraphicsmagick++1-dev libceres-dev xtl-dev
$ cd ros2_ws_vscode
$ vcs import src < ./ros2.repos --recursive
$ mkdir -p src/deps
$ vcs import src/deps < ./nav2.humble.deps.rosinstall
```

Generate navigation2 dependent packages

```
$ sudo apt install python3-rosinstall-generator
$ rosinstall_generator --deps --exclude RPP --rosdistro ${ROS_DISTRO} \
    `rosdep keys --ignore-src --rosdistro ${ROS_DISTRO} --from-paths src --skip-keys="libopencv-dev libopencv-contrib-dev libopencv-imgproc-dev python-opencv python3-opencv"` \
    > nav2.${ROS_DISTRO}.deps.rosinstall
```

To update the repos:

```
$ vcs pull src
```

### Use the workspace

Open VSCode from the "ros2_ws" folder, use "Ctrl + P" shortcut and type ">Remote-Containers: Rebuild Container" to build the docker image.

Default username and password of the image is: ros:ros

### Debugging

This template sets up debugging for python files and gdb for cpp programs.  See [`.vscode/launch.json`](.vscode/launch.json) for configuration details.

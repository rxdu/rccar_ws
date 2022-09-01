# VSCode ROS2 Workspace Template

This template will get you set up using ROS2 with VSCode as your IDE.

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
$ cd ros2_ws_vscode
$ vcs import src < ./ros2.repos --recursive
```

To update the repos:

```
$ vcs pull src
```

### Use the workspace

Open VSCode from the "ros2_ws_vscode" folder, use "Ctrl + P" shortcut and type ">Remote-Containers: Rebuild Container" to build the docker image.

Default username and password of the image is: ros:ros

## Features

### Style

ROS2-approved formatters are included in the IDE.  

* **c++** uncrustify; config from `ament_uncrustify`
* **python** autopep8; vscode settings consistent with the [style guide](https://index.ros.org/doc/ros2/Contributing/Code-Style-Language-Versions/)

### Tasks

There are many pre-defined tasks, see [`.vscode/tasks.json`](.vscode/tasks.json) for a complete listing.  Feel free to adjust them to suit your needs.  

Take a look at [how I develop using tasks](https://www.allisonthackston.com/articles/vscode_tasks.html) for an idea on how I use tasks in my development.

### Debugging

This template sets up debugging for python files and gdb for cpp programs.  See [`.vscode/launch.json`](.vscode/launch.json) for configuration details.

### Continuous Integration

The template also comes with basic continuous integration set up. See [`.github/workflows/ros.yaml`](/.github/workflows/ros.yaml).  

To remove a linter just delete it's name from this line:

```yaml
      matrix:
          linter: [cppcheck, cpplint, uncrustify, lint_cmake, xmllint, flake8, pep257]
```
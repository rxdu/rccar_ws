## Wait for "/dev/input/js0" in Systemd Service

Create a new udev rule: /etc/udev/rules.d/99-systemd.rules

```
ACTION=="add", SUBSYSTEM=="input", KERNEL=="js0", TAG+="systemd"
```

Reload the rules:

```
$ sudo udevadm control --reload-rules && udevadm trigger
```

Then in the service file you can let the service wait for "dev-input-js0.device"

```
Requires= dev-input-js0.device
After= dev-input-js0.device
```

**Reference**:

* https://unix.stackexchange.com/questions/186899/how-to-wait-for-a-dev-video0-before-starting-a-service

## DDS Shared Memory Issue Between Docker Containers

**Reference**:

* https://answers.ros.org/question/370595/ros2-foxy-nodes-cant-communicate-through-docker-container-border/
* https://answers.ros.org/question/296828/ros2-connectivity-across-docker-containers-via-host-driver/?answer=298320#post-id-298320
* 
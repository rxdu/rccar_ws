
/etc/udev/rules.d/99-systemd.rules

```
ACTION=="add", SUBSYSTEM=="input", KERNEL=="js0", TAG+="systemd"
```


```
$ sudo udevadm control --reload-rules && udevadm trigger
```

Reference:

* https://unix.stackexchange.com/questions/186899/how-to-wait-for-a-dev-video0-before-starting-a-service
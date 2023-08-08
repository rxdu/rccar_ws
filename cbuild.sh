#!/bin/bash

colcon build --event-handlers console_cohesion+ --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja
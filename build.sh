#!/bin/bash
set -e

# Set the default build type
BUILD_TYPE=RelWithDebInfo
source /opt/ros/humble/setup.bash
colcon build \
        --merge-install \
        --symlink-install \
        --cmake-args "-DCMAKE_BUILD_TYPE=$BUILD_TYPE" "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" \
        -Wall -Wextra -Wpedantic

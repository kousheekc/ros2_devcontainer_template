FROM ros:humble-perception-jammy

ARG USERNAME=USERNAME
ARG WORKSPACE=WORKSPACE
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/* \
    && adduser $USERNAME dialout

RUN apt-get update && apt-get upgrade -y

# [OPTIONAL] Install binary dependencies
# RUN apt-get update \
#     && apt-get install -y ros-humble-xacro \
#     ros-humble-joint-state-publisher \
#     ros-humble-joint-state-publisher-gui \
#     ignition-fortress \
#     ros-humble-ros-gz \
#     ros-humble-ros2-control \
#     ros-humble-ros2-controllers \
#     ros-humble-robot-localization \
#     ros-humble-navigation2 \
#     ros-humble-nav2-bringup
#     ros-humble-tf-transformations \
#     ros-humble-moveit \
#     ros-humble-ur \
#     && rm -rf /var/lib/apt/lists/*
    
# [OPTIONAL] Install Dynamixel dependencies 
# RUN apt-get update \
#     && apt-get install -y ros-humble-dynamixel-sdk \
#     ros-humble-dynamixel-workbench-toolbox

# Install additional tools
RUN apt-get update \
    && apt-get install -y wget \
    python3-pip \
    python3-rosdep \
    python3-colcon-common-extensions \
    git \
    vim \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

RUN usermod -a -G dialout ${USERNAME}
USER $USERNAME

# [OPTIONAL] Install required python packages
# RUN pip install transforms3d opencv-contrib-python

# Run rosdep update to update dependencies
RUN rosdep update

# Build prerequisites - using bash as shell from now on, so that we can easily source workspaces
ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"]

# Add source statements to .bashrc so that both ROS and the workspace are automatically sourced when a bash shell is started
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source ${WORKSPACE}/install/setup.bash" >> ~/.bashrc
CMD ["/bin/bash"]
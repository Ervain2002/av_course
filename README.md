# Autonomous Vehicle Practical Course (av_course)
**Tallinn University of Technology**

This repository contains my solutions and project files for the Autonomous Vehicle Practical Course. The project focuses on utilizing ROS 2 (Humble), Gazebo, and the Nav2 stack to simulate, map, and autonomously navigate a TurtleBot3 in a custom environment.

## 🛠️ Prerequisites & Environment Setup
* **OS:** Ubuntu 22.04 (via Docker container `ros_humble_student`)
* **ROS Version:** ROS 2 Humble Hawksbill
* **Simulator:** Gazebo Classic
* **Robot:** TurtleBot3 (Burger/Waffle)
* **Required ROS 2 Packages:** * `ros-humble-turtlebot3`, `ros-humble-turtlebot3-gazebo`
  * `ros-humble-cartographer`, `ros-humble-cartographer-ros`
  * `ros-humble-navigation2`, `ros-humble-nav2-bringup`
  * `ros-humble-tf-transformations`

## 🚀 Workspace Setup
1. Clone this repository to your local workspace:
   ```bash
   git clone [https://github.com/Ervain2002/av_course.git](https://github.com/Ervain2002/av_course.git)
   
# 🗺️ Task 1: Mapping Your Custom Environment

## Description

This task features a custom 15x15 meter simulation environment built in Gazebo and an autonomous mapping node using Cartographer SLAM to generate an accurate 2D map using a TurtleBot3.

## Workspace Contents

**my_robot_controller:** The primary package containing the custom logic.

- **launch/:** Contains `start_mapping.launch.py` which brings up Gazebo, the TurtleBot3, and the SLAM nodes.
- **worlds/:** Contains the custom `.world` file with various obstacles for the robot to navigate.
- **map/:** Contains the finalized generated map (`.pgm` and `.yaml` files).

## Step-by-Step Guide: How to Map

### 1. Launch the Simulation & SLAM

Open a terminal, source the workspace, and launch the custom Gazebo world alongside the Cartographer node:

```bash
ros2 launch my_robot_controller start_mapping.launch.py
```

### 2. Drive the Robot

Open a second terminal and run the teleop node to manually drive the TurtleBot3 around the environment to build the map:

```bash
ros2 run turtlebot3_teleop teleop_keyboard
```

### 3. Save the Map

Once the environment is fully explored in RViz, open a third terminal and save the map to the `map/` directory:

```bash
ros2 run nav2_map_server map_saver_cli -f ~/ws/src/my_robot_controller/map/my_map
```

---

# 🧭 Task 2: Autonomous Navigation

## Description

Enable the TurtleBot3 to navigate autonomously through the custom map created in Task 1. This task removes the need for manual teleoperation or manual goal-setting in RViz by using a custom Python mission script and a unified launch file.

## Components Built

**The Mission Script (`navigation.py`):** A custom Python node that automates the robot's journey. It waits for the Nav2 stack to initialize, publishes the robot's starting coordinates (`/initialpose`), and systematically sends 3 sequential target coordinates to the `/goal_pose` topic, tracking the distance via `/odom` to ensure each goal is reached.

**The Unified Launch File (`run_navigation.launch.py`):** A single launch file that integrates Gazebo, the Nav2 stack (pointed at the custom `my_map.yaml`), and the mission script.

## Step-by-Step Guide: How to Navigate

### 1. Configure the Environment

Ensure the robot model is set before launching:

```bash
export TURTLEBOT3_MODEL=burger
```

### 2. Launch the Autonomous System

Run the unified launch file. This will open Gazebo, RViz, and automatically start the mission script:

```bash
ros2 launch my_robot_controller run_navigation.launch.py
```

### 3. Observe the Mission

- The robot will automatically localize itself on the map.
- It will begin navigating to the three predefined goals.
- Watch the terminal output to see the `Goal X reached!` logs as it progresses through the environment.

---

# ⚠️ Known Challenges & Docker Fixes

Running ROS 2 Navigation inside a Docker container presented a few challenges during development:

- **Shared Memory Crashes (Exit Code -6):** FastDDS shared memory transport caused the Nav2 container to crash. This was fixed by creating a custom XML profile to disable shared memory and forcing UDP transport.

- **GUI Hardware Acceleration:** RViz occasionally crashed due to GPU pass-through issues. Using `export LIBGL_ALWAYS_SOFTWARE=1` forced software rendering and stabilized the application.

- **Localization Timing:** The mission script initially sent goals before Nav2 was fully active. A 15-20 second initialization delay was added to the Python script to ensure the lifecycle nodes were ready to receive goals.

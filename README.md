
# Autonomous Vehicle Practical Course (av_course)
**Tallinn University of Technology**

This repository contains my solutions and project files for the Autonomous Vehicle Practical Course. The project focuses on utilizing ROS 2 (Humble), Gazebo, and the Nav2 stack to simulate, map, and autonomously navigate a TurtleBot3 in a custom environment, as well as utilizing the Autoware stack for autonomous vehicle navigation.

## 🛠️ Prerequisites & Environment Setup
* **OS:** Ubuntu 22.04 (via Docker containers `ros_humble_student` and `mohsen_aw:full`)
* **ROS Version:** ROS 2 Humble Hawksbill
* **Simulator:** Gazebo Classic / Autoware Planning Simulator
* **Robot:** TurtleBot3 (Burger/Waffle) / Autoware sample_vehicle
* **Required ROS 2 Packages:** 
  * `ros-humble-turtlebot3`, `ros-humble-turtlebot3-gazebo`
  * `ros-humble-cartographer`, `ros-humble-cartographer-ros`
  * `ros-humble-navigation2`, `ros-humble-nav2-bringup`
  * `ros-humble-tf-transformations`
  * Standard Autoware stack

## 🚀 Workspace Setup
1. Clone this repository to your local workspace:
   ```bash
   git clone [https://github.com/Ervain2002/av_course.git](https://github.com/Ervain2002/av_course.git)
   ```
   
---

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

# 🚙 Task 3: Autonomous Navigation with Autoware Stack

## Description
Automate the navigation of an Ego vehicle through a simulated map using the Autoware autonomous stack and a custom ROS 2 node. 

This task integrates a custom controller (`my_robot_controller`) with Autoware's `planning_simulator` via a single launch file. The node is responsible for automatically publishing the vehicle's `/initialpose` and sequentially publishing three distinct goal destinations to the `/planning/mission_planning/goal` topic while monitoring the vehicle's `/localization/kinematic_state`.

## Prerequisites for this task
* Ensure you are running the `mohsen_aw:full` Docker container.
* Ensure the Autoware map directory (`/autoware_map/sample-map-planning`) is properly mounted.

## Step-by-Step Guide: How to Run

### 1. Setup and Build
If you haven't already built the workspace for this specific task, run the following inside the Docker container:
```bash
cd /ros2_ws
colcon build --packages-select my_robot_controller --symlink-install
source install/setup.bash
```

### 2. Execution
To launch the Autoware planning simulator and the custom navigation node simultaneously, run:

```bash
ros2 launch my_robot_controller car_nav.launch.py
```

### 3. Expected Behavior
- **Simulation Initialization**: RViz and the Autoware stack will load the `sample-map-planning` environment with the `sample_vehicle`.
- **Automated Start**: The custom node will immediately publish the starting coordinates to initialize the vehicle's position.
- **Sequential Navigation**: The vehicle will autonomously navigate to the first predefined goal. Upon reaching it, the node will detect the arrival and automatically publish the second goal, continuing until all three goals are reached.

---

# ⚠️ Known Challenges & Docker Fixes

Running ROS 2 Navigation and Autoware inside Docker containers presented a few challenges during development:

- **Permission Errors (EACCES):** When creating files within the root-level Docker container, editing them on the host machine failed. **Fix:** Used `chown -R 1000:1000 /ros2_ws` within the container to return file ownership to the host user.
- **Shared Memory Crashes (Exit Code -6):** FastDDS shared memory transport caused the Nav2 container to crash. **Fix:** Created a custom XML profile to disable shared memory and force UDP transport.
- **GUI Hardware Acceleration:** RViz occasionally crashed due to GPU pass-through issues. **Fix:** Using `export LIBGL_ALWAYS_SOFTWARE=1` forced software rendering and stabilized the application.
- **Localization Timing:** The mission script initially sent goals before Nav2 was fully active. **Fix:** A 15-20 second initialization delay was added to the Python script to ensure the lifecycle nodes were ready to receive goals.
```
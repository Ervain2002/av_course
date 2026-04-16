# Task 1: Mapping Your Custom Environment

**Autonomous Vehicle Practical Course - Tallinn University of Technology**

## Description
This repository contains the ROS 2 workspace for Task 1 of the Autonomous Vehicle Practical Course. It includes a custom $15 \times 15$ meter simulation environment built in Gazebo and an autonomous mapping node using Cartographer SLAM to generate an accurate 2D map using a TurtleBot3.

## Workspace Contents
* `my_robot_controller`: The primary package containing the custom mapping node.
* `launch/`: Contains `start_mapping.launch.py` which brings up Gazebo, the TurtleBot3, and the SLAM nodes.
* `worlds/`: Contains the custom `.world` file with various obstacles for the robot to navigate.
* `map/`: Contains the finalized generated map (`.pgm` and `.yaml` files).

## Prerequisites
* Ubuntu 22.04
* ROS 2 Humble
* Gazebo Simulator
* TurtleBot3 ROS 2 Packages (`ros-humble-turtlebot3`, `ros-humble-turtlebot3-gazebo`)
* Cartographer (`ros-humble-cartographer`, `ros-humble-cartographer-ros`)

## Setup and Installation
1. Clone this repository to your local machine:
   ```bash
   git clone [https://github.com/Ervain2002/av-course-task1-mapping.git](https://github.com/Ervain2002/av-course-task1-mapping.git)

from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        # Turtlesim Node
        Node(
            package='turtlesim',
            executable='turtlesim_node',
            name='sim'
        ),
        # close control
        Node(
            package='my_robot_controller',
            executable='control',
            name='control_robot'
        ),
    ])
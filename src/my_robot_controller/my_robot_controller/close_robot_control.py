#!/usr/bin/env python3

import rclpy
from rclpy.node import Node
from turtlesim.msg import Pose
from geometry_msgs.msg import Twist
import random 

class TurtleControllerNode(Node):
    def __init__(self):
        super().__init__("turtle_controller")
        self.get_logger().info("Controller has been started.")
        # Publisher for velocity commands
        self.cmd_vel_publisher = self.create_publisher(
            Twist, "/turtle1/cmd_vel", 10
        )
        # Subscriber for turtle's position
        self._pose_subscriber = self.create_subscription(
            Pose, "/turtle1/pose", self.pose_callback, 10
        )

    def pose_callback(self, pose: Pose):
        # Create a new Twist message
        cmd = Twist()

        # Logic to move the turtle
        if 2.0 < pose.x < 9.0 and 2.0 < pose.y < 9.0:
            # Safe range: Move forward
            cmd.linear.x = random.uniform(2.0, 5.0)
            cmd.angular.z = random.uniform(-1.0, 1.0)
        else:
            # Near the boundary: Slow down and turn
            self.get_logger().info("Wall detected! Executing emergency turn.")
            cmd.linear.x = 0.5 
            cmd.angular.z = random.uniform(1.5, 4.5)  # Sharp random rotation

        # Publish the command
        self.cmd_vel_publisher.publish(cmd)

def main(args=None):
    rclpy.init(args=args)
    node = TurtleControllerNode()
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == '__main__':
    main()
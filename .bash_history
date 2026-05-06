ros2 run demo_nodes_cpp talker
rviz
rviz2
exit
ros2 run demo_nodes_cpp listener
rqt_graph 
exit
ls
exit
rgt_graph
rqt_graph
stop
exit
docker- compose up
docker ps
help
clea
clear
docker-compose up
cd ~/ros2_ws/
ls
echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
source ~/.bashrc
exit
. build_ws.sh 
exit
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
exit
ros2 run nav2_map_server map_saver_cli -f ~/map
ls
ros2 run nav2_map_server map_saver_cli -f ~/src/my_robot_controller/map/map
ros2 run nav2_map_server map_saver_cli -f ~/ws/src/my_robot_controller/map/map
cd..
cd .
cd ..
ls
cp map.pgm map.yaml ws/src/my_robot_controller/map
exit
ros2 launch turtlebot3_bringup rviz2.launch.py
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
docker compose stop 
docker- compose stop
exit
build_ws.sh
. build_ws.sh
ros2 launch my_robot_controller 
stats
status
docker status
. build ws.sh
. build_ws.sh
ros2 launch my_robot_controller 
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
gazebo
clear
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
exit
. build_ws.sh
ros2 launch turtlebot3_navigation2 navigation2.launch.py use_sim_time:=True map:=$HOME/ws/src/my_robot_controller/map/map.yaml
ros2 launch my_robot_controller turtlebot3_world.launch.py 
docker compose stop
./build_ws.sh
ros2 launch turtlebot3_navigation2 navigation2.launch.py use_sim_time:=True map:=$HOME/ws/ros2_ws_/src/my_robot_controller/map/map.yaml
ros2 launch turtlebot3_navigation2 navigation2.launch.py use_sim_time:=True map:=$HOME/Documents/ros2_ws_/src/my_robot_controller/map/map.yaml
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py
./build_ws.sh
exit 
. build_ws.sh 
ros2 launch my_robot_controller turtlebot3_navigation.launch.py 
.build_ws.sh
. build_ws.sh 
ros2 launch my_robot_controller turtlebot3_navigation.launch.py 
. build_ws.sh 
gazebo
. build_ws.sh 
ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py 
docker compose stop
colcon build --symlink
colcon build --symlink-install
source ./bashrc
exit
docker run -it --rm --privileged --net=host   --env=DISPLAY   --env=QT_X11_NO_MITSHM=1   -v /tmp/.X11-unix:/tmp/.X11-unix   -v /home/autolab/Documents/ros2_ws:/ros2_ws   -v /home/autolab/autoware_map:/autoware_map   --workdir /ros2_ws   mohsen_aw:full bash
docker compose stop
docker exit
docker compose up
exit
docker ps
ros2 launch autoware_launch planning_simulator.launch.xml map_path:=/autoware_map/sample-map-planning vehicle_model:=sample_vehicle sensor_model:=sample_sensor_kit
exit

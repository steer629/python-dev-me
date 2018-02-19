# python-dev-me

docker run -d -p <port>:5901 steer629/python-dev-me
  
  The default password should be changed. To do so start up a container and then run docker exec <id> bash -c "echo -e '<password>\n<password>\nn' | vncpasswd".

For automatically mapping a VNC port use docker run -dP kaixhin/vnc and docker port <id> to retrieve the port. For specifying the port manually use docker run -d -p <port>:5901 kaixhin/vnc. The shell can be entered as usual using docker run -it kaixhin/vnc bash

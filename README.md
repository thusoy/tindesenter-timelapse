Tindesenter timelapse
=====================

A RPi is set up with gphoto2 and upstart, connected to a Camera module and a Nikon D200.

SSH keys have been generated to make it capable of establishing a SSH tunnel to tarjei's account on pengebingen.

The included files here are:

**ssh-tunnel.conf**: The job starting the SSH tunnel to pengebingen.
**capture-both.sh**: A script that takes a single picture from each of the cameras, and transfers them to pengebingen.
**picam.py**: Used to take a single picture with the RPi camera.


It's configured with a crontab like this:

	0 8-14/2 * * * cronic /home/pi/capture-both.sh

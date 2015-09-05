Tindesenter timelapse
=====================

A RPi is set up with gphoto2 connected to a Camera module and a Nikon D200, producing daily timelapses of construction of the tindesenter at Åndalsnes:

 - [Last week](https://ts.thusoy.com/tindesenteret-last-week.mp4)
 - [Last month](https://ts.thusoy.com/tindesenteret-last-month.mp4)
 - [All time](https://ts.thusoy.com/tindesenteret-ext.mp4)

Images are dumped to a fileserver immediately after capture over SSH. The fileserver generates the timelapses.

The included files here are:

**ssh-tunnel.conf**: The job starting the SSH tunnel to the fileserver.  
**capture-both.sh**: A script that takes a single picture from each of the cameras, and transfers them to the fileserver.  


It's configured with a crontab like this:

	55 8-14/2 * * * cronic /home/pi/capture-both.sh
	55 7-13/2 * * * cronic /home/pi/capture-both.sh $(date +"%s")-ext
	25 7-14 * * * cronic /home/pi/capture-both.sh $(date +"%s")-ext
	
	# Regularly transfer images from crashed jobs
	30 16 * * * cronic sh -c 'find /var/imgs/ -type f -name "*.jpg" -print | while read file; do scp -pq "$file" pengebingen:tarjei/Foto/Timelapse/Tindesenteret/RAW/ && rm "$file" || (>&2 echo "$file failed to transfer"; exit 1); done'
	
The two latter entries increases the total number of pictures taken to 16 each day, but given IDs that are easily filtered out from the originals.

**NB**: Remember to set the camera to PTP mode to be able to control it from `gphoto2`.
**NB2**: Also remember to set the pi's timezone using `sudo dpkg-reconfigure tzdata`, to have times in the crontab be executed when you think they'll be.

#!/bin/sh

# Fail script if any command fails
set -e

fileid=$(date +"%s")

/usr/local/bin/gphoto2 --capture-image-and-download --filename "/tmp/nikon-$fileid.jpg" 2>&1
python picam.py "/tmp/picam-$fileid.jpg"
scp /tmp/nikon-$fileid.jpg /tmp/picam-$fileid.jpg pengebingen:~/tarjei/Foto/Timelapse/Tindesenteret/RAW
rm /tmp/*-$fileid.jpg

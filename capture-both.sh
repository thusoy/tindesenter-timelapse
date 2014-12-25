#!/bin/sh

# Fail script if any command fails
set -e

# Where to store the images locally (without trailing slash)
target_dir="/var/imgs"

fileid=$(date +"%s")

# Capture the images
/usr/local/bin/gphoto2 --capture-image-and-download --filename "$target_dir/nikon-$fileid.jpg" 2>&1
raspistill -q 100 -n -t 1 -awb cloud -o "$target_dir/picam-$fileid.jpg"

# Crop away some cruft
echo "Cropping nikon..."
convert $target_dir/nikon-$fileid.jpg -crop +480+250 -crop -335+0 -quality 100 $target_dir/nikon-cropped-$fileid.jpg
echo "Cropping picam..."
convert $target_dir/picam-$fileid.jpg -crop +85+0 -crop -90+0 -quality 100 $target_dir/picam-cropped-$fileid.jpg

# Push images to storage
echo "Uploading images..."
scp $target_dir/*-$fileid.jpg pengebingen:~/tarjei/Foto/Timelapse/Tindesenteret/RAW

# If everything has succeeded so far, remove the local copies
echo "Deleting local copies..."
rm $target_dir/*-$fileid.jpg

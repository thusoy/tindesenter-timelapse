import picamera
import sys

def take_single_picture(target):
    with picamera.PiCamera() as camera:
        camera.resolution = (2592, 1944)
        camera.capture(target)


target_file = sys.argv[1]
take_single_picture(target_file)

#!/bin/bash
STOP_COMMAND="sudo docker stop pythonvideostream"
SAFE_COMMAND="sudo python $PWD/server_backup.py -v $PWD/videoplayback $IP 60400"

cd ~/videoStream
File=console.log

FIND_PID="$(sudo lsof -t -i:60400)"


echo "$(sudo kill -9 $FIND_PID)"
echo Container process has been killed
echo running the backup server in host

exec $SAFE_COMMAND 

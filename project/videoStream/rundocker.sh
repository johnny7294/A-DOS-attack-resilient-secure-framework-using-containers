#!/bin/bash
cat /dev/null > /home/johnny7294/videoStream/console.log
echo Enter the IP address of host 
read IP
export IP
DRY_RUN=false
TITILE='My_video_server_container'
IMAGE='pythonvideostream'

MYCONFDIR=""

# An array of envvars
# Ex. ENVVARS=("SITENAME=my.site.name}" "RUBY_VERSION=2.3.0" "CONTAINER=true")
ENVVARS=(DISPLAY=$DISPLAY)

# Array of ports like (80:80 443:443 3000 8080)
# Can be mapped or unmapped
PORTS=(60400:60400)

# Array of volumes like ("${MYCONFDIR}:/conf")
VOLUMES=(/tmp/.X11-unix:/tmp/.X11-unix)
ENTRYPOINT=""
CMD="python server.py -v videoplayback $IP 60400"
RESTART=""
DAEMON=false

# The Docker command to use.
# Could be different if including --tlsverify -H "hostname:hostport", etc
DOCKERCMD="docker"
SITENAME=${TITLE}
NAME=${IMAGE}

declare -a ENVVAR_STRING
for envvar in ${ENVVARS[@]} ; do
  ENVVAR_STRING+=("-e ${envvar}")
done

declare -a PORT_STRING
for port in ${PORTS[@]} ; do
  PORT_STRING+=("-p ${port}")
done

declare -a VOLUME_STRING
for volume in ${VOLUMES[@]} ; do
  VOLUME_STRING+=("-v ${volume}")
done

if [[ ! -z $NAME ]] ; then
  NAME_STRING="--name ${NAME}"
fi

if [[ ! -z $RESTART ]] ; then
  RESTART_STRING="--restart ${RESTART}"
fi

if [[ ! -z $ENTRYPOINT ]] ; then
  ENTRYPOINT_STRING="--entrypoint ${ENTRYPOINT}"
fi

if [[ ! -z $CMD ]] ; then
  CMD_STRING="${CMD}"
fi

if $DAEMON ; then
  DAEMON_STRING='-d'
else
  DAEMON_STRING=''
fi

if $DOCKERCMD ps -a | awk "/${NAME}/ {print $NF}" | grep $NAME &>/dev/null ; then
  $DOCKERCMD stop $NAME 1>/dev/null \
  && $DOCKERCMD rm $NAME 1>/dev/null
fi

OPTS="${ENVVAR_STRING[@]} ${PORT_STRING[@]} ${VOLUME_STRING[@]} $NAME_STRING $RESTART_STRING $ENTRYPOINT_STRING"
#WORKDIR="$HOME/johnny7294/videoStream"

echo $PWD
THE_COMMAND="$DOCKERCMD run --net=host --cpus=1 --ipc=host --memory=100m  --memory-swap=100m $OPTS $DAEMON_STRING $IMAGE $CMD_STRING"
STOP_COMMAND="docker stop pythonvideostream"
SAFE_COMMAND="python $PWD/server.py -v $PWD/videoplayback $IP 60400" 
echo "$THE_COMMAND"

while (exec $THE_COMMAND | grep -c 1 "DOS attack"); do 
		sleep 1
	 done
echo DOS attack detected switching to backup
sh ./runservice.sh 
exec $STOP_COMMAND


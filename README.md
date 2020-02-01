# A-DOS-attack-resilient-secure-framework-using-containers
A DOS attack resilient secure framework using containers

This repository contains a video streaming server client framework. The server will send the live straming of videoplayback.
The functioning of framework is tested by simulating the attacks from LOIC (Low Orbit Ion Cannon) tool. LOIC is a 
DoS attack tool that generates and sends large number of requests to a targeted system. LOIC can be used to generate 
either TCP or UDP traffic. For the experiment, I have used this tool to send UDP requests to the video streaming server.

The proposed system stops the container process as soon as the decision module detects the DoS attack. Backup server is run on
host to serve the legitimate users after the container is stopped. The real-time connection between the
server and client is restored within 2 seconds of detecting the DoS attack.

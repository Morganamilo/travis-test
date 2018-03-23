#!/usr/bin/sh

STATUS="`curl -s -o /dev/null -w "%{http_code}" "http://127.0.0.1:8080/rpc/?v=5&type=info&arg[]=zebedee"`"

if [ $STATUS != "200" ]; then
	echo "Failed to connect to AUR rpc"
	false
fi


TYPE=${TYPE:KIND}

if [ "${TYPE}" = "KIND" ];then
    export NODE=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kind-worker)
    export PORT=80
else
    export NODE=127.0.0.1
fi

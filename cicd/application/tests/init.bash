TYPE=${TYPE:KIND}

if [ "${TYPE}" = "KIND" ];then
    export NODE=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kind-worker)
else
    export NODE=$(kubectl get nodes minikube -o jsonpath='{.status.addresses[0].address}')
fi

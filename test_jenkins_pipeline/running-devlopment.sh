running=`kubectl get pods -n devlopment|grep Running|awk '{print $3}'`> /dev/null 2>&1
if [ "$running" == "Running" ]; then
   echo "continue"
else
  kubectl delete -f k8s-dev.yaml > /dev/null 2>&1
  if [ "$?" != 0 ]; then
    echo "continue"
  fi
fi

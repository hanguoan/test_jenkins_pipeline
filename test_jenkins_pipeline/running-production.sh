running=`kubectl get pods -n production|grep Running|awk '{print $3}'`> /dev/null 2>&1
if [ "$running" == "Running" ]; then
   echo "continue"
else
  kubectl delete -f k8s-prod.yaml > /dev/null 2>&1
  if [ "$?" != 0 ]; then
    echo "continue"
  fi
fi

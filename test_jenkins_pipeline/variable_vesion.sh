kubectl rollout history deploy -n production |awk '{print $1}' |grep -v deploy|grep -v REVISION
 > rollout

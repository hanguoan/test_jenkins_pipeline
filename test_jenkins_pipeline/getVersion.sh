kubectl rollout history deploy/jenkins-demo -n production | grep -v "deployment" | grep -v "REVISION" | awk '{print $1}' > version.csv

#!/bin/sh
#生成部署k8s的 yaml 模板文件
echo "生成部署k8s的 yaml 模板文件"

cat > app_rollback_${2}.yaml <<EOF

apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  namespace: production
  name: $project_name
  labels:
    app: $project_name
spec:
  replicas: $podNum
  selector:
    matchLabels:
      app: $project_name
  strategy:
    rollingUpdate:  ##由于replicas为3,则整个升级,pod个数在2-4个之间
      maxSurge: 1      #滚动升级时会先启动1个pod
      maxUnavailable: 1 #滚动升级时允许的最大Unavailable的pod个数
  template:
    metadata:
      labels:
        app: $project_name
    spec:
      containers:
      - name: $project_name
        #发布时拉取最新版本的镜像
        image: hga2017/jenkins_demo:<BUILD_TAG>
        imagePullPolicy: IfNotPresent

---
apiVersion: v1
kind: Service
metadata:
  namespace: production
  name: ${project_name}
  labels:
    app: ${project_name}
spec:
  ports:
  - port: 18888
    targetPort: 18888
    nodePort: 31890
    protocol: TCP
  type: NodePort
  selector:
    app: ${project_name}
    
EOF



echo "生成部署k8s的 yaml 模板  完毕"
echo "==================================================================="
echo "  "

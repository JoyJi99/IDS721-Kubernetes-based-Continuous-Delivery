# Kubernetes based Continuous Delivery

This repo is the source code for IDS721-Project2-Kubernetes based Continuous Delivery.

## Target
- Create a customized Docker container from the current version of Python that deploys a simple python script.
- Push image to DockerHub, or Cloud based Container Registery (ECR)
- Project should deploy automatically to Kubernetes cluster
- Deployment should be to some form of Kubernetes service (can be hosted like Google Cloud Run or Amazon EKS, etc)

## Finished
- A simple flask web app has been completed.
- Dockerize application using Docker and push image to DockerHub
- Pull it onto AWS Cloud 9
- Extend and push to Amazon ECR
- Run via kubectl
- Pull into Amazon EKS

## Pre-requisites
- Kubectl —  https://kubernetes.io/docs/tasks/tools/install-kubectl/
- AWS CLI -  https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
- Aws iam authenticator — https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
- eksctl — https://github.com/weaveworks/eksctl

## docker build
docker build -t webapp .

## Run docker image
docker images --filter reference=webapp

## Run the newly built image. The -p 80:80 option maps the exposed port 80 on the container to port 80 on the host system.
docker run -t -i -p 8000:8000 webapp

## If you are running Docker locally, point your browser to http://localhost/.


## Authenticate to your default registry
## New system new - Access Key and Secrete for AWS CLI login

## Create you ecr repo
aws ecr create-repository --repository-name webapp --region us-east-1
	
## Authenticate your docker to ecr == > gives encrypted password for docker
aws ecr get-login-password --region us-east-1

## Final Authenticate to ecr
aws ecr --region us-east-1 | docker login -u AWS -p <Above encrytped password> <ACCOUNTID>.dkr.ecr.us-east-1.amazonaws.com/webapp

## docker tag
docker tag webapp:latest <ACCOUNTID>.dkr.ecr.us-east-1.amazonaws.com/webapp:latest

## docker push
docker push <ACCOUNTID>.dkr.ecr.us-east-1.amazonaws.com/webapp:latest

## Create VPC for EKS using stackset -- AWS CLI
aws cloudformation deploy --template-file amazon-eks-vpc-private-subnets.yaml --stack-name my-new-stack

## Create our cluster on EKS
eksctl create cluster -f cluster.yaml --kubeconfig=/User/joy/.kube/config

## Create our deployment
kubectl apply -f deployment.yaml

## Create service
kubectl apply -f service.yaml

## service created
kubectl get services

##  pods of our application are running.
kubectl get pods -o wide

## get nodes command
kubectl get nodes -o wide


## How To Run
1. Install `virtualenv`:
```
$ pip3 install virtualenv
```

2. Open a terminal in the project root directory and run:
```
$ virtualenv env
```

3. Then run the command (for Mac):
```
$ source env/bin/activate
```

4. Then install the dependencies:
```
$ (env) pip3 install -r requirements.txt
```

5. Finally start the web server:
```
$ (env) python3 app.py
```

This server will start on port 5000 by default. You can change this in `app.py` by changing the following line to this:

```python
if __name__ == "__main__":
    app.run(debug=True, port=<desired port>)
```

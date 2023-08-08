# Deployment 

you can skip terrafrom and ansible by using deploy.sh 

## 1. terraform 
 
in terraform directory run the command

```
terraform init
terraform apply
```


## 2. ansible

from the terrafrom output take the jenkins ec2 public ip then replace the value "ansible_host" with it

copy tf-key-pair.pem key file from terraform directory to ansible directory

then run the command

```
ansible-playbook playbook.yaml -i inventory
```


## 3. jenkins


from ansible output follow link to jenkins web page then enter admin password

install suggeted plugin then create user and log in

![](screenshot/create_user.PNG)

add plugin "aws steps"

![](screenshot/plugins.PNG)

add aws credentials in username and password format with ID "aws_cren"

add github credentials with username:"AhmedKhamis9780" and password: "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"

![](screenshot/credentials.PNG)

create pipeline to pull code from this repository from "main" branch and path to jenkins file is "jenkins/Jenkinsfile"


build pipeline

![](screenshot/build.PNG)


## 4. kubectl

from your local machine with aws cli and kubectl installed

```
aws eks update-kubeconfig --region us-east-1 --name sprint
# to update KUBECONFIG file 
```
then check cluster status

```
kubectl get all
kubectl get ingress
```

![](screenshot/kube.PNG)


## 5. access application

by DNS load balanscer in privous command

```
kubectl get ingress
```
![](screenshot/app.PNG)

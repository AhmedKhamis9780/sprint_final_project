#!/bin/bash
sudo usermod -aG docker jenkins
aws ecr get-login-password --region us-east-1 |docker login --username AWS --password-stdin 699819973233.dkr.ecr.us-east-1.amazonaws.com/sprint
aws eks update-kubeconfig --region us-east-1 --name sprint
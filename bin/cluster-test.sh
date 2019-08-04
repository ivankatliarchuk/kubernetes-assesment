#!/bin/bash

{
  kubectl create deployment nginx --image=nginx
  kubectl create service clusterip nginx --tcp=80:80
  kubectl get svc
  kubectl get pods
  kubectl delete deploy nginx
}

{
  kubectl crete ns test
  kubectl get ns
  kubectl delete ns test
}

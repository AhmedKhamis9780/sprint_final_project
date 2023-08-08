aws eks update-kubeconfig --region us-east-1 --name sprint
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade -i ingress-nginx ingress-nginx/ingress-nginx --version 4.2.3 --namespace kube-system --set controller.service.type=LoadBalancer

kubectl -n kube-system rollout status deployment ingress-nginx-controller
# Kubernetes Dashboard

```bash
cd raspberry-automation/k3s/kubernetes-dashboard

kubectl apply -k .

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml

# Get the token with:
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/kd-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
```

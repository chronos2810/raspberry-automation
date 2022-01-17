
# Secret required

```bash
 kubectl create secret generic -n samba samba-secret --from-literal=username='foo' --from-literal=password='bar'

 cd raspberry-automation/k3s/samba

 k apply -k . 
```

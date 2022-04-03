# Provision kubernetes as k3s cluster in Hetzner using kube-hetzner terraform module

*Source: https://github.com/kube-hetzner/terraform-hcloud-kube-hetzner*

## Setup servers

Please create the local config file with variables:

*env.auto.tfvars*

```terraform
hcloud_token = "<secret-token>"
traefik_acme_email = "<some@email>"
```

## Setup cluster

Deploy k3s cluster:

```shell
terraform apply
```

Override config for kubectl:

```shell
mv kubeconfig.yaml ~/.kube/config
```

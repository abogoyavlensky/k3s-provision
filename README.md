# Provision kubernetes as k3s cluster in Hetzner using kube-hetzner terraform module

*Source: https://github.com/kube-hetzner/terraform-hcloud-kube-hetzner*

## Setup servers

Please create the local config file with actual variables by copying `env.auto.tfvars.example`:

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


## Setup mc (Minio cli) access to Yandex.Cloud Storage Objects (S3)

*Link: https://docs.min.io/docs/minio-client-complete-guide.html*

```shell
mc alias set yc https://storage.yandexcloud.net <access_key> <secret_key>
```


### Backup current tfstate to s3 by hand

*TODO: update using terraform tfstate backend!*

```shell
mc cp terraform.tfstate yc/k3s-terraform/terraform.tfstate
```

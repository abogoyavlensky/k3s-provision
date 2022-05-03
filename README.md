# Provision kubernetes as k3s cluster in Hetzner using kube-hetzner terraform module

*Terraform module source: https://github.com/kube-hetzner/terraform-hcloud-kube-hetzner*

Tools:
- tf provider [hcloud]();
- tf module [kube-hetzner](https://registry.terraform.io/modules/kube-hetzner/kube-hetzner/hcloud/latest);
- kubenretes distribution [k3s](https://github.com/k3s-io/k3s).

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
cp kubeconfig.yaml ~/.kube/config
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

## Run example nginx service

```shell
kubectl apply -f example/nginx.yaml
```

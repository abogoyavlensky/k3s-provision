# Provision kubernetes as k3s cluster in Hetzner using kube-hetzner terraform module

*Terraform module source: https://github.com/kube-hetzner/terraform-hcloud-kube-hetzner*

Tools:
- [terraform](https://www.terraform.io/);
- tf provider [hcloud](https://github.com/hetznercloud/terraform-provider-hcloud);
- tf module [kube-hetzner](https://github.com/kube-hetzner/terraform-hcloud-kube-hetzner);
- kubenretes distribution [k3s](https://github.com/k3s-io/k3s).

## Setup cluster

First of all you need account on Hetzner Cloud with active [project space](https://docs.hetzner.com/cloud/general/faq/#what-are-projects-and-how-can-i-use-them)
and [API token](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token).
Please create the local config file with actual variables by copying `env.auto.tfvars.example`:

*env.auto.tfvars*

```terraform
hcloud_token = "<secret-token>"
traefik_acme_email = "<some@email>"
```

Deploy k3s cluster:

```shell
terraform init
terraform apply
```

Override config for kubectl:

```shell
cp kubeconfig.yaml ~/.kube/config
```


## Run example nginx service

```shell
kubectl apply -f deploy/middlewares.yaml
kubectl apply -f examples/nginx.yaml
```


## Connect to S3 [OPTIONAL]

### Setup mc (Minio cli) access to S3 service of choice

*Link: https://docs.min.io/docs/minio-client-complete-guide.html*

*In this case I use Yandex Cloud Object Storage.*

```shell
mc alias set yc https://storage.yandexcloud.net <access_key> <secret_key>
```


### Backup current tfstate to s3 by hand

*TODO: update using terraform tfstate backend!*

```shell
mc cp terraform.tfstate yc/k3s-terraform/terraform.tfstate
```

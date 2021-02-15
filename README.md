# docker-kubectl

[![github-actions](https://github.com/theohbrothers/docker-kubectl/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-kubectl/actions)
[![docker-image-size](https://img.shields.io/microbadger/image-size/theohbrothers/docker-kubectl/latest)](https://hub.docker.com/r/theohbrothers/docker-kubectl)
[![docker-image-layers](https://img.shields.io/microbadger/layers/theohbrothers/docker-kubectl/latest)](https://hub.docker.com/r/theohbrothers/docker-kubectl)

Dockerized `kubectl` alpine image with useful tools.

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:v1.20.2-alpine-3.8`, `:latest` | [View](variants/v1.20.2-alpine-3.8 ) |
| `:v1.20.2-envsubst-alpine-3.8` | [View](variants/v1.20.2-envsubst-alpine-3.8 ) |
| `:v1.20.2-git-alpine-3.8` | [View](variants/v1.20.2-git-alpine-3.8 ) |
| `:v1.20.2-jq-alpine-3.8` | [View](variants/v1.20.2-jq-alpine-3.8 ) |
| `:v1.20.2-kustomize-alpine-3.8` | [View](variants/v1.20.2-kustomize-alpine-3.8 ) |
| `:v1.20.2-ssh-alpine-3.8` | [View](variants/v1.20.2-ssh-alpine-3.8 ) |
| `:v1.20.2-envsubst-git-jq-kustomize-ssh-alpine-3.8` | [View](variants/v1.20.2-envsubst-git-jq-kustomize-ssh-alpine-3.8 ) |
| `:v1.19.7-alpine-3.8` | [View](variants/v1.19.7-alpine-3.8 ) |
| `:v1.19.7-envsubst-alpine-3.8` | [View](variants/v1.19.7-envsubst-alpine-3.8 ) |
| `:v1.19.7-git-alpine-3.8` | [View](variants/v1.19.7-git-alpine-3.8 ) |
| `:v1.19.7-jq-alpine-3.8` | [View](variants/v1.19.7-jq-alpine-3.8 ) |
| `:v1.19.7-kustomize-alpine-3.8` | [View](variants/v1.19.7-kustomize-alpine-3.8 ) |
| `:v1.19.7-ssh-alpine-3.8` | [View](variants/v1.19.7-ssh-alpine-3.8 ) |
| `:v1.19.7-envsubst-git-jq-kustomize-ssh-alpine-3.8` | [View](variants/v1.19.7-envsubst-git-jq-kustomize-ssh-alpine-3.8 ) |
| `:v1.18.15-alpine-3.8` | [View](variants/v1.18.15-alpine-3.8 ) |
| `:v1.18.15-envsubst-alpine-3.8` | [View](variants/v1.18.15-envsubst-alpine-3.8 ) |
| `:v1.18.15-git-alpine-3.8` | [View](variants/v1.18.15-git-alpine-3.8 ) |
| `:v1.18.15-jq-alpine-3.8` | [View](variants/v1.18.15-jq-alpine-3.8 ) |
| `:v1.18.15-kustomize-alpine-3.8` | [View](variants/v1.18.15-kustomize-alpine-3.8 ) |
| `:v1.18.15-ssh-alpine-3.8` | [View](variants/v1.18.15-ssh-alpine-3.8 ) |
| `:v1.18.15-envsubst-git-jq-kustomize-ssh-alpine-3.8` | [View](variants/v1.18.15-envsubst-git-jq-kustomize-ssh-alpine-3.8 ) |
| `:v1.17.17-alpine-3.8` | [View](variants/v1.17.17-alpine-3.8 ) |
| `:v1.17.17-envsubst-alpine-3.8` | [View](variants/v1.17.17-envsubst-alpine-3.8 ) |
| `:v1.17.17-git-alpine-3.8` | [View](variants/v1.17.17-git-alpine-3.8 ) |
| `:v1.17.17-jq-alpine-3.8` | [View](variants/v1.17.17-jq-alpine-3.8 ) |
| `:v1.17.17-kustomize-alpine-3.8` | [View](variants/v1.17.17-kustomize-alpine-3.8 ) |
| `:v1.17.17-ssh-alpine-3.8` | [View](variants/v1.17.17-ssh-alpine-3.8 ) |
| `:v1.17.17-envsubst-git-jq-kustomize-ssh-alpine-3.8` | [View](variants/v1.17.17-envsubst-git-jq-kustomize-ssh-alpine-3.8 ) |
| `:v1.16.15-alpine-3.8` | [View](variants/v1.16.15-alpine-3.8 ) |
| `:v1.16.15-envsubst-alpine-3.8` | [View](variants/v1.16.15-envsubst-alpine-3.8 ) |
| `:v1.16.15-git-alpine-3.8` | [View](variants/v1.16.15-git-alpine-3.8 ) |
| `:v1.16.15-jq-alpine-3.8` | [View](variants/v1.16.15-jq-alpine-3.8 ) |
| `:v1.16.15-kustomize-alpine-3.8` | [View](variants/v1.16.15-kustomize-alpine-3.8 ) |
| `:v1.16.15-ssh-alpine-3.8` | [View](variants/v1.16.15-ssh-alpine-3.8 ) |
| `:v1.16.15-envsubst-git-jq-kustomize-ssh-alpine-3.8` | [View](variants/v1.16.15-envsubst-git-jq-kustomize-ssh-alpine-3.8 ) |
| `:v1.15.12-alpine-3.8` | [View](variants/v1.15.12-alpine-3.8 ) |
| `:v1.15.12-envsubst-alpine-3.8` | [View](variants/v1.15.12-envsubst-alpine-3.8 ) |
| `:v1.15.12-git-alpine-3.8` | [View](variants/v1.15.12-git-alpine-3.8 ) |
| `:v1.15.12-jq-alpine-3.8` | [View](variants/v1.15.12-jq-alpine-3.8 ) |
| `:v1.15.12-kustomize-alpine-3.8` | [View](variants/v1.15.12-kustomize-alpine-3.8 ) |
| `:v1.15.12-ssh-alpine-3.8` | [View](variants/v1.15.12-ssh-alpine-3.8 ) |
| `:v1.15.12-envsubst-git-jq-kustomize-ssh-alpine-3.8` | [View](variants/v1.15.12-envsubst-git-jq-kustomize-ssh-alpine-3.8 ) |
| `:v1.14.10-alpine-3.8` | [View](variants/v1.14.10-alpine-3.8 ) |
| `:v1.14.10-envsubst-alpine-3.8` | [View](variants/v1.14.10-envsubst-alpine-3.8 ) |
| `:v1.14.10-git-alpine-3.8` | [View](variants/v1.14.10-git-alpine-3.8 ) |
| `:v1.14.10-jq-alpine-3.8` | [View](variants/v1.14.10-jq-alpine-3.8 ) |
| `:v1.14.10-kustomize-alpine-3.8` | [View](variants/v1.14.10-kustomize-alpine-3.8 ) |
| `:v1.14.10-ssh-alpine-3.8` | [View](variants/v1.14.10-ssh-alpine-3.8 ) |
| `:v1.14.10-envsubst-git-jq-kustomize-ssh-alpine-3.8` | [View](variants/v1.14.10-envsubst-git-jq-kustomize-ssh-alpine-3.8 ) |


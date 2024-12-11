# docker-kubectl

[![github-actions](https://github.com/theohbrothers/docker-kubectl/actions/workflows/ci-master-pr.yml/badge.svg?branch=master)](https://github.com/theohbrothers/docker-kubectl/actions/workflows/ci-master-pr.yml)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-kubectl?style=flat-square)](https://github.com/theohbrothers/docker-kubectl/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-kubectl/latest)](https://hub.docker.com/r/theohbrothers/docker-kubectl)

Dockerized `kubectl` with useful tools.

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:1.31.4`, `:latest` | [View](variants/1.31.4) |
| `:1.31.4-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.31.4-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.30.8` | [View](variants/1.30.8) |
| `:1.30.8-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.30.8-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.29.11` | [View](variants/1.29.11) |
| `:1.29.11-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.29.11-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.28.15` | [View](variants/1.28.15) |
| `:1.28.15-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.28.15-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.27.16` | [View](variants/1.27.16) |
| `:1.27.16-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.27.16-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.26.15` | [View](variants/1.26.15) |
| `:1.26.15-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.26.15-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.25.16` | [View](variants/1.25.16) |
| `:1.25.16-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.25.16-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.24.17` | [View](variants/1.24.17) |
| `:1.24.17-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.24.17-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.23.17` | [View](variants/1.23.17) |
| `:1.23.17-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.23.17-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.22.17` | [View](variants/1.22.17) |
| `:1.22.17-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.22.17-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.21.14` | [View](variants/1.21.14) |
| `:1.21.14-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.21.14-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.20.15` | [View](variants/1.20.15) |
| `:1.20.15-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.20.15-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.19.16` | [View](variants/1.19.16) |
| `:1.19.16-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.19.16-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.18.20` | [View](variants/1.18.20) |
| `:1.18.20-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.18.20-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.17.17` | [View](variants/1.17.17) |
| `:1.17.17-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.17.17-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.16.15` | [View](variants/1.16.15) |
| `:1.16.15-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.16.15-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.15.12` | [View](variants/1.15.12) |
| `:1.15.12-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.15.12-envsubst-git-jq-kustomize-sops-ssh-yq) |
| `:1.14.10` | [View](variants/1.14.10) |
| `:1.14.10-envsubst-git-jq-kustomize-sops-ssh-yq` | [View](variants/1.14.10-envsubst-git-jq-kustomize-sops-ssh-yq) |

All variants are based on `alpine`.

## Development

Requires Windows `powershell` or [`pwsh`](https://github.com/PowerShell/PowerShell).

```powershell
# Install Generate-DockerImageVariants module: https://github.com/theohbrothers/Generate-DockerImageVariants
Install-Module -Name Generate-DockerImageVariants -Repository PSGallery -Scope CurrentUser -Force -Verbose

# Edit ./generate templates

# Generate the variants
Generate-DockerImageVariants .
```

### Variant versions

[versions.json](generate/definitions/versions.json) contains a list of [Semver](https://semver.org/) versions, one per line.

To update versions in `versions.json`:

```powershell
./Update-Versions.ps1
```

To update versions in `versions.json`, and open a PR for each changed version, and merge successful PRs one after another (to prevent merge conflicts), and finally create a tagged release and close milestone:

```powershell
$env:GITHUB_TOKEN = 'xxx'
./Update-Versions.ps1 -PR -AutoMergeQueue -AutoRelease
```

To perform a dry run, use `-WhatIf`.

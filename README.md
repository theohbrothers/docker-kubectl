# docker-kubectl

[![github-actions](https://github.com/theohbrothers/docker-kubectl/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-kubectl/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-kubectl?style=flat-square)](https://github.com/theohbrothers/docker-kubectl/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-kubectl/latest)](https://hub.docker.com/r/theohbrothers/docker-kubectl)

Dockerized `kubectl` with useful tools.

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:1.28.2-alpine-3.15`, `:latest` | [View](variants/1.28.2-alpine-3.15) |
| `:1.28.2-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.28.2-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.27.6-alpine-3.15` | [View](variants/1.27.6-alpine-3.15) |
| `:1.27.6-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.27.6-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.26.9-alpine-3.15` | [View](variants/1.26.9-alpine-3.15) |
| `:1.26.9-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.26.9-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.25.14-alpine-3.15` | [View](variants/1.25.14-alpine-3.15) |
| `:1.25.14-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.25.14-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.24.17-alpine-3.15` | [View](variants/1.24.17-alpine-3.15) |
| `:1.24.17-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.24.17-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.23.17-alpine-3.15` | [View](variants/1.23.17-alpine-3.15) |
| `:1.23.17-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.23.17-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.22.17-alpine-3.15` | [View](variants/1.22.17-alpine-3.15) |
| `:1.22.17-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.22.17-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.21.14-alpine-3.15` | [View](variants/1.21.14-alpine-3.15) |
| `:1.21.14-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.21.14-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.20.15-alpine-3.15` | [View](variants/1.20.15-alpine-3.15) |
| `:1.20.15-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.20.15-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.19.16-alpine-3.15` | [View](variants/1.19.16-alpine-3.15) |
| `:1.19.16-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.19.16-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.18.20-alpine-3.15` | [View](variants/1.18.20-alpine-3.15) |
| `:1.18.20-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.18.20-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.17.17-alpine-3.15` | [View](variants/1.17.17-alpine-3.15) |
| `:1.17.17-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.17.17-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.16.15-alpine-3.15` | [View](variants/1.16.15-alpine-3.15) |
| `:1.16.15-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.16.15-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.15.12-alpine-3.15` | [View](variants/1.15.12-alpine-3.15) |
| `:1.15.12-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.15.12-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |
| `:1.14.10-alpine-3.15` | [View](variants/1.14.10-alpine-3.15) |
| `:1.14.10-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15` | [View](variants/1.14.10-envsubst-git-jq-kustomize-sops-ssh-alpine-3.15) |

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

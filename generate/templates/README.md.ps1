@"
# docker-kubectl

[![github-actions](https://github.com/theohbrothers/docker-kubectl/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/docker-kubectl/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-kubectl?style=flat-square)](https://github.com/theohbrothers/docker-kubectl/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-kubectl/latest)](https://hub.docker.com/r/theohbrothers/docker-kubectl)

Dockerized ``kubectl`` with useful tools.

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
$(
($VARIANTS | % {
    if ( $_['tag_as_latest'] ) {
@"
| ``:$( $_['tag'] )``, ``:latest`` | [View](variants/$( $_['tag'] ) ) |

"@
    }else {
@"
| ``:$( $_['tag'] )`` | [View](variants/$( $_['tag'] ) ) |

"@
    }
}) -join ''
)

"@

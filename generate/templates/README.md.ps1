@"
# docker-kubectl

[![github-actions](https://github.com/theohbrothers/docker-kubectl/workflows/build/badge.svg)](https://github.com/theohbrothers/docker-kubectl/actions)
[![docker-image-size](https://img.shields.io/microbadger/image-size/theohbrothers/docker-kubectl/latest)](https://hub.docker.com/r/theohbrothers/docker-kubectl)
[![docker-image-layers](https://img.shields.io/microbadger/layers/theohbrothers/docker-kubectl/latest)](https://hub.docker.com/r/theohbrothers/docker-kubectl)

Dockerized ``kubectl`` alpine image with useful tools.

| Tags |
|:-------:| $( $VARIANTS | % {
"`n| ``:$( $_['tag'] )`` |"
})

"@

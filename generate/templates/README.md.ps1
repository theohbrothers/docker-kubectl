@"
# docker-kubectl

[![gitlab-ci](https://img.shields.io/gitlab/pipeline/leojonathanoh/docker-kubectl/dev)](https://gitlab.com/leojonathanoh/docker-kubectl/commits/dev)
[![docker-image-size](https://img.shields.io/microbadger/image-size/leojonathanoh/docker-kubectl/latest)](https://hub.docker.com/r/leojonathanoh/docker-kubectl)
[![docker-image-layers](https://img.shields.io/microbadger/layers/leojonathanoh/docker-kubectl/latest)](https://hub.docker.com/r/leojonathanoh/docker-kubectl)

Dockerized ``kubectl`` alpine image with some optional tools

| Tags |
|:-------:| $( $VARIANTS | % {
"`n| ``:$( $_['tag'] )`` |"
})

"@

@"
# docker-kubectl

[![pipeline status](https://gitlab.com/leojonathanoh/docker-kubectl/badges/dev/pipeline.svg)](https://gitlab.com/leojonathanoh/docker-kubectl/commits/dev)

Dockerized ``kubectl`` alpine image with some optional tools

| Tags |
|:-------:| $( $VARIANTS | % {
"`n| ``:$( $_['tag'] )`` |"
})

"@

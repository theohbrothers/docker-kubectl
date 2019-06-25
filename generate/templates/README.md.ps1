@"
# docker-alpine

[![pipeline status](https://gitlab.com/leojonathanoh/docker-alpine/badges/dev/pipeline.svg)](https://gitlab.com/leojonathanoh/docker-alpine/commits/dev)

| Tags |
|:-------:| $( $VARIANTS | % {
"`n| ``:$( $_['tag'] )`` |"
})

"@
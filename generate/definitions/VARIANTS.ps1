$local:VARIANTS_PACKAGE_VERSIONS = @(
    'v1.14.10'
    'v1.15.12'
    'v1.16.15'
    'v1.17.13'
    'v1.18.10'
    'v1.19.3'
)
# Docker image variants' definitions
$local:VARIANTS_MATRIX = @(
    foreach ($v in $local:VARIANTS_PACKAGE_VERSIONS) {
        @{
            package_version = $v
            distro = 'alpine'
            distro_version = '3.8'
            subvariants = @(
                @{ components = @(); tag_as_latest = if ($v -eq $local:VARIANTS_PACKAGE_VERSIONS[$local:VARIANTS_PACKAGE_VERSIONS.Count - 1]) { $true } else { $false } }
                @{ components = @( 'envsubst' ) }
                @{ components = @( 'git' ) }
                @{ components = @( 'jq' ) }
                @{ components = @( 'kustomize' ) }
                @{ components = @( 'ssh' ) }
                @{ components = @( 'envsubst', 'git', 'jq', 'kustomize', 'ssh' ) }
            )
        }
    }
)
$VARIANTS = @(
    foreach ($variant in $VARIANTS_MATRIX){
        foreach ($subVariant in $variant['subvariants']) {
            @{
                # Metadata object
                _metadata = @{
                    package_version = $variant['package_version']
                    distro = $variant['distro']
                    distro_version = $variant['distro_version']
                    components = $subVariant['components']
                }
                # Docker image tag. E.g. 'v2.3.0.0-alpine-3.6'
                tag = @(
                        $variant['package_version']
                        $subVariant['components'] | ? { $_ }
                        $variant['distro']
                        $variant['distro_version']
                ) -join '-'
                tag_as_latest = if ( $subVariant.Contains('tag_as_latest') ) {
                                    $subVariant['tag_as_latest']
                                } else {
                                    $false
                                }
            }
        }
    }
)

# Docker image variants' definitions (shared)
$VARIANTS_SHARED = @{
    buildContextFiles = @{
        templates = @{
            'Dockerfile' = @{
                common = $true
                includeHeader = $true
                includeFooter = $true
                passes = @(
                    @{
                        variables = @{}
                    }
                )
            }
        }
    }
}

# Send definitions down the pipeline
$VARIANTS

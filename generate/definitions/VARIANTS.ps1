$local:VARIANTS_PACKAGE_VERSIONS = @(
    'v1.25.1'
    'v1.24.5'
    'v1.23.11'
    'v1.22.14'
    'v1.21.14'
    'v1.20.15'
    'v1.19.16'
    'v1.18.20'
    'v1.17.17'
    'v1.16.15'
    'v1.15.12'
    'v1.14.10'
)
# Docker image variants' definitions
$local:VARIANTS_MATRIX = @(
    foreach ($v in $local:VARIANTS_PACKAGE_VERSIONS) {
        @{
            package_version = $v
            distro = 'alpine'
            distro_version = '3.8'
            subvariants = @(
                @{ components = @(); tag_as_latest = if ($v -eq ($local:VARIANTS_PACKAGE_VERSIONS | ? { $_ -match '^v\d+\.\d+\.\d+$' } | Select-Object -First 1 )) { $true } else { $false } }
                @{ components = @( 'envsubst', 'git', 'jq', 'kustomize', 'sops', 'ssh' ) }
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
                    platforms =  'linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/s390x'
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
                includeHeader = $false
                includeFooter = $false
                passes = @(
                    @{
                        variables = @{}
                    }
                )
            }
            'docker-entrypoint.sh' = @{
                common = $true
                passes = @(
                    @{
                        variables = @{}
                    }
                )
            }
        }
    }
}

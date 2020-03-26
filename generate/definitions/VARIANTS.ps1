# Docker image variants' definitions
$local:VARIANTS_MATRIX = @(
    @{
        package_version = 'v1.14.10'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'envsubst' ) }
            @{ components = @( 'git' ) }
            @{ components = @( 'jq' ) }
            @{ components = @( 'kustomize' ) }
            @{ components = @( 'ssh' ) }
            @{ components = @( 'envsubst', 'git', 'jq', 'kustomize', 'ssh' ) }
        )
    }
    @{
        package_version = 'v1.15.11'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'envsubst' ) }
            @{ components = @( 'git' ) }
            @{ components = @( 'jq' ) }
            @{ components = @( 'kustomize' ) }
            @{ components = @( 'ssh' ) }
            @{ components = @( 'envsubst', 'git', 'jq', 'kustomize', 'ssh' ) }
        )
    }
    @{
        package_version = 'v1.16.8'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'envsubst' ) }
            @{ components = @( 'git' ) }
            @{ components = @( 'jq' ) }
            @{ components = @( 'kustomize' ) }
            @{ components = @( 'ssh' ) }
            @{ components = @( 'envsubst', 'git', 'jq', 'kustomize', 'ssh' ) }
        )
    }
    @{
        package_version = 'v1.17.4'
        distro = 'alpine'
        distro_version = '3.8'
        subvariants = @(
            @{ components = @() }
            @{ components = @( 'envsubst' ) }
            @{ components = @( 'git' ) }
            @{ components = @( 'jq' ) }
            @{ components = @( 'kustomize' ) }
            @{ components = @( 'ssh' ) }
            @{ components = @( 'envsubst', 'git', 'jq', 'kustomize', 'ssh' ) }
        )
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

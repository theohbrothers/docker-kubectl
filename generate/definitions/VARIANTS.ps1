# Docker image variants' definitions
$VARIANTS_VERSION = "v1.14.3"
$VARIANTS = @(
    @{
        tag = 'envsubst'
        distro = 'alpine'
    }
    @{
        tag = 'git'
        distro = 'alpine'
    }
    @{
        tag = 'ssh'
        distro = 'alpine'
    }
    @{
        tag = 'envsubst-git'
        distro = 'alpine'
    }
    @{
        tag = 'envsubst-git-ssh'
        distro = 'alpine'
    }
    @{
        tag = 'envsubst-ssh'
        distro = 'alpine'
    }
)

# Docker image variants' definitions (shared)
$VARIANTS_SHARED = @{
    version = $VARIANTS_VERSION
    buildContextFiles = @{
        templates = @{
            'Dockerfile' = @{
                common = $false
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

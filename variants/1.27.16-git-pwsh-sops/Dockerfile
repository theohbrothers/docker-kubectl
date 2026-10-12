FROM mcr.microsoft.com/powershell:lts-7.4-alpine-3.20
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# When $TARGETPLATFORM is linux/arm/v7, strip out the '/v6' or '/v7' from it
RUN set -eux; \
    BIN_URL=https://dl.k8s.io/release/v1.27.16/bin/$( echo $TARGETPLATFORM | sed 's@/v[67]$@@' )/kubectl; \
    SHA512=$( wget -qO- "$BIN_URL.sha512" ); \
    wget -qO- "$BIN_URL"  > /usr/local/bin/kubectl; \
    chmod +x /usr/local/bin/kubectl; \
    sha512sum /usr/local/bin/kubectl | grep "^$SHA512 "; \
    kubectl version --client

RUN apk add --no-cache git

# Disable telemetry for powershell 7.0.0 and above and .NET core: https://github.com/PowerShell/PowerShell/issues/16234#issuecomment-942139350
ENV POWERSHELL_CLI_TELEMETRY_OPTOUT=1
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV POWERSHELL_UPDATECHECK=Off
ENV POWERSHELL_UPDATECHECK_OPTOUT=1
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_TELEMETRY_OPTOUT=1
ENV COMPlus_EnableDiagnostics=0

# Install powershell modules
RUN set -eux; \
    pwsh -c 'Install-Module Pester -Scope AllUsers -MinimumVersion 4.10.1 -MaximumVersion 4.10.1 -Force -ErrorAction Stop -Verbose'; \
    pwsh -c 'Install-Module powershell-yaml -Scope AllUsers -MinimumVersion 0.4.12 -MaximumVersion 0.4.12 -Force -ErrorAction Stop -Verbose'; \
    pwsh -c 'Install-Module posh-SSH -Scope AllUsers -MinimumVersion 3.2.7 -MaximumVersion 3.2.7 -Force -ErrorAction Stop -Verbose';

RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "kubectl" ]

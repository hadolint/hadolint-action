FROM ghcr.io/hadolint/hadolint:v2.10.0-debian

# Set default WORKDIR in Dockerfile for easier trace and consistency
WORKDIR /github/workspace

COPY LICENSE README.md problem-matcher.json /
COPY hadolint.sh /usr/local/bin/hadolint.sh

ENTRYPOINT [ "/usr/local/bin/hadolint.sh" ]

FROM ghcr.io/hadolint/hadolint:v2.15.1-debian@sha256:9a3944b7fddcb947d1ffd90829ac1a6e5c30479223358f249d8b96c7d0019e27

COPY LICENSE README.md problem-matcher.json /
COPY hadolint.sh /usr/local/bin/hadolint.sh

ENTRYPOINT [ "/usr/local/bin/hadolint.sh" ]

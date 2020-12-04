FROM hadolint/hadolint:v1.17.5-alpine

COPY LICENSE README.md /
COPY hadolint.sh /usr/local/bin/hadolint.sh

ENTRYPOINT [ "/usr/local/bin/hadolint.sh" ]

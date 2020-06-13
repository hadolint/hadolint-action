FROM hadolint/hadolint:v1.18.0-alpine

COPY LICENSE README.md /

ENTRYPOINT [ "hadolint" ]


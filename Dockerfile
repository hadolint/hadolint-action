FROM hadolint/hadolint:v1.17.5-alpine

COPY LICENSE README.md /

ENTRYPOINT [ "hadolint" ]


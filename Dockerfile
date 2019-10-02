FROM hadolint/hadolint:v1.17.2

COPY LICENSE README.md /

CMD ["hadolint"]

#!/bin/sh

# The problem-matcher definition must be present in the repository
# checkout (outside the Docker container running hadolint). We create
# a temporary folder and copy problem-matcher.json to it and make it
# readable.
TMP_FOLDER=$(mktemp -d -p .)
cp /problem-matcher.json "${TMP_FOLDER}"
chmod -R a+rX "${TMP_FOLDER}"
trap "rm -rf \"${TMP_FOLDER}\"" EXIT

echo "::add-matcher::${TMP_FOLDER}/problem-matcher.json"

hadolint "$@"

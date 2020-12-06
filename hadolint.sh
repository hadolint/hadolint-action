#!/bin/sh

# The problem-matcher definition must be present in the repository
# checkout (outside the Docker container running hadolint). We create
# a temporary folder and copy problem-matcher.json to it and make it
# readable.
TMP_FOLDER=$(mktemp -d -p .)
cp /problem-matcher.json "${TMP_FOLDER}"
chmod -R a+rX "${TMP_FOLDER}"

# After the run has finished we remove the problem-matcher.json from
# the repository so we don't leave the checkout dirty. We also remove
# the matcher so it won't take effect in later steps.
cleanup() {
    echo "::remove-matcher owner=brpaz/hadolint-action::"
    rm -rf "${TMP_FOLDER}"
}
trap cleanup EXIT

echo "::add-matcher::${TMP_FOLDER}/problem-matcher.json"

hadolint "$@"

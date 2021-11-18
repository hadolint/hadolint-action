#!/bin/bash

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

if [ -n "$HADOLINT_CONFIG" ]; then
  HADOLINT_CONFIG="-c ${HADOLINT_CONFIG}"
fi

OUTPUT=
if [ -n "$HADOLINT_OUTPUT" ]; then
  if [ -f "$HADOLINT_OUTPUT" ]; then
    HADOLINT_OUTPUT="$TMP_FOLDER/$HADOLINT_OUTPUT"
  fi
  OUTPUT=" | tee $HADOLINT_OUTPUT"
fi

if [ "$HADOLINT_RECURSIVE" = "true" ]; then
  shopt -s globstar

  filename="${!#}"
  flags="${@:1:$#-1}"

  hadolint $HADOLINT_CONFIG $flags **/$filename $OUTPUT
else
  # shellcheck disable=SC2086
  hadolint $HADOLINT_CONFIG "$@" $OUTPUT
fi

[ -z "$HADOLINT_OUTPUT" ] || echo "Hadolint output saved to: $HADOLINT_OUTPUT"

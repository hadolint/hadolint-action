#!/bin/bash
# The problem-matcher definition must be present in the repository
# checkout (outside the Docker container running hadolint). We copy
# problem-matcher.json to the home folder.

PROBLEM_MATCHER_FILE="/problem-matcher.json"
if [ -f "$PROBLEM_MATCHER_FILE" ]; then
  cp "$PROBLEM_MATCHER_FILE" "$HOME/"
fi

# After the run has finished, we remove the problem-matcher.json from
# the repository so we don't leave the checkout dirty. We also remove
# the matcher so it won't take effect in later steps.
cleanup() {
  echo "::remove-matcher owner=brpaz/hadolint-action::"
}
trap cleanup EXIT

echo "::add-matcher::$HOME/problem-matcher.json"

if [ -n "$HADOLINT_CONFIG" ]; then
  HADOLINT_CONFIG="-c ${HADOLINT_CONFIG}"
fi

if [ -z "$HADOLINT_TRUSTED_REGISTRIES" ]; then
  unset HADOLINT_TRUSTED_REGISTRIES
fi

COMMAND="hadolint $HADOLINT_CONFIG"

if [ "$HADOLINT_RECURSIVE" = "true" ]; then
  shopt -s globstar

  filename="${!#}"
  flags="${*:1:$#-1}"

  # Check if filename and directory name are the same
  if [ "$(basename "$filename")" != "$(dirname "$filename")" ]; then
    # Run hadolint command and save the results to a variable
    RESULTS=$(eval "$COMMAND $flags" -- **/"$filename")

    # Check if HADOLINT_OUTPUT is specified and save results to file
    if [ -n "$HADOLINT_OUTPUT" ]; then
      if [ -f "$HADOLINT_OUTPUT" ]; then
        HADOLINT_OUTPUT="$TMP_FOLDER/$HADOLINT_OUTPUT"
      fi
      echo -n "$RESULTS" >"$HADOLINT_OUTPUT"
    fi
  else
    # Skip the check if filename and directory name are the same
    RESULTS=""
  fi
else
  flags=$*
  # Run hadolint command and save the results to a variable
  RESULTS=$(eval "$COMMAND" "$flags")

  # Check if HADOLINT_OUTPUT is specified and save results to file
  if [ -n "$HADOLINT_OUTPUT" ]; then
    if [ -f "$HADOLINT_OUTPUT" ]; then
      HADOLINT_OUTPUT="$TMP_FOLDER/$HADOLINT_OUTPUT"
    fi
    echo -n "$RESULTS" >"$HADOLINT_OUTPUT"
  fi
fi

{
  echo "results<<EOF"
  echo "$RESULTS"
  echo "EOF"
} >>"$GITHUB_OUTPUT"

{
  echo "HADOLINT_RESULTS<<EOF"
  echo "$RESULTS"
  echo "EOF"
} >>"$GITHUB_ENV"

[ -z "$HADOLINT_OUTPUT" ] || echo "Hadolint output saved to: $HADOLINT_OUTPUT"

exit $FAILED

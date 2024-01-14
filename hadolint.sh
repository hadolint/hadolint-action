#!/bin/bash
# The problem-matcher definition must be present in the repository
# checkout (outside the Docker container running hadolint). We copy
# problem-matcher.json to the home folder.

# unset certain env vars to empty values
RESULTS=''
# shellcheck disable=SC2034
HADOLINT_RESULTS=''

# disable cheks for undefined env vars, in here mostly githu env vars
# shellcheck disable=SC2154

if [[ -n "${HADOLINT_WORKING_DIRECTORY}" ]]; then
  cd "${HADOLINT_WORKING_DIRECTORY}" \
    || { echo "Error: failed to change path to ${HADOLINT_WORKING_DIRECTORY}, check if exists, if is a directory directory permissions etc"; exit 1; }
fi

PROBLEM_MATCHER_FILE="/problem-matcher.json"
if [[ -f "${PROBLEM_MATCHER_FILE}" ]]; then
  cp "${PROBLEM_MATCHER_FILE}" "${HOME}/"
fi
# After the run has finished we remove the problem-matcher.json from
# the repository so we don't leave the checkout dirty. We also remove
# the matcher so it won't take effect in later steps.
# shellcheck disable=SC2317
cleanup() {
  echo "::remove-matcher owner=brpaz/hadolint-action::"
}
trap cleanup EXIT

echo "::add-matcher::${HOME}/problem-matcher.json"

if [[ -n "${HADOLINT_CONFIG}" ]]; then
  HADOLINT_CONFIG="-c ${HADOLINT_CONFIG}"
fi

if [[ -z "${HADOLINT_TRUSTED_REGISTRIES}" ]]; then
  unset HADOLINT_TRUSTED_REGISTRIES
fi

COMMAND="hadolint ${HADOLINT_CONFIG}"

if [[ "${HADOLINT_RECURSIVE}" = "true" ]]; then
  shopt -s globstar
  filename="${!#}"
  flags="${*:1:$#-1}"

  files_found=false
  # try to find files to scan but do not end with eror if no files found
  # notice that $filename can contain glob char so we add exception here
  # shellcheck disable=SC2231
  for file in **/${filename}
  do
    if [[ -e "${file}" ]]
    then
      files_found=true
      break
    fi
  done

  if [[ "${files_found}" = "true" ]]; then
    # notice that $filename can contain glob char so we add exception here
    # shellcheck disable=SC2086,SC2231,SC2248
    RESULTS=$(eval "${COMMAND} ${flags}" -- **/${filename})
  else
    RESULTS=''
    echo "No Dockerfiles detected, skipping processing";
  fi

else
  flags=$*
  RESULTS=$(eval "${COMMAND}" "${flags}")
fi
FAILED=$?

if [[ -n "${HADOLINT_OUTPUT}" ]]; then
  if [[ -f "${HADOLINT_OUTPUT}" ]]; then
    HADOLINT_OUTPUT="${TMP_FOLDER}/${HADOLINT_OUTPUT}"
  fi
  echo "${RESULTS}" >"${HADOLINT_OUTPUT}"
fi

RESULTS="${RESULTS//$'\\n'/''}"

{
  echo "results<<EOF"
  echo "${RESULTS}"
  echo "EOF"
} >>"${GITHUB_OUTPUT}"

{
  echo "HADOLINT_RESULTS<<EOF"
  echo "${RESULTS}"
  echo "EOF"
} >>"${GITHUB_ENV}"

[[ -z "${HADOLINT_OUTPUT}" ]] || echo "Hadolint output saved to: ${HADOLINT_OUTPUT}"

# shellcheck disable=SC2248
exit ${FAILED}

#!/bin/sh

echo '::add-matcher::problem-matcher.json'

hadolint "$@"

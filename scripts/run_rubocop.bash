#!/usr/bin/env bash

set -e

cd "${0%/*}/.."

echo "Running rubocop with auto-correct"
bundle exec rubocop -A

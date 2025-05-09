#!/bin/bash

gh pr checkout "$1";

gh pr view --json body -q '.body' > ".github/pr-descriptions/$(git rev-parse --abbrev-ref HEAD).md"

cat  ".github/pr-descriptions/$(git rev-parse --abbrev-ref HEAD).md"

git checkout -



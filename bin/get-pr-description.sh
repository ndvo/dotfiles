#!/bin/bash

branchName=$(git rev-parse --abbrev-ref HEAD);
prFolders=".github/pr-descriptions";
templateName="$branchName.template.md";
templatePath="$prFolders/$templateName";

fix_line_endings() {
  sed 's/\r$//'
}

if [ ! -f "$templatePath" ]; then
  gh pr view --json body -q '.body' > "$templatePath"
else
  read -p "The template already exists. Do you want to overwrite it?" -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    gh pr view --json body -q '.body' | fix_line_endings > "$templatePath"
  fi
fi

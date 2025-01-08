#!/usr/bin/env bash
# https://vi.stackexchange.com/a/11733
# This file lives in ~/.vim/pack/install.sh
# Remember to add executable: chmod +x ~/.vim/pack/install.sh
#
# Create new folder in ~/.vim/pack that contains a start folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group syntax-highlighting
#
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group/start"
  mkdir -p "$path"
  cd "$path" || exit
}
# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url=$1
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    result=$(git clone -q "git@github.com:$repo_url"".git")
    echo "$expected_repo: $result"
  fi
}

(
set_group utils
package moll/vim-bbye &
package tpope/vim-dispatch &
package thinca/vim-localrc &
wait
) &
(
set_group reading
package wellle/context.vim &
wait
) &
(
set_group searching
package jremmen/vim-ripgrep &
package junegunn/fzf &
package junegunn/fzf.vim &
wait
) &
(
set_group editing
package AndrewRadev/sideways.vim &
package AndrewRadev/splitjoin.vim &
package AndrewRadev/switch.vim &
package AndrewRadev/tagalong.vim &
# package https://github.com/kana/vim-arpeggio &
package rstacruz/sparkup &
package tpope/vim-abolish &
package tpope/vim-jdaddy &
package vim-scripts/SyntaxComplete &
package prettier/vim-prettier &
package chrisbra/unicode.vim
wait
) &
(
set_group version_control
package mbbill/undotree &
package tpope/vim-fugitive &
package tpope/vim-rhubarb &&
wait
) &
(
set_group lsp
package dense-analysis/ale &
package pechorin/any-jump.vim &
# package ludovicchabant/vim-gutentags &
# package tpope/lsp &
# package prabirshrestha/vim-lsp &
# package mattn/vim-lsp-settings &
# package ternjs/tern_for_vim &
wait
) &
(
set_group autocomplete
package heavenshell/vim-jsdoc &
#package jayli/vim-easycomplete &
#package codota/tabnine-vim &
wait
) &
(
set_group debugging
package puremourning/vimspector &
wait
) &
(
set_group navigation
package preservim/tagbar &
package vim-scripts/BufOnly.vim & 
wait
) &
(
set_group syntax
package MaxMEllon/vim-jsx-pretty &
wait
) &
(
set_group testing
package vim-test/vim-test &
wait
) &
(
set_group database
package tpope/vim-dadbod &
wait
) &
(
set_group colorschemes
package altercation/vim-colors-solarized &
package flazz/vim-colorschemes &
package arcticicestudio/nord-vim &
wait
) &
(
set_group framework
package tpope/vim-rails &
package vim-ruby/vim-ruby &
wait
) &
wait

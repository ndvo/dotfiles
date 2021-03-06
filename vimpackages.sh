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
    git clone -q "$repo_url"
  fi
}

(
set_group utils
package https://github.com/moll/vim-bbye &
package https://github.com/airblade/vim-rooter &
package https://github.com/jremmen/vim-ripgrep &
package https://github.com/junegunn/fzf &
package https://github.com/kana/vim-arpeggio &
package https://github.com/vim-scripts/zeavim &
wait
) &
(
set_group lsp
package https://github.com/dense-analysis/ale &
package https://github.com/codota/tabnine-vim &
wait
) &
(
set_group syntax
wait
) &
(
set_group colorschemes
package https://github.com/altercation/vim-colors-solarized.git &
wait
) &
wait

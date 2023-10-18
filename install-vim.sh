#!/bin/bash

# Este script para instalar o Vim ainda não está satisfatório. Eu sempre acabo editando e reinstalando.

# Enquanto ainda não tenho um que seja adequado (se é que vou ter um dia), fica o link para a documentação que lista e descreve as opções.
# https://vimdoc.sourceforge.net/htmldoc/various.html#:!!
# Os itens marcados com "m" são de instalação manual. Os demais podem ser selecionados em conjunto ao se escolher Tiny, Normal, Big ou Huge
sudo apt install libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev libncurses-dev ruby-dev python-dev-is-python3 libpython3-dev libperl-dev
# https://medium.com/@paulodiovani/installing-vim-8-plugins-with-the-native-pack-system-39b71c351fea
cd apps
git clone http://github.com/vim/vim.git
cd vim/src
./configure \
            --with-features=huge \
            --prefix='/usr/local' \
            --enable-gui=auto \
            --enable-cscope \
            --enable-fail-if-missing \
            --enable-largefile \
            --enable-multibyte \
            \
            --enable-perlinterp=dynamic \
            --enable-python3interp=dynamic \
            --with-python3-config-dir='/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu' \
            --enable-rubyinterp=dynamic \
            --with-ruby-command=$(which ruby) \
            --with-luajit \
            --with-x \
            \
            --with-compiledby="stackoverflow.com/questions/3373914" 
make
make install

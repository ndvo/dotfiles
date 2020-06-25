https://bbs.archlinux.org/viewtopic.php?id=164108

$ mkdir ~/st-solarized
$ cd ~/st-solarized
$ git clone http://git.suckless.org/st
$ cd st
$ git apply st-solarized-dark.diff

$ make clean
$ make
$ sudo make install
$ st

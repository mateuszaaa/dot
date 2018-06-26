#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y ack-grep ctags
rm -rf ~/vim
rm -rf ~/.vimrc
ln -s /config/vim ~/vim
ln -s /config/vim/vimrc ~/.vimrc
vim -c "PluginInstall" -c "qall"
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer --system-boost
CONFIG_FILE=/code/brain_ws/.ycm_extra_conf.py
if [ -e $CONFIG_FILE ]; then
  echo "config '" $CONFIG_FILE "' already exists"
  exit 0;
else
  if [ -e /code/brain_ws/build_reldebug ]; then
    cd /code/brain_ws/src/ && ~/.vim/bundle/YCM-Generator/config_gen.py -b make -e -c /usr/bin/clang-5.0 /code/brain_ws/build_reldebug
    cp /code/brain_ws/build_reldebug/.ycm_extra_conf.py /code/brain_ws/
  else
    cd /code/brain_ws/src/ && ~/.vim/bundle/YCM-Generator/config_gen.py -b make -e -c /usr/bin/clang-5.0 /code/brain_ws/src/cmake-build-debug
    cp /code/brain_ws/src/cmake-build-debug/.ycm_extra_conf.py /code/brain_ws/
  fi
fi

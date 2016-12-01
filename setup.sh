#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0);pwd)
cd ${SCRIPT_DIR}/

HOME=/home/`whoami`
mkdir -p ${HOME}/.docker
mkdir -p ${HOME}/.config

ln -s ${HOME}/settings/ackrc ${HOME}/.ackrc
ln -s ${HOME}/settings/gitconfig ${HOME}/.gitconfig
ln -s ${HOME}/settings/gitignore ${HOME}/.gitignore
ln -s ${HOME}/settings/gvimrc ${HOME}/.gvimrc
ln -s ${HOME}/settings/vimrc ${HOME}/.vimrc
ln -s ${HOME}/settings/xkb ${HOME}/.xkb
ln -s ${HOME}/settings/zshrc ${HOME}/.zshrc

ln -s ${HOME}/settings/.docker.config.json ${HOME}/.docker/config.json
ln -s ${HOME}/settings/flake8 ${HOME}/.config/flake8

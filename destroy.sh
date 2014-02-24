#!/bin/sh

cd `dirname $0`
export HOME=$PWD

# 設定ファイルを削除
rm -f elecoma-vagrant-ssh.conf

# 仮想サーバを破棄
bundle exec vagrant destroy -f

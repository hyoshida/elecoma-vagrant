#!/bin/sh

cd `dirname $0`
export HOME=$PWD

# elecoma-vagrantをセットアップ
./setup.sh

# テストを実行
bundle exec rake ci:setup:rspec spec

# 設定ファイルを削除
rm -f elecoma-vagrant-ssh.conf

# 仮想サーバを破棄
bundle exec vagrant destroy -f

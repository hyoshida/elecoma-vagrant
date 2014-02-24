#!/bin/sh

cd `dirname $0`
export HOME=$PWD

print() {
    printf "\033[1;32m$*\033[0;39m\n"
}

error() {
    printf "\033[1;31mAn error occurred!\033[0;39m\n"
    exit 1
}

# Gemをインストール
print "Install gems..."
bundle install --path vendor/bundle || error

# クックブックをインストール
print "Install cookbooks..."
bundle exec berks install --path cookbooks || error

# VM起動
print "Startup vagrant box..."
bundle exec vagrant up || error

# VMのSSH設定を出力
bundle exec vagrant ssh-config --host=elecoma-vagrant > elecoma-vagrant-ssh.conf || error

# Chefのインストールとクックブック適用 (bootstrap = prepare + cook)
print "Setup elecoma-vagrant..."
bundle exec knife solo bootstrap elecoma-vagrant -F elecoma-vagrant-ssh.conf || error

# テストを実行
bundle exec rake ci:setup:rspec spec

print "Setup successfully!"

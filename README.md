Elecoma vagrant
===============

Please enter the following line in the command line:

    git clone git://github.com/hyoshida/elecoma-vagrant.git
    cd elecoma-vagrant
    bundle install --path vendor/bundle
    bundle exec berks install --path cookbooks
    bundle exec vagrant up
    bundle exec vagrant ssh-config --host=elecoma-vagrant > elecoma-vagrant-ssh.conf
    bundle exec knife solo bootstrap elecoma-vagrant -F elecoma-vagrant-ssh.conf

Then, please go to ``localhost:8080`` in your browser.

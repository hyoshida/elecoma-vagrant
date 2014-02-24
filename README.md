# elecoma-vagrant

Please enter the following line in the command line:

    git clone git://github.com/hyoshida/elecoma-vagrant.git
    cd elecoma-vagrant
    ./setup.sh

Then, please go to ``localhost:8080`` in your browser.

## Requirements

* VirtualBox 4.0, 4.1, 4.2 (required for Vagrant)
* Ruby 1.9 or 2.0
* bundler
* Nokogiri (see [Note](#note))

# Note

setup.sh install [Nokogiri](http://nokogiri.org/ "Nokogiri") gem package.
If you raise a error when install nokogiri, please check [Nokogiri's installing document](http://nokogiri.org/tutorials/installing_nokogiri.html "Nokogiri's installing document").

name             'elecoma-vagrant'
maintainer       'Appirits Inc.'
maintainer_email 'hyoshida@appirits.com'
license          'All rights reserved'
description      'Installs/Configures elecoma-vagrant'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "database"
depends "postgresql"
depends "application"
depends "application_ruby"

depends "imagemagick"

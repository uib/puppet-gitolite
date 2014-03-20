# == Class: gitolite::install
#
# This module is designed to install a gitolite server
#
# === Authors
#
# Raymond Kristiansen <raymond@uib.no>
#
class gitolite::install(
  $package = $gitolite::package
) {

  package { $package:
    ensure => latest,
  }
  
}
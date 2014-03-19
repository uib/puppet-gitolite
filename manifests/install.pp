class gitolite::install(
  $package = $gitolite::package
) {

  package { $package:
    ensure => latest,
  }
  
}
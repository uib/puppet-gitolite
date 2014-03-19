class gitolite(
  $ssh_key,
  $user = 'gitolite3',
  $group = 'gitolite3',
  $package = 'gitolite3',
  $base_dir = '/var/lib/gitolite3'
) {

  class { 'gitolite::install': } ->
  class { 'gitolite::config': }

}
# == Class: gitolite
#
# This module is designed to install and configure a gitolite server
#
# === Parameters
#
# [*ssh_key*]
#   the SSH key used to seed the admin account
#
# [*user*]
#   user to run gitolite as. E.G. 'git'
#
# [*uid*]
#   uid for user
#
# [*group*]
#   group for user
#
# [*gid*]
#   gid for group
#
# [*mode*]
#   directory mode for path ${base_dir}/repositories. Should match umask in $settings to work with gitweb/cgit
#
# [*package*]
#   gitolite install package name
#
# [*base_dir*]
#   path to gitolite
#
# [*admin_user*]
#   gitolite admin user associated with the ssh public key.
#
# [*settings*]
#   hash of RC settings in .gitolite.rc
#   See templates/gitolite.rc.erb for full list configurable elements
#   Example: {
#     umask => '0027,
#     log_extra => false,
#     git_config_keys => 'gitweb.*',
#     hostname => 'git',
#     local_code => '$ENV{HOME}/local',
#     cmd_fork => 'enable',
#     cmd_perms => 'disable',
#     daemon => 'disable'
#     mirroring => 'enable',
#     cgit => 'enable'
#   }
#
# === Authors
#
# Raymond Kristiansen <raymond@uib.no>
#
class gitolite(
  $ssh_key,
  $user = 'gitolite3',
  $group = 'gitolite3',
  $uid = undef,
  $gid = undef,
  $mode = '0750',
  $package = 'gitolite3',
  $base_dir = '/var/lib/gitolite3',
  $admin_user = 'gitolite',
  $settings = {}
) {

  class { 'gitolite::install': } ->
  class { 'gitolite::config': }

}

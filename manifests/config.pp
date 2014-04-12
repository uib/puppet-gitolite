# == Class: gitolite::config
#
# This module is designed to configure a gitolite server
#
# === Authors
#
# Raymond Kristiansen <raymond@uib.no>
#
class gitolite::config(
  $ssh_key = $gitolite::ssh_key,
  $user = $gitolite::user,
  $group = $gitolite::group,
  $uid = $gitolite::uid,
  $gid = $gitolite::gid,
  $mode = $gitolite::mode,
  $base_dir = $gitolite::base_dir,
  $admin_user = $gitolite::admin_user,
  $settings = $gitolite::settings
) {

  File {
    owner => $user,
    group => $group,
    mode => 0644
  }
  
  Exec {
    path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin',
  }

  user { $user:
    uid => $uid,
    gid => $group,
    home => $base_dir,
    managehome => true,
    shell => '/bin/bash'
  }

  group { $group:
    ensure => present,
    gid => $gid,
    before => User[$user]
  }

  file { $base_dir: 
    ensure => directory,
    mode => $mode,
  }
  
  # Copy skel files to new home  
  exec { 'copy gitolite etc/skel':
    command => "cp -r /etc/skel/. ${base_dir}",
    user => $user,
    creates => "${base_dir}/.bashrc",
    require => File[$base_dir]
  }
  
  file { 'gitolite-key':
    ensure => file,
    path => "${base_dir}/${admin_user}.pub",
    content => $ssh_key
  }

  exec { 'gitolite-setup':
    command => "gitolite setup -pk ${admin_user}.pub",
    creates => "${base_dir}/.gitolite.rc",
    cwd => $base_dir,
    user => $user,
    environment => "HOME=${base_dir}",
    require => File['gitolite-key'],
  }
  
  file { 'gitolite.rc':
    ensure => file,
    mode => 0600,
    path => "${base_dir}/.gitolite.rc",
    content => template("${module_name}/gitolite.rc.erb"),
    require => Exec['gitolite-setup']
  }

  file { "${base_dir}/repositories":
    ensure => directory,
    mode => $mode,
    require => Exec['gitolite-setup']
  }

}
class gitolite::config(
  $ssh_key = $gitolite::ssh_key,
  $user = $gitolite::user,
  $group = $gitolite::group,
  $base_dir = $gitolite::base_dir,
) {

  File {
    owner => $user,
    group => $group,
    mode => 0644
  }

  if $user != 'gitolite3' {
    user { $user:
      uid => 510,
      gid => $group,
      home => $base_dir,
      managehome => false,  
    }
    group { $group:
      before => User[$user]
    }
  }

  file { $base_dir: 
    ensure => directory,
    mode => 750,
  }
  
  file { 'gitolite-key':
    ensure => file,
    path => "${base_dir}/gitolite.pub",
    content => $ssh_key
  }

  exec { 'gitolite-setup':
    command => "gitolite setup -pk gitolite.pub",
    creates => "${base_dir}/projects.list",
    cwd => $base_dir,
    user => $user,
    path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin',
    environment => "HOME=${base_dir}",
    require => File['gitolite-key'],
  }
  
}
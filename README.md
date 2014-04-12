# Gitolite puppet module
Puppet management of gitolite git server

Gitolite can be found at https://github.com/sitaramc/gitolite

## Usage
Simple bootstrap of gitolite git server:
<pre>
class { 'gitolite': 
  ssh-key: 'ssh-rsa AAAAB3....'
}
</pre>

## Tested
This module is tested with CentOS 6.5 and gitolite3-3.5.3 from EPEL

## Author
Raymond Kristiansen <raymond@uib.no>

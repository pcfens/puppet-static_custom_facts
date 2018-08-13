class static_custom_facts::params {
  $purge_unmanaged = false

  case $::kernel {
    'Linux': {
      $parent_dirs = []
      $facts_path = '/opt/puppetlabs/facter/facts.d'
      $facts_path_owner = 'root'
      $facts_path_group = 'root'
    }
    'OpenBSD': {
      $parent_dirs = ['/etc/puppetlabs/facter']
      $facts_path = '/etc/puppetlabs/facter/facts.d'
      $facts_path_owner = 'root'
      $facts_path_group = 'wheel'
    }
    'Windows': {
      $parent_dirs = []
      $facts_path = 'C:/ProgramData/PuppetLabs/facter/facts.d'
      $facts_path_owner = ''
      $facts_path_group = ''
    }
    default: {
      fail("${::kernel} is not supported by the static_custom_fact module")
    }
  }
}

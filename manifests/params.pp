class static_custom_facts::params {
  $purge_unmanaged = false
  $facts_path_owner = 'root'
  $facts_path_group = 'root'

  case $::kernel {
    'Linux': {
      $facts_path = '/opt/puppetlabs/facter/facts.d'
    }
    'Windows': {
      $facts_path = 'C:/ProgramData/PuppetLabs/facter/facts.d'
    }
    default: {
      fail("${::kernel} is not supported by the static_custom_fact module")
    }
  }
}

# This class sets up and provides static custom facts
#
# @summary Sets up a location for and creates static custom facts
#
# @example Delcaring the class
#   include ::static_custom_facts
#
# @example defining static facts via hiera
#   static_custom_facts::custom_facts:
#     static1: Hello world
#     static2:
#       - Hello
#       - world
#     static3:
#       what: Hello
#       whom: world
#
# @param parent_dirs Parent directories of facts_path to create
# @param facts_path The location where custom facts will be installed
# @param facts_path_owner The owner of the custom facts directory (not created by this module)
# @param facts_path_group The group that owns the custom facts directory (not created by this module)
# @param purge_unmanaged If facts in the facts_path not managed by puppet are deleted or not
# @param custom_facts A hash of facts that should be created (useful with hiera)
class static_custom_facts(
  Array             $parent_dirs      = $static_custom_facts::params::parent_dirs,
  String            $facts_path       = $static_custom_facts::params::facts_path,
  String            $facts_path_owner = $static_custom_facts::params::facts_path_owner,
  String            $facts_path_group = $static_custom_facts::params::facts_path_group,
  Boolean           $purge_unmanaged  = $static_custom_facts::params::purge_unmanaged,
  Hash[String,Data] $custom_facts     = {},
) inherits static_custom_facts::params {

  case $::kernel {
    'Linux', 'OpenBSD': {
      file { $parent_dirs:
        ensure => directory,
        owner  => $facts_path_owner,
        group  => $facts_path_group,
      }

      file { 'facts-directory':
        ensure  => directory,
        path    => $facts_path,
        owner   => $facts_path_owner,
        group   => $facts_path_group,
        recurse => $purge_unmanaged,
        purge   => $purge_unmanaged,
      }
    }
    'Windows': {
      file { $parent_dirs:
        ensure  => directory,
      }
      file { 'facts-directory':
        ensure  => directory,
        path    => $facts_path,
        recurse => $purge_unmanaged,
        purge   => $purge_unmanaged,
      }
    }
    default: {
      fail("${::kernel} isn't supported by the custom_facts module")
    }
  }

  $custom_facts.each |$name, $value| {
    $ensure = defined('$value') ? {
      true    => 'present',
      default => 'absent',
    }
    static_custom_facts::fact { $name:
      ensure => $ensure,
      value  => $value,
    }
  }
}

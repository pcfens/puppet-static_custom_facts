# Create a static custom fact
#
# @summary Create a static custom fact
#
# @example Create a custom fact representing responsible contacts
#   custom_facts::fact { 'responsible_contact':
#     value => [
#       'user@example.com',
#       'user1@example.com',
#     ],
#   }
#
# @param value The value of the fact (can include structured facts)
# @param ensure Set to absent to explicitly remove the custom fact - behaves like a normal ensure parameter
define static_custom_facts::fact (
  Variant[String, Array, Hash, Numeric, Boolean] $value,
  Enum['present', 'absent', 'file']              $ensure = present,
) {
  $yaml_value = {
    $name => $value,
  }

  $fact_template = @(END)
# Managed by Puppet
<%= @yaml_value.to_yaml() %>
  END

  file{ "facts-${name}":
    ensure  => $ensure,
    path    => "${static_custom_facts::facts_path}/${name}.yaml",
    content => inline_template($fact_template),
  }
}

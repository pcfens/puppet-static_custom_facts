require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

UNSUPPORTED_PLATFORMS = %w(aix Solaris BSD).freeze

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    puppet_module_install(source: module_root, module_name: 'static_custom_facts')
  end
end

shared_examples 'an idempotent resource' do
  it 'apply with no errors' do
    apply_manifest(pp, catch_failures: true)
  end

  it 'apply a second time without changes', :skip_pup_5016 do
    apply_manifest(pp, catch_changes: true)
  end
end

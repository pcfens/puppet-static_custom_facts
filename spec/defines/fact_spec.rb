require 'spec_helper'

describe 'static_custom_facts::fact', type: :define do
  let :pre_condition do
    'include ::static_custom_facts'
  end
  let :title do
    'responsible_contacts'
  end

  context 'with no parameters' do
    it { is_expected.to raise_error(Puppet::Error) }
  end

  context 'On Linux' do
    let :facts do
      {
        kernel: 'Linux'
      }
    end

    context 'with two contacts set' do
      let :params do
        {
          value: ['user@email.com', 'email@user.com']
        }
      end
      it do
        is_expected.to contain_file('facts-responsible_contacts').with(
          path: '/opt/puppetlabs/facter/facts.d/responsible_contacts.yaml',
          content: '# Managed by Puppet
---
responsible_contacts:
- user@email.com
- email@user.com

'
        )
      end
    end
  end
end

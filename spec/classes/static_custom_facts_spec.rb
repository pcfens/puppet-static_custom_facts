require 'spec_helper'

describe 'static_custom_facts', type: :class do
  context 'On a Linux system' do
    let :facts do
      {
        kernel: 'Linux'
      }
    end

    context 'defaults' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('static_custom_facts') }
      it { is_expected.to contain_class('static_custom_facts::params') }
      it do
        is_expected.to contain_file('facts-directory').with(
          ensure: 'directory',
          path: '/opt/puppetlabs/facter/facts.d'
        )
      end
    end
  end

  context 'On a Windows system' do
    let :facts do
      {
        kernel: 'Windows'
      }
    end

    context 'defaults' do
      # it { is_expected.to compile.with_all_deps } # Omitted because of https://github.com/rodjek/rspec-puppet/issues/192
      it { is_expected.to contain_class('static_custom_facts') }
      it { is_expected.to contain_class('static_custom_facts::params') }
      it do
        is_expected.to contain_file('facts-directory').with(
          ensure: 'directory',
          path: 'C:/ProgramData/PuppetLabs/facter/facts.d',
          recurse: false
        )
      end
    end
  end
end

require 'spec_helper'

describe 'static_custom_facts', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('static_custom_facts') }
        it { is_expected.to contain_class('static_custom_facts::params') }
        it do
          is_expected.to contain_file('facts-directory').with(
            ensure: 'directory',
          )
        end
      end  
    end
  end

  context 'On a Linux system' do
    let :facts do
      {
        kernel: 'Linux',
      }
    end

    context 'defaults' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('static_custom_facts') }
      it { is_expected.to contain_class('static_custom_facts::params') }
      it do
        is_expected.to contain_file('facts-directory').with(
          ensure: 'directory',
          path: '/opt/puppetlabs/facter/facts.d',
          owner: 'root',
          group: 'root',
        )
      end
    end
  end

  context 'On a OpenBSD system' do
    let :facts do
      {
        kernel: 'OpenBSD',
      }
    end

    context 'defaults' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('static_custom_facts') }
      it { is_expected.to contain_class('static_custom_facts::params') }
      it do
        is_expected.to contain_file('/etc/puppetlabs/facter').with(
          ensure: 'directory',
          path: '/etc/puppetlabs/facter',
          owner: 'root',
          group: 'wheel',
        )
      end
      it do
        is_expected.to contain_file('facts-directory').with(
          ensure: 'directory',
          path: '/etc/puppetlabs/facter/facts.d',
          owner: 'root',
          group: 'wheel',
        )
      end
    end
  end

  context 'On a Windows system' do
    let :facts do
      {
        kernel: 'Windows',
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
          recurse: false,
        )
      end
    end
  end
end

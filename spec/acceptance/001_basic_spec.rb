require 'spec_helper_acceptance'

describe 'static_custom_facts class' do
  context 'default parameters' do
    let(:pp) do
      <<-EOS
      include ::static_custom_facts

      static_custom_facts::fact { 'responsible_people':
        value => [
          'user@example.com',
        ],
      }
      EOS
    end

    it_behaves_like 'an idempotent resource'

    describe file('/opt/puppetlabs/facter/facts.d/responsible_people.yaml') do
      it { is_expected.to be_file }
      it { is_expected.to contain('---') }
      it { is_expected.to contain('user@example.com') }
      it { is_expected.not_to contain('max_procs: !ruby') }
    end
  end
end

require 'spec_helper'
describe 'nubis_discovery' do

  context 'with defaults for all parameters' do
    it { should contain_class('nubis_discovery') }
  end
end

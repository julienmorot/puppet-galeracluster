require 'spec_helper'
describe 'galeracluster' do
  context 'with default values for all parameters' do
    it { should contain_class('galeracluster') }
  end
end

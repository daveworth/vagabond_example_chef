$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

require 'vagabond'
include Vagabond

describe service('apache2') do
  it { should_not be_running }
end

describe service('nginx') do
  it { should be_running }
end

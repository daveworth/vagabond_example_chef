$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

require 'vagabond'
include Vagabond

describe file("/etc/motd") do
  it { should exist }
  it { should have_owner('root') }
  it { should have_group('root') }
  it { should have_file_type(:file) }
  it { should have_content('foo') }
  it { should have_content(/foo/) }
  it { should have_content(/foo.*baz/m)}
end

describe file("/etc") do
  it { should exist }
  it { should have_file_type(:directory) }
end

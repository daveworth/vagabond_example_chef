$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

require 'vagabond'
include Vagabond

describe user("coder") do
  it { should exist }

  it { should be_member_of_group("group") }
  it { should be_member_of_group(314159)  }

  it { should have_shell("/bin/bash")      }
  it { should_not have_shell("/bin/false") }

  it { should have_home_directory("/home/coder")   }
  it { should_not have_home_directory("/bad/path") }
end

describe user("nonexistent") do
  it { should_not exist }
end

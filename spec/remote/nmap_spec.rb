$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

require 'vagabond/remote'
include Vagabond::Remote

describe port_and_service_scan, :remote => true do
  it { should have_open_port 22     }
  it { should have_open_port "ssh"  }
  it { should_not have_open_port 23 }

  it { should only_have_open_ports [111, 80, 22]         }  # order agnostic
  it { should_not only_have_open_ports [80, 111]         }  # subset
  it { should_not only_have_open_ports [22, 23, 80, 111] }  # superset
  it { should_not only_have_open_ports [23, 25]          }  # disjoint set

  it { should have_remote_service "OpenSSH" }
  it { should_not have_remote_service "Apache" }
  it { should have_remote_service "nginx", on_port: 80 }

  it { should have_remote_service     "OpenSSH",       on_port: 22 }
  it { should_not have_remote_service "CommercialSSH", on_port: 22 }
  it { should_not have_remote_service "OpenSSH",       on_port: 23 }

  it { should have_remote_service_version     "OpenSSH", "5.3p1"   }
  it { should_not have_remote_service_version "OpenSSH", "0.9beta" }
end

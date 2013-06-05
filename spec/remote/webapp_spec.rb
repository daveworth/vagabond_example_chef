$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

require 'vagabond/remote'
include Vagabond::Remote

describe "Testing Nginx's default landing page", :remote => :true do
  let(:default_landing_page_copy) { "Welcome to nginx" }

  describe webapp(default_url) do
    it "should have a landing page" do
      visit "/"
      page.should have_content default_landing_page_copy
    end
  end

  describe webapp("apache_app", url: default_url) do
    it "should have a landing page" do
      visit "/"
      page.should have_content default_landing_page_copy
    end
  end
end

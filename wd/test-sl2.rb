require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"

class Testsl2 < Test::Unit::TestCase

  def setup
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*chrome",
      :url => "https://18.0.101.46:8443/",
      :timeout_in_second => 60

    @selenium.start_new_browser_session
  end
  
  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
  
  def test_Testsl2
    @selenium.open "/servlet/com.cisco.unicorn.ui.LoginServlet"
    @selenium.type "username", "admin"
    @selenium.type "password", "default"
    @selenium.click "link=Login"
    @selenium.wait_for_page_to_load "30000"
    @selenium.select_frame "body"
    @selenium.click "link=5 Delivery Services"
    @selenium.wait_for_page_to_load "30000"
    begin
        assert @selenium.is_text_present("flash-sanity")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
    @selenium.select_frame "relative=up"
    @selenium.select_frame "nav"
    @selenium.click "link=Logout"
    assert /^Are you sure you want to log off[\s\S]$/ =~ @selenium.get_confirmation
  end
end

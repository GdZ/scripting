require "test/unit"
require "rubygems"
#gem "selenium-client"
#require "selenium/client"
require "selenium-webdriver"
class Test1 < Test::Unit::TestCase

	def setup
		@verification_errors = []
		@selenium = Selenium::WebDriver.for(:remote)
		@selenium.manage.timeouts.implicit_wait = 3

	end

	def teardown
		@selenium.quit
		assert_equal [], @verification_errors
	end

	def test_Test1
		@selenium.navigate.to "https://18.0.101.46:8443/servlet/com.cisco.unicorn.ui.LoginServlet"
		h_window = @selenium.window_handle;
		e_user = @selenium.find_element(:name, 'username')
		e_user.send_keys "admin"

		e_pass = @selenium.find_element(:name, 'password')
		e_pass.send_keys "default"
		e_login = @selenium.find_element(:link,'Login')
		e_login.click()
		a = @selenium.switch_to.alert
		puts a.text
		#if alert.text == 'somegthing'  
		#	alert.dismiss
		#else  
		#	alert.accept
		#end
		a.accept
		#wins = @selenium.window_handles;
		#wins.each {|win| puts win }
		#puts h_window
		#@selenium.switch_to.window(h_window)
		#@selenium.get "https://18.0.101.46:8443/servlet/com.cisco.unicorn.ui.LoginServlet"
		#@selenium.switch_to.frame('nav')
		#e_ds = @selenium.find_element(:link,"Delivery Services")
		#e_ds.click()

		#wins = @selenium.window_handles;
		#wins.each {|win| puts win }
		es = @selenium.find_elements(:tag_name,'frame')
		es.each {|ele| puts ele }

		f_nav = @selenium.find_element(:name,'nav')
		f_body = @selenium.find_element(:name,'body')
		@selenium.switch_to.frame(f_nav)
		co = @selenium.find_element(:link,'Services')
		co.click()
		co = @selenium.find_element(:link,'Content Origins')
		co.click()
		puts "Now we can see the CO tables"

		@selenium.switch_to.window(h_window)

		puts "find out the body frame again"
		@selenium.switch_to.frame(f_body)
		co_list = @selenium.find_element(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr[4]/td')
		puts co_list.text

		puts "start to logout"

		@selenium.switch_to.window(h_window)
		@selenium.switch_to.frame(f_nav)
		e_logout = @selenium.find_element(:link, 'Logout')
		#
		#@selenium.execute_script('logout','')
		e_logout.click()

		@selenium.switch_to.window(h_window)
		a = @selenium.switch_to.alert
		puts a.text
		#if alert.text == 'somegthing'  
		#	alert.dismiss
		#else  
		#	alert.accept
		#end
		a.accept
		begin

			assert_equal "1000","1000"
		rescue Test::Unit::AssertionFailedError
			@verification_errors << $!
		end
	end
end


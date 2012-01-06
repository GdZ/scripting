require "rubygems"
require "selenium-webdriver"
class CDSMWebDriver

	attr_accessor :browser
	attr_reader :driver
	def initialize(browser,ip)
		@driver = Selenium::WebDriver.for(:remote)
		@driver.manage.timeouts.implicit_wait = 3
		@cdsm_url = "https://" + ip + ":8443"
		puts @cdsm_url

	end

	def teardown
		@driver.quit
	end

	def login(username,password) 

		@driver.navigate.to @cdsm_url + "/servlet/com.cisco.unicorn.ui.LoginServlet"
		h_window = @driver.window_handle;
		@main_window = h_window
		e_user = @driver.find_element(:name, 'username')
		e_user.send_keys username

		e_pass = @driver.find_element(:name, 'password')
		e_pass.send_keys password
		e_login = @driver.find_element(:link,'Login')
		e_login.click()
		#What would happen if no alert window popup ?
		## TODO
		a = @driver.switch_to.alert
		puts a.text
		#if alert.text == 'somegthing'  
		#	alert.dismiss
		#else  
		#	alert.accept
		#end
		a.accept

		@nav_frame = @driver.find_element(:name,'nav')
		@body_frame = @driver.find_element(:name,'body')
	end

	def goto_CO_list
		goto_nav()
		@driver.find_element(:link,'Services').click()
		@driver.find_element(:link,'Content Origins').click()
		goto_body()
	end
	
	def goto_nav
		@driver.switch_to.default_content
		@driver.switch_to.frame(@nav_frame)
	end
	def goto_body
		@driver.switch_to.default_content
		@driver.switch_to.frame(@body_frame)
	end
	def goto_toc
		goto_body()
		@driver.switch_to.frame('toc')
	end

	def goto_content
		goto_body()
		@driver.switch_to.frame('content')
	end
	def set_co_byname(co_name,co_prop,co_value)
		goto_CO_list
		colink_hash = Hash.new
		co_list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr')
		co_list_length = co_list.length
		#remove the fist 2 and last 2 rows
		co_list = co_list[2,co_list_length-4]
		co_list.each do |co_tr|
			co_pros = co_tr.find_elements(:tag_name,'td')
			mylink = co_pros[0].find_element(:tag_name,'a')
			colink_hash[co_pros[0].text] = mylink
		end
		puts "click the specific CO"
		colink_hash[co_name].click

		@driver.switch_to.frame('content')
		@driver.switch_to.frame('middle')
		co_button = @driver.find_element(:name,co_prop)
		co_button_value = co_button.attribute('value')
		puts "Current value of " + co_prop + "co_button_value"

		co_button.clear()
		co_button.send_keys(co_value)

		goto_content()
		@driver.switch_to.frame('footer')
		@driver.find_element(:link,'Submit').click()

	end

	def get_co_byname(co_name)
		goto_CO_list
		colink_hash = Hash.new
		co_list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr')
		co_list_length = co_list.length
		#remove the fist 2 and last 2 rows
		co_list = co_list[2,co_list_length-4]
		co_list.each do |co_tr|
			co_pros = co_tr.find_elements(:tag_name,'td')
			puts "One item of Content Origin"
			puts "CONAME = " + co_pros[0].text + " RFQDN = " + co_pros[1].text + " OFQDN = " + co_pros[2].text
			mylink = co_pros[0].find_element(:tag_name,'a')
			colink_hash[co_pros[0].text] = mylink
		end
		colink_hash[co_name].click

		@driver.switch_to.frame('content')
		@driver.switch_to.frame('middle')
		names = @driver.find_elements(:tag_name,'input')
		#puts "Show tag input name within frame " + names.length().to_s
		names.each do |name| 
			#name.inspect
			#puts "input tage name is " + name.attribute('name')
		end
		#@driver.find_element(:link,'Definition').click()

		goto_content()
		@driver.switch_to.frame('middle')
		names = @driver.find_elements(:tag_name,'input')
		names.each do |name| 
		#	name.inspect
		#puts	name.attribute('name')
		end
		co_info = @driver.find_element(:name,'OriginFqdn')
		co_ofqdn = co_info.attribute('value')
		co_info = @driver.find_element(:name,'Fqdn')
		co_rfqdn = co_info.attribute('value')

		puts co_name + " RFQDN: " + co_ofqdn + " OFQDN: " + co_rfqdn

	end
	def get_co_list

		goto_CO_list
		co_list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr')
		co_list_length = co_list.length
		#remove the fist 2 and last 2 rows
		co_list = co_list[2,co_list_length-4]
		co_list.each do |co_tr|
			co_pros = co_tr.find_elements(:tag_name,'td')
			puts "One item of Content Origin"
			puts "CONAME=" + co_pros[0].text + "RFQDN=" + co_pros[1].text + "OFQDN=" + co_pros[2].text
			#co_pros.each do |co_pros_item| 
			#	puts co_pros_item.text
				#puts co_pros_item.inspect
			#end
		end
	end

	def goto_DS_list

		goto_nav()
		@driver.find_element(:link,'Services').click()
		@driver.find_element(:link,'Delivery Services').click()
		goto_body()
	end
	def get_ds_byname(ds_name)
		goto_DS_list
		dslink_hash = Hash.new
		ds_list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr')
		ds_list_length = ds_list.length
		#remove the fist 1
		ds_list = ds_list[1,ds_list_length-1]
		ds_list.each do |ds_tr|
			ds_pros = ds_tr.find_elements(:tag_name,'td')
			puts "------- Show One Row of Delivery Service -----"
			puts "DSNAME = " + ds_pros[0].text + " TYPE = " + ds_pros[1].text + " OFQDN = " + ds_pros[2].text
			ds_status = ds_pros[3].find_element(:tag_name,'tr')
			puts ds_status.find_element(:xpath,'./td/table/tbody/tr/td/a').attribute('href')
			puts ds_status.find_element(:xpath,'./td[2]/a').text
			puts ds_status.find_element(:xpath,'./td[3]').text
			mylink = ds_pros[0].find_element(:tag_name,'a')
			dslink_hash[ds_pros[0].text] = mylink
		end
		dslink_hash[ds_name].click

		@driver.switch_to.frame('content')
		@driver.switch_to.frame('middle')
		names = @driver.find_elements(:tag_name,'input')
		#puts "Show tag input name within frame " + names.length().to_s
		names.each do |name| 
			#name.inspect
			#puts "input tage name is " + name.attribute('name')
		end
		#@driver.find_element(:link,'Definition').click()

		goto_toc()
		@driver.find_element(:link,'General Settings').click()
		goto_content()
		@driver.switch_to.frame('middle')
		names = @driver.find_elements(:tag_name,'input')
		names.each do |name| 
			name.inspect
		puts	name.attribute('name')
		end
		ds_info = @driver.find_element(:name,'Bitrate')
		ds_bitrate = ds_info.attribute('value')
		ds_info = @driver.find_element(:name,'HttpExt')
		ds_httpext = ds_info.attribute('value')

		puts ds_name + " Bitrate: " + ds_bitrate + " HttpExt: " + ds_httpext

	end
	def logout

		puts "start to logout"
		goto_nav()
		@driver.find_element(:link, 'Logout').click()
		#debug code, only one window when alert window popup
		#windows = @driver.window_handles
		#windows.each { |win| puts win}
		#frs = @driver.find_elements(:tag_name,'frame')
		#frs.each { |fr| puts fr}
		a = @driver.switch_to.alert
		#puts a.text #false will be print out
		a.accept
	end

end
cdsm = CDSMWebDriver.new('firefox','18.0.101.46')
cdsm.login('admin','default')
cdsm.get_co_byname("flashdemo")
cdsm.set_co_byname("flashdemo","OriginFqdn","12.0.0.125")
cdsm.get_co_byname("flashdemo")
cdsm.get_ds_byname("we-sanity")
cdsm.logout()
cdsm.teardown()

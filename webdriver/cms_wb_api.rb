#!/usr/bin/ruby
require "rubygems"
require "selenium-webdriver"
class CDSMWebDriver

	attr_accessor :browser
	attr_reader :driver
	def initialize(browser,cap,cdsm_login_url)
		wb_url = "http://" + browser + ":4444" + "/wd/hub"
		@driver = Selenium::WebDriver.for(:remote,:url => wb_url,:desired_capabilities => :"#{cap}")
        #TODO: non-remote mode should be supported
		#@driver = Selenium::WebDriver.for(:firefox)
		@driver.manage.timeouts.implicit_wait = 3
		#@cdsm_url = "https://" + cdsm_ip + ":8443"
		@cdsm_url = cdsm_login_url
		#TODO verify cdsm login url
		puts @cdsm_url
		@browser_type = cap

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

		#@nav_frame = @driver.find_element(:name,'nav')
		#@body_frame = @driver.find_element(:name,'body')
	end

	def goto_CO_page
		goto_nav()
		@driver.find_element(:link,'Services').click()
		@driver.find_element(:link,'Content Origins').click()
		goto_body()
	end
	
	def goto_nav
		@driver.switch_to.default_content
		@driver.switch_to.frame('nav')
	end
	def goto_body
		@driver.switch_to.default_content
		@driver.switch_to.frame('body')
	end
	def goto_toc
		goto_body()
		@driver.switch_to.frame('toc')
	end

	def goto_content
		goto_body()
		@driver.switch_to.frame('content')
	end
	def goto_content_header
		goto_content()
		@driver.switch_to.frame('header')
	end
	def goto_content_middle
		goto_content()
		@driver.switch_to.frame('middle')
	end
	def goto_content_footer
		goto_content()
		@driver.switch_to.frame('footer')
	end
	def goto_system(sub_menu)
		goto_nav()
		@driver.find_element(:link,'System').click()
		@driver.find_element(:link,sub_menu).click()
		goto_body()
	end
	def goto_system_config
		#goto_nav()
		#@driver.find_element(:link,'System').click()
		#@driver.find_element(:link,'Configuration').click()
		#goto_body()
        goto_system('Configuration')
	end
	def goto_DS_page
		goto_nav()
		@driver.find_element(:link,'Services').click()
		@driver.find_element(:link,'Delivery Services').click()
		goto_body()
	end

    #TODO: Be able to set all in the same func
    # as i know, there are 5 kind of 'input', 1) input,type=text, 2) select, option 3)input, type=checkbox 4)textarea
    # 5) input, type=hidden
    # idealy the parameters look like: name,key-1, val-1,key-2,val-2
    # if it's check box, val should be 0,1
    # if it's option and text, val should be the extra text
    # ignore hidden ones
	def set_co(co_name,co_prop,co_value)
		goto_CO_page
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
		goto_content_middle()
		co_button = @driver.find_element(:name,co_prop)
		co_button_value = co_button.attribute('value')
		puts "Current value of " + co_prop + "co_button_value"
		co_button.clear()
		co_button.send_keys(co_value)
        submit

	end

	def get_co(co_name)
		goto_CO_page
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
			colink_hash[co_pros[0].text.strip] = mylink
		end
		colink_hash[co_name].click

        goto_content_middle
		names = @driver.find_elements(:tag_name,'input')
		#puts "Show tag input name within frame " + names.length().to_s
		names.each do |name| 
			#name.inspect
			#puts "input tage name is " + name.attribute('name')
		end
		#@driver.find_element(:link,'Definition').click()

        goto_content_middle()
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
		goto_CO_page
		co_list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr')
		co_list_length = co_list.length
		#remove the fist 2 and last 2 rows
		co_list = co_list[2,co_list_length-4]
		co_list.each do |co_tr|
			co_pros = co_tr.find_elements(:tag_name,'td')
			puts "One item of Content Origin"
			puts "CONAME=" + co_pros[0].text + "RFQDN=" + co_pros[1].text + "OFQDN=" + co_pros[2].text
		end
	end

	def get_syscfg_list
		goto_system_config()
		goto_toc()
		cfg_tb = @driver.find_elements(:xpath,'/html/body/form/table[3]/tbody/tr/td/table/tbody/tr')
		cfg_tb_length = cfg_tb.length
		puts "len of cfg_tb" + cfg_tb.length.to_s
		cfg_list = Array.new
		cfg_names_hash = Hash.new
		i=0	
		while i< cfg_tb.length	
			cfg_list.push(cfg_tb[i])
			i+=2
		end
		cfg_list.each do |cfg_i|
			cfg_pros = cfg_i.find_elements(:tag_name,'td')
			puts "CFGName" + cfg_pros[1].text
			cfg_names_hash[cfg_pros[1].text.strip] = cfg_pros[1].find_element(:tag_name,'a')
		end
		
	end

	def click_syscfg(name)
		goto_system_config()
		goto_toc()
		cfg_tb = @driver.find_elements(:xpath,'/html/body/form/table[3]/tbody/tr/td/table/tbody/tr')
		cfg_tb_length = cfg_tb.length
		puts "len of cfg_tb" + cfg_tb.length.to_s
		cfg_list = Array.new
		cfg_names_hash = Hash.new
		i=0	
		while i< cfg_tb.length	
			cfg_list.push(cfg_tb[i])
			i+=2
		end
		cfg_list.each do |cfg_i|
			cfg_pros = cfg_i.find_elements(:tag_name,'td')
			puts "CFGName" + cfg_pros[1].text
			cfg_names_hash[cfg_pros[1].text.strip] = cfg_pros[1].find_element(:tag_name,'a')
		end
		cfg_names_hash[name].click
		goto_content()	
	end

	def modify_nas(nas_dest_name,method,*p)
        click_nas(nas_dest_name)
        modify_nas(method,p)

	end
    def click_nas(nas_dest_name)

		click_syscfg('NAS File Registration')
		nas_cfg_tb = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr')
        if nas_cfg_tb == nil
            return false
        end
        number_of_nas_cfg = nas_cfg_tb.length - 3
		puts "len of cfg_tb " + nas_cfg_tb.length.to_s
        if nas_cfg_tb.length <= 3
            puts "Empty NAS Reginster file"
        else 
            puts "Fine"
        end
		#remove the fist 2 and last 2 rows
        cfg_tb = nas_cfg_tb[2,number_of_nas_cfg]
        #Now table includes alll the files
        is_button_found = false
        cfg_tb.each do |nas|
            list = nas.find_elements(:tag_name,'td')
            if list[2].text == nas_dest_name
                if_button_found = true
                list[0].find_element(:tag_name,'a').click()
                break
            end
        end
        if is_button_found == true
            return true
        else 
            return false
        end
    end
    ###### Delete button is generic operation
	def delete()
        goto_content_header()
        @driver.find_element(:xpath,'/html/body/table/tbody/tr/td/table/tbody/tr/td[2]/a').click()
		a = @driver.switch_to.alert
		puts a.text
		#if alert.text == 'somegthing'  
		#	alert.dismiss
		#else  
		#	alert.accept
		#end
		a.accept

	end
    # click the specific item then delete it
	def del_nas(nas_dest_name)
        click_nas(nas_dest_name) do
            return false
        end
        delete do
            return true
        end
        return false

	end

    #modify_nas, 
    #internal use only
    #not public to user
    def modify_nas(method,p)

		goto_content_middle()
		selector = @driver.find_element(:xpath,'/html/body/form/table/tbody/tr/td/table/tbody/tr/td/table/tbody/tr[3]/td/table/tbody/tr/td[2]/select')
		options = selector.find_elements(:tag_name=>"option")
		options.each do |el|
    			if (el.text == method)
        			el.click
        			break
    			end
		end
		input_hash = Hash.new
		import_tb_node = @driver.find_element(:xpath,'/html/body/form/table/tbody/tr/td/table/tbody/tr/td/table/tbody')
		all_inputs = import_tb_node.find_elements(:tag_name,'input')
		all_inputs.each do |a|
			#a = el.find_element(:tag_name,'input')
			puts "input "+ a.attribute('type') + a.attribute('name')
			input_hash[a.attribute('name')] = a
		end
		p.each do |i|
			puts "Import variables:" + i
		end 
		i = 0;
		while i< p.length	
            #input_hash[p[i]].clear()
            if input_hash[p[i]].attribute('type') == 'text'
                #For text input, clear text first, otherwise, the input will be appended into text button.
                input_hash[p[i]].clear()
            end
			input_hash[p[i]].send_keys(p[i+1])
			i+=2
		end
		#OK, it's time to Upload or import
		#if method == 'Upload'
		#	#source_file_but = @driver.find_element(:xpath,'/html/body/form/table/tbody/tr/td/table/tbody/tr/td/table/tbody/tr[4]/td/table/tbody/tr/td[2]/input')
		#	#or
		#	source_file_but = @driver.find_element(:name,'uploadFile')
		#	puts "File path == "+ p[0]
		#	source_file_but.send_keys(p[0])
		#else method == 'Import'
		#	input_hash = Hash.new
		#	import_tb_node = @driver.find_element(:xpath,'/html/body/form/table/tbody/tr/td/table/tbody/tr/td/table/tbody')
		#	all_inputs = import_tb_node.find_elements(:tag_name,'input')
		#	all_inputs.each do |a|
		#		#a = el.find_element(:tag_name,'input')
		#		puts "input "+ a.attribute('type') + a.attribute('name')
		#		if a.attribute('type') == 'text'
		#			input_hash[a.attribute('name')] = a
		#		end
		#	end
		#	p.each do |i|
		#		puts "Import variables:" + i
		#	end 
		#	i = 0;
		#	while i< p.length	
		#		input_hash[p[i]].send_keys(p[i+1])
		#		i+=2
		#	end
		#end
		submit()
    end

	def create_nas(method,*p)
		click_syscfg('NAS File Registration')
        #Click create new button
		cfg_tb = @driver.find_elements(:xpath,'/html/body/form/table/tbody/tr/td/table/tbody/tr/td')
		cfg_tb_length = cfg_tb.length
		puts "len of cfg_tb " + cfg_tb.length.to_s
		create_button = cfg_tb[1].find_element(:tag_name,'a')
		create_button.click()
        modify_nas(method,p)
	end

	def submit
		goto_content_footer()
		@driver.find_element(:link,'Submit').click()
	end
	
	def get_ds(ds_name)
		goto_DS_page
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
			puts "DEBUG" + ds_pros[0].text.strip
			dslink_hash[ds_pros[0].text.strip] = mylink
			puts mylink.attribute('href')
		end
		#IE doesn't work for this click action
		#@driver.switch_to.default_content
		#@driver.switch_to.frame('body')
		if @browser_type == 'ie'
			dslink_hash[ds_name].send_keys("\n") 
		else
			
			dslink_hash[ds_name].click
		end
		goto_content_middle()
		names = @driver.find_elements(:tag_name,'input')
		#puts "Show tag input name within frame " + names.length().to_s
		names.each do |name| 
			#name.inspect
			#puts "input tage name is " + name.attribute('name')
		end
		goto_toc()
		@driver.find_element(:link,'General Settings').click()
		goto_content_middle()
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
		if @browser_tyep == 'ie'
			@driver.find_element(:link, 'Logout').send_keys("\n")
		else 
			@driver.find_element(:link, 'Logout').click()
		end
		#debug code, only one window when alert window popup
		#windows = @driver.window_handles
		#windows.each { |win| puts win}
		#frs = @driver.find_elements(:tag_name,'frame')
		#frs.each { |fr| puts fr}
		a = @driver.switch_to.alert
		puts a.text #false will be print out
		a.accept
	end

end

#!/usr/bin/ruby
require "rubygems"
require "selenium-webdriver"
class CDSMWebDriver

    attr_accessor :browser
    attr_reader :driver
    def initialize(browser,cap,cdsm_login_url)
        wb_url = "http://" + browser + ":4444" + "/wd/hub"
        if browser == 'localhost'
            @driver = Selenium::WebDriver.for(:firefox)
        else
            #http://code.google.com/p/selenium/wiki/DesiredCapabilities
            #profile = Selenium::WebDriver::Firefox::Profile.new
            #profile['webdriver.load.strategy'] = 'unstable'
            #profile.native_events = true
            #capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => profile)
            #@driver = Selenium::WebDriver.for(:remote,:url => wb_url,:desired_capabilities => capabilities)
            @driver = Selenium::WebDriver.for(:remote,:url => wb_url,:desired_capabilities => :"#{cap}")
        end
        @driver.manage.timeouts.implicit_wait = 3
        @cdsm_url = cdsm_login_url
        #TODO verify cdsm login url
        puts @cdsm_url
        @browser_type = cap
        @verbose = false
    end

    def teardown
        @driver.quit
    end
    def verbose= (v)
        @verbose = v
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
        begin
            a = @driver.switch_to.alert
            puts a.text
            a.accept
        rescue Selenium::WebDriver::Error::NoAlertPresentError => e
        end     

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
        goto_system('Configuration')
    end
    def goto_DS_page
        goto_nav()
        @driver.find_element(:link,'Services').click()
        @driver.find_element(:link,'Delivery Services').click()
        goto_body()
    end
    def goto_devices_dg
        goto_nav()
        @driver.find_element(:link,'Devices').click()
        @driver.find_element(:link,'Device Groups').click()
        goto_body()
    end
    def goto_live_prog
        goto_nav()
        @driver.find_element(:link,'Services').click()
        @driver.find_element(:link,'Live Video').click()
        @driver.find_element(:link,'Live Programs').click()
        goto_body()
    end

    def click_co(co_name)
        goto_CO_page
        colink_hash = Hash.new
        co_list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr')
        co_list_length = co_list.length
        #remove the fist 2 and last 2 rows
        co_list = co_list[2,co_list_length-4]
        #puts "Length of table " + co_list.length.to_s
        co_list.each do |co_tr|
            co_pros = co_tr.find_elements(:tag_name,'td')
            mylink = co_pros[0].find_element(:tag_name,'a')
            #Selenium has changed the &nbsp; to space char
            #name = co_pros[0].text.scan(/&nbsp;&nbsp;(\S+)&nbsp;/).flatten[0]
            name = co_pros[0].text.strip
            puts "CO name: " + name
            colink_hash[name] = mylink
        end
        puts "click the Content Origin " + co_name
        colink_hash[co_name].click
        true
    end
    def click_prog(prog_name)
        goto_live_prog
        links = Hash.new
        list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr')
        list_len = list.length
        #remove the fist 2 and last 2 rows
        list = list[2,list_len-4]
        list.each do |tr|
            tds = tr.find_elements(:tag_name,'td')
            mylink = tds[0].find_element(:tag_name,'a')
            #Selenium has changed the &nbsp; to space char
            name = tds[0].text.strip
            puts "Name: " + name
            links[name] = mylink
        end
        puts "click the Program " + prog_name
        links[prog_name].click
        true
    end
    def click_devices_dg(dg_name)
        goto_devices_dg
        links = Hash.new
        list = @driver.find_elements(:xpath,'/html/body/form/table[3]/tbody/tr')
        list_len = list.length
        puts "len of list: " + list_len.to_s
        list.each do |tr|
            tds = tr.find_elements(:tag_name,'td')
            mylink = tds[0].find_element(:tag_name,'a')
            #Selenium has changed the &nbsp; to space char
            name = tds[0].text.strip
            puts "Name: " + name
            links[name] = mylink
        end
        puts "click the Program " + dg_name
        links[dg_name].click
        true
    end
    def modify_co(co_name,*p)
        click_co(co_name)
        modify_page(*p)
    end
    def modify_ds(ds_name,submenu,*p)
        click_ds(ds_name)
        click_toc_submenu(submenu)
        modify_page(*p)
    end
    def create_co(*p)
        goto_CO_page
        click_create_button()
        modify_page(*p)
    end
    def create_ds(*p)
        goto_DS_page
        click_create_button()
        modify_page(*p)
    end
    def create_program(*p)
        goto_live_prog
        click_create_button()
        modify_page(*p)
    end
    def create_dg(*p)
        goto_devices_dg
        click_create_button()
        modify_page(*p)
    end
    def modify_program(prog_name,submenu,*p)
        click_prog(prog_name)
        click_toc_submenu(submenu)
        modify_page(*p)
    end

    def get_program(prog_name,submenu,*p)
        click_prog(prog_name)
        click_toc_submenu(submenu)
        goto_content_middle
        show_input_option if @verbose
        #FIXME: when p is empty, still enter while loop
        show_elements(*p) if p.length > 0

    end

    def get_co(co_name,submenu,*p)
        click_co(co_name)
        click_toc_submenu(submenu)
        goto_content_middle
        show_input_option if @verbose
        #FIXME: when p is empty, still enter while loop
        show_elements(*p) if p.length > 0

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
            puts "CONAME=" + co_pros[0].text.strip + "RFQDN=" + co_pros[1].text + "OFQDN=" + co_pros[2].text
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

    def modify_nas(nas_dest_name,*p)
        click_nas(nas_dest_name)
        modify_page(*p)
        #modify_nas_internal(method,p)

    end
    def click_nas(nas_dest_name)

        puts "Clicking NAS with name : " + nas_dest_name
        click_syscfg('NAS File Registration')
        nas_cfg_tb = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr/td/table/tbody/tr/td/table/tbody/tr')
        if nas_cfg_tb == nil
            return false
        end
        number_of_nas_cfg = nas_cfg_tb.length - 3
        puts "Length of Table: " + nas_cfg_tb.length.to_s
        if nas_cfg_tb.length <= 3
            puts "Empty NAS Reginster file"
        else 
        end
        #remove the fist 2 and last 2 rows
        cfg_tb = nas_cfg_tb[2,number_of_nas_cfg]
        #Now table includes alll the files
        is_button_found = false
        cfg_tb.each do |nas|
            list = nas.find_elements(:tag_name,'td')
            puts "Name in the table: " + list[2].text.strip
            if list[2].text.strip == nas_dest_name
                is_button_found = true
                list[0].find_element(:tag_name,'a').click()
                break
            end
        end
        if is_button_found == true
            puts "NAS Found and clicked"
            return true
        else 
            return false
        end
    end
    ###### Delete button is generic operation
    def delete()
        goto_content_header()
        del_button = @driver.find_element(:xpath,'/html/body/table/tbody/tr/td/table/tbody/tr/td[2]/a')
        #@driver.action.move_to(del_button).perform
        if @browser_type == 'firefox'
            @driver.manage.timeouts.page_load = 3
            @driver.manage.timeouts.script_timeout = 2
        end
        begin
            del_button.click()
        rescue Selenium::WebDriver::Error::ScriptTimeOutError => e
        #rescue Selenium::WebDriver::Error::TimeOutError => e
        #rescue Timeout::Error => e
        end
        #@driver.find_element(:xpath,'/html/body/table/tbody/tr/td/table/tbody/tr/td[2]/a').send_keys("\n")
        #@driver.execute_script('localDelete(\'object\')')
        windows = @driver.window_handles
        windows.each { |win| puts win}
        #frs = @driver.find_elements(:tag_name,'frame')
        #frs.each { |fr| puts fr}
        begin
            puts 'Switching to alert'
            a = @driver.switch_to.alert
            #puts a.text
            a.accept
        rescue Selenium::WebDriver::Error::NoAlertPresentError => e
        end
        true

    end
    # click the specific item then delete it
    def del_nas(nas_dest_name)
        click_nas(nas_dest_name) do
            return false
        end
        delete() do
            return true
        end
        return false

    end
    def del_co(co_name)
        click_co(co_name) do
            return false
        end
        delete() do
            return true
        end
        return false

    end
    def del_ds(ds_name)
        click_ds(ds_name) do
            return false
        end
        delete do
            return true
        end
        return false

    end
    def del_program(prog_name)
        click_prog(prog_name) do
            return false
        end
        delete do
            return true
        end
        return false

    end
    def del_dg(dg_name)
        click_devices_dg(dg_name) do
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
    def modify_nas_internal(method,p)

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
        submit()
    end
    def click_create_button()
        #Click create new button
        cfg_tb = @driver.find_elements(:xpath,'/html/body/form/table/tbody/tr/td/table/tbody/tr/td')
        cfg_tb_length = cfg_tb.length
        puts "len of cfg_tb " + cfg_tb.length.to_s
        create_button = cfg_tb[1].find_element(:tag_name,'a')
        create_button.click()
    end

    def create_nas(*p)
        click_syscfg('NAS File Registration')
        click_create_button()
        #goto_content_middle 
        #el = @driver.find_element(:name,p[0])
        #options = el.find_elements(:tag_name,'option')
        #options.each do |el|
        #    if (el.text == p[1])
        #        el.click
        #        break
        #    end
        #end
        modify_page(*p)
        #modify_nas_internal(method,p)
    end

    def submit
        goto_content_footer()
        @driver.find_element(:link,'Submit').click()
        begin
            a = @driver.switch_to.alert
            puts a.text
            a.accept
        rescue Selenium::WebDriver::Error::NoAlertPresentError => e
        end
    end
    def click_ds(ds_name)
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
        true
    end
    def show_input_option
        inputs = @driver.find_elements(:tag_name,'input')
        inputs.each do |name| 
            if name.attribute('type') != 'hidden'
                puts "---Input tag name : " + name.attribute('name') + " type: " + name.attribute('type') 
            else
            end
        end
        selects = @driver.find_elements(:tag_name,'select')
        selects.each do |el|
            options = el.find_elements(:tag_name,'option')
            puts "---Select Option Name: " + el.attribute('name')
            options.each do |name|
                #puts "---\t Option Selected: " + name.text if name.attribute('selected')
                #puts "---\t Option Value: " + name.attribute('value') + " Text: " + name.text
                puts "---\t Option Value: " + " Text: " + name.text
            end
        end
    end
    def click_toc_submenu(menu_name)
        goto_toc()
        @driver.find_element(:link,menu_name).click()
    end
    def show_elements(*p)
        i = 0;
        while i< p.length	
            el = @driver.find_element(:name,p[i])
            if el.attribute('type') == 'text'
                puts p[i] + "Value: " + el.attribute('value')
            elsif el.find_elements(:tag_name,'option')
                options = el.find_elements(:tag_name,'option')
                options.each do |el|
                    puts "Option selected" + el.text if el.attribute('selected')
                end
            elsif el.attribute('type') == 'checkbox'
                puts "Checkbox value : " + el.attribute('value')
            end
            i+=1
        end
    end
    def assign_se(ds_name,acq,*se)
        click_ds(ds_name)
        click_toc_submenu('Assign Service Engines')
        goto_content_middle()
        link_hash = Hash.new
        se_list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr')
        se_list_length = se_list.length
        #remove the fist 1
        se_list = se_list[1,se_list_length-1]
        se_list.each do |tr|
            tr_pros = tr.find_elements(:tag_name,'td')
            puts "------- Show One Row SE -----"
            puts " Col1 " + tr_pros[0].text + " Col2 " + tr_pros[1].text + " Col3 " + tr_pros[2].text + " Col4 " + tr_pros[3].text + " Col5 " + tr_pros[4].text
            mylink = tr_pros[0].find_element(:tag_name,'a')
            puts "DEBUG" + tr_pros[0].text.strip
            link_hash[tr_pros[0].text.strip] = mylink
            puts mylink.attribute('href')
        end
        #Toggle them
        se.each do |el|
            link_hash[el].click
        end
        #choose acq
        #
        @driver.switch_to.frame('rootCe')

        selector= @driver.find_element(:tag_name,'select')
        options = selector.find_elements(:tag_name,'option')
        if options.length > 1
            options.each do |el|
                if (el.text == acq)
                    el.click
                    break
                end
            end
        end
        submit()


    end
    def assign_dg(dg_name,*se)
        click_devices_dg(dg_name)
        click_toc_submenu('Assignments')
        click_toc_submenu('Devices')
        goto_content_middle()
        link_hash = Hash.new
        se_list = @driver.find_elements(:xpath,'/html/body/form/table[2]/tbody/tr')
        se_list_length = se_list.length
        #remove the fist 1
        se_list = se_list[1,se_list_length-1]
        se_list.each do |tr|
            tr_pros = tr.find_elements(:tag_name,'td')
            puts "------- Show One Row SE -----"
            puts " Col1 " + tr_pros[0].text + " Col2 " + tr_pros[1].text + " Col3 " + tr_pros[2].text + " Col4 " + tr_pros[3].text + " Col5 " + tr_pros[4].text
            mylink = tr_pros[0].find_element(:tag_name,'a')
            puts "DEBUG" + tr_pros[0].text.strip
            link_hash[tr_pros[0].text.strip] = mylink
            puts mylink.attribute('href')
        end
        #Toggle them
        se.each do |el|
            link_hash[el].click
        end
        submit()

    end

    def get_ds(ds_name,submenu,*p)
        click_ds(ds_name)
        click_toc_submenu(submenu)
        goto_content_middle()
        show_input_option if @verbose
        show_elements(*p)
    end
    def get_nas(nas_name,*p)
        click_nas(nas_name)
        goto_content_middle()
        show_input_option if @verbose
    end

    #TODO: Be able to set all in the same func
    # as i know, there are 6 kinds of 'input', 1) input,type=text, 2) select, option 3)input, type=checkbox 4)textarea
    # 5) input, type=hidden 6) radio button
    # idealy the parameters look like: name,key-1, val-1,key-2,val-2
    # if it's check box, val should be 0,1
    # if it's option and text, val should be the extra text
    # ignore hidden ones
    #
    #
    #
    ##modify_page: Modify Delivery Service Page
    # Key1,value1,Key2,value2
    def modify_page(*p)
        goto_content_middle()
        show_input_option if @verbose
        if p.length <= 1
            return false
        end
        p.each do |i|
            puts "Input Parameters:" + i
        end 
        i = 0;
        while i< p.length	
            el = @driver.find_element(:name,p[i])
            if el.attribute('type') == 'text'
                el.clear()
                el.send_keys(p[i+1])
            elsif el.attribute('type') == 'file'
                el.send_keys(p[i+1])
            elsif (el.find_elements(:tag_name,'option')).length > 0
                puts "Type Options"
                options = el.find_elements(:tag_name,'option')
                options.each do |el|
                    if (el.text == p[i+1])
                        el.click
                        break
                    end
                end
                goto_content_middle 
            elsif el.attribute('type') == 'checkbox'
                puts "Type Checkbox"
                if p[i+1] == '1'
                    #el.check
                    el.click
                else 
                    #el.uncheck
                    puts "FIXME uncheck "
                end
                goto_content_middle 
            elsif el.attribute('type') == 'radio'
                puts "Type Radio"
                locate_radio_item(p[i],p[i+1])
            else 
                puts "Unexpected Type" + el.attribute('type')
            end
            i+=2
        end
        show_input_option if @verbose
        submit()
    end

    def locate_radio_item(radio_name,index)
        puts "DEBUG" + radio_name + "index " + index
        radios = @driver.find_elements(:name,radio_name)
        i = index.to_i
        radios[i].click if i >= 0
        goto_content_middle 
    end

    def logout()

        puts "start to logout"
        goto_nav()
        if @browser_type == 'ie'
            @driver.find_element(:link, 'Logout').send_keys("\n")
        else 
            @driver.find_element(:link, 'Logout').click()
        end
        begin
            a = @driver.switch_to.alert
            puts a.text
            a.accept
        rescue Selenium::WebDriver::Error::NoAlertPresentError => e
        end     
        #debug code, only one window when alert window popup
        #windows = @driver.window_handles
        #windows.each { |win| puts win}
        #frs = @driver.find_elements(:tag_name,'frame')
        #frs.each { |fr| puts fr}
    end
end


#!/usr/bin/ruby
require "rubygems"
require "selenium-webdriver"
wb_url = "http://" + "172.22.28.97" + ":4444" + "/wd/hub"
#driver = Selenium::WebDriver.for(:remote,:url => wb_url,:desired_capabilities => :firefox)
driver = Selenium::WebDriver.for :firefox
#driver = Selenium::WebDriver.for(:remote,:url => wb_url,:desired_capabilities => :ie)
driver.manage.timeouts.implicit_wait = 10
driver.navigate.to("http://172.29.99.212:8080")
uname = driver.find_element(:id,'label_username');
uname.send_keys 'root'

pass = driver.find_element(:id,'label_password');
pass.send_keys 'Public123'
login = driver.find_element(:id,'loginPage_loginSubmit');
login.click

#http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/WebDriver/Window.html
max_width, max_height = driver.execute_script("return [window.screen.availWidth, window.screen.availHeight];")
driver.manage.window.resize_to(max_width, max_height)

puts "window size" + max_height.to_s + "width " + max_width.to_s
menu_home= driver.find_element(:id,'wcsuishell_node_id_menu_home');
menu_home.click
menu_service= driver.find_element(:id,'wcsuishell_node_id_menu_configure');
menu_service.click

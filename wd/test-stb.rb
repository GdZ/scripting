require 'rubygems'
require "selenium-webdriver"
require "json"
require 'net/http'
target = "http://171.71.47.71:9517"
#target = "http://171.71.47.34:9517"
uri = URI.parse(target)
http = Net::HTTP.new(uri.host,uri.port)
request = Net::HTTP::Get.new("/sessions")
resp = http.request(request)
sessions = JSON.parse(resp.body)
#puts sessions['value'].first['id']
if sessions['value'].length > 0 
   then 
   session_id = sessions['value'].first['id']
   delrequest = Net::HTTP::Delete.new("/session/"+session_id)
   resp = http.request(delrequest)
else
   # do nothing 
end
#Now going to delete the session. 

caps = Selenium::WebDriver::Remote::Capabilities.chrome

caps['browserStartWindow'] =  '*'

# Qt on STB
# Qt on PC
# ghost driver
#driver = Selenium::WebDriver.for(:remote,:url=> target)
driver = Selenium::WebDriver.for(:remote,:url=> target,:desired_capabilities => caps)
#Not working

#Doesn't help
#driver.execute_script('window.location.reload(true)')

# Chrome on PC
#driver = Selenium::WebDriver.for(:remote,:url=> "http://171.71.47.34:4444/wd/hub",:desired_capabilities => :chrome)

driver.navigate.to "http://171.71.46.197/TNC/TNCTestSuite/TncRunner.html"
#driver.navigate.refresh
#driver.manage.window.maximize()
#driver.navigate.to "http://www.w3.org/2010/05/video/mediaevents.html"
#ref: http://blog.jphpsf.com/2012/10/31/running-Jasmine-tests-with-Phantom-js-or-Webdriver
#status  = driver.execute_script('return consoleReporter.status;')
#begin
#   sleep 1
#   #puts "waiting 1 sec" 
#   puts driver.execute_script('return consoleReporter.status;')
#end while driver.execute_script('return consoleReporter.status;') == "running"
##puts driver.execute_script('return consoleReporter.getLogsAsString();')

#query the status of reporter
begin
   sleep 1
   #puts driver.execute_script('return tapReporter.finished;')
end while ! driver.execute_script('return tapReporter.finished;')
output =  driver.execute_script('return tapReporter.getLogsAsString();')
# "'" is not recoginzed correctly by TAP plugin. So workaround is to remove "'"
output = output.tr("\'", " ");
# sceenshopt is not working on latest build. 
#driver.save_screenshot("./stb.png")
#print the TAP report, or we can export it to Jenkins server. 
puts output
#driver.navigate.to "http://www.google.com"
#driver.quit










#------------------------------------------------------------------------------------------------
#http://www.rubyinside.com/nethttp-cheat-sheet-2940.html
#https://code.google.com/p/selenium/wiki/JsonWireProtocol

#http://stackoverflow.com/questions/15699900/compound-class-names-are-not-supported-error-in-webdriver
# option#1
#element = driver.find_element(:css => "span[class='failingAlert bar']")
# option#2
#element = driver.find_element(:css => ".failingAlert.bar")

# classname including space is NOT working !
#element = driver.find_element(:class => ".failingAlert.bar")
#
#begin
#   element = driver.find_element(:css => ".passingAlert.bar")
#rescue Selenium::WebDriver::Error::NoSuchElementError  => e
#end
#
#if element
#   puts element.text
#else 
#   puts "no passing element found"
#   begin
#      element = driver.find_element(:css => ".failingAlert.bar")
#   rescue Selenium::WebDriver::Error::NoSuchElementError  => e
#   end
#   if element
#   puts element.text
#   end
#end
##driver.switch_to.default_content

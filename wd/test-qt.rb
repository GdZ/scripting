require 'rubygems'
require "selenium-webdriver"
require "json"
require 'net/http'
#page = "http://www.w3.org/2010/05/video/mediaevents.html"
page = "http://171.71.46.197/TNC/TNCTestSuite/jm.html"
target = "http://171.71.47.34:9517"
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
caps['loggingPref'] =  { "client" => "ALL","driver" => "ALL"}

driver = Selenium::WebDriver.for(:remote,:url=> target,:desired_capabilities => caps)

# Chrome on PC
#driver = Selenium::WebDriver.for(:remote,:url=> "http://171.71.47.34:4444/wd/hub",:desired_capabilities => :chrome)

#driver.navigate.to "http://171.71.46.197/TNC/TNCTestSuite/TncRunner.html"
driver.navigate.to page 
driver.navigate.refresh
sleep 5
driver.save_screenshot("./stb.png")
#driver.quit


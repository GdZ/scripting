require "selenium-webdriver"

#driver = Selenium::WebDriver.for(:remote,:url=> "http://171.71.47.71:9517")
driver = Selenium::WebDriver.for(:remote,:url=> "http://171.71.47.34:9517")
#driver = Selenium::WebDriver.for(:remote,:url=> "http://171.71.47.34:4444/wd/hub")
driver.navigate.to "http://ciscospeaks-lnx.cisco.com/appstore/webapps/app-bsa/app/2/index.html#menu"
sleep 5
begin
   element = driver.find_element(:name => "STORE")
rescue Selenium::WebDriver::Error::NoSuchElementError  => e
   puts e
end
puts element.text
begin
   element = driver.find_element(:id=> "title")
rescue Selenium::WebDriver::Error::NoSuchElementError  => e
   puts e
end
puts element.text

driver.action.send_keys(:arrow_right).perform
driver.action.send_keys(:enter).perform
#driver.switch_to.default_content
begin
   element = driver.find_element(:id=> "title")
rescue Selenium::WebDriver::Error::NoSuchElementError  => e
   puts e
end
#element.send_keys "\n" 
   puts element.text
driver.quit

require "selenium-webdriver"
driver = Selenium::WebDriver.for(:firefox, :profile => "NDS")
url = "https://ciscovpn.nds.com"
driver.navigate.to url
begin
   cont_session = driver.find_element(:name,'btnContinue')
   cont_session.click()
rescue Selenium::WebDriver::Error::NoSuchElementError => e
end
sleep 2
driver.switch_to.default_content
sleep 1
start = driver.find_element(:name,'btnNCStart')
start.click()
puts Time.now.utc
sleep 10
interfaces = `ifconfig`
puts interfaces
while true
   #64800=18 hours, 10 min = 600s
   #
   sleep 64260
   begin
      a = driver.switch_to.alert
      puts a.text
      a.accept
   rescue Selenium::WebDriver::Error::NoAlertPresentError => e
   end     

end

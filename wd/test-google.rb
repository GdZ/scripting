require "selenium-webdriver"
caps = Selenium::WebDriver::Remote::Capabilities.phantomjs
caps['browserName'] =  "phantomjs"
driver = Selenium::WebDriver.for(:remote,:url=> "http://171.71.46.197:9517",:desired_capabilities => caps)
driver.navigate.to "http://google.com"
element = driver.find_element(:name, 'q')
element.send_keys "Hello WebDriver!"
element.submit
puts driver.title
driver.quit

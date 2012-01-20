#!/usr/bin/ruby
require "rubygems"
require "selenium-webdriver"
driver = Selenium::WebDriver.for(:android)
driver.navigate.to("http://www.google.com")
w2 = driver.find_element(:id, 'w2')             # get a reference to an Element
driver.execute_script("d=new Date();return(d.valueOf());")              # very useful
driver.wait.until { w2.displayed? }
driver.quit()

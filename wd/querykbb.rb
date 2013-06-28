require 'rubygems'
require "selenium-webdriver"
caps = Selenium::WebDriver::Remote::Capabilities.phantomjs
caps['browserName'] =  "phantomjs"
#Ghostdriver would be crash at this time. 
driver = Selenium::WebDriver.for(:remote,:url=> "http://171.71.47.34:9517",:desired_capabilities => caps)
#driver = Selenium::WebDriver.for :firefox

#Chrome
#driver = Selenium::WebDriver.for(:remote,:url=> "http://171.71.47.34:4444/wd/hub",:desired_capabilities => :chrome)
driver.manage.timeouts.implicit_wait = 3
url = "http://www.kbb.com/used-cars/"
myyear = '2001'
driver.navigate.to url
#if not set to max window, WD would be crashed in the step of click the href link. 
driver.manage.window.maximize()
nocpo = driver.find_element(:id,'buy-known-uc-nocpo')
select_year = nocpo.find_element(:name,'yearid')
options = select_year.find_elements(:tag_name,"option")
options.each do |el|
    puts el.text
    if (el.attribute('value') == myyear) 
        #el.select()
        el.click()
        break
    end
end
sleep 2
mymaker = 'Honda'
select_maker = nocpo.find_element(:name,'manufacturername')
options = select_maker.find_elements(:tag_name,"option")
options.each do |el|
puts el.text
end

options.each do |el|
    if (el.attribute('value') == mymaker)
        el.click()
        break
    end
end

mymodel = 'Civic'
select_model = nocpo.find_element(:name,'modelname')
options = select_model.find_elements(:tag_name,"option")
options.each do |el|
puts el.text
end

options.each do |el|
    if (el.attribute('value') == mymodel)
        el.click()
        break
    end
end
sleep 1
gogo = nocpo.find_element(:id, 'ymm-submit')
gogo.click()
sleep(3)
driver.switch_to.default_content
frames = driver.find_elements(:tag_name,'iframe')
frames.each do |each_frame|
puts each_frame.inspect
end
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
wait.until {
  driver.execute_script("return document.readyState;") == "complete" 
}
puts "ready"
driver.save_screenshot("./screen.png")
zipcodeinput = driver.find_element(:name,'selectedZipCode')
zipcodeinput.send_keys('95131')
zipsubmit = driver.find_element(:id,'enterzipsubmit')
puts "now input zipcode"
zipsubmit.click()
sleep(2)
#driver.switch_to.default_content
sleep(2)
driver.find_element(:css,'a[href="/honda/civic/2001-honda-civic/styles/?intent=buy-used&bodystyle=sedan"]').click()
tmp = driver.find_element(:css => "div[class='vehicle-styles-container clear row-white ']")
tmp.find_element(:css,'a[href="/honda/civic/2001-honda-civic/ex-sedan-4d/options/?vehicleid=4411&intent=buy-used&category=sedan&pricetype=&path=&filter="]').click()
sleep(2)
driver.find_element(:id,'GetMyPrice').click()
driver.find_element(:id,'Price-type-private-party').click()
driver.find_element(:css,'a[href="/honda/civic/2001-honda-civic/ex-sedan-4d/?condition=very-good&vehicleid=4411&intent=buy-used&category=sedan&pricetype=retail"]').click()

# print something
driver.save_screenshot("./screen2.png")
driver.quit

from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.common.keys import Keys
#from time

browser = webdriver.Firefox() # Get local session of firefox
browser.get("https://18.0.101.46:8443/servlet/com.cisco.unicorn.ui.LoginServlet") # Load page
assert browser.title == "CDSM"
elem = browser.find_element_by_name("username") # 
elem.send_keys("admin")

elem = browser.find_element_by_name("password") # 

elem.send_keys("default")

elem = browser.find_element_by_link("Login") # 
elem.click()
time.sleep(0.2) # Let the page load, will be added to the API
alert = browser.swith_to_alert()
alert.accept()
try:
	browser.find_element_by_xpath("//a[contains(@href,'http://seleniumhq.org')]")
except NoSuchElementException:
	assert 0, "can't find seleniumhq"
	browser.close()

require "rubygems"
require "selenium-webdriver"
class FMSClientWebDriver

	attr_accessor :clientip
	attr_reader :driver
	def initialize(clientip)

		wb_url = "http://" + clientip + ":4444" + "/wd/hub"
		@driver = Selenium::WebDriver.for(:remote,:url => wb_url)

	end

	def teardown
		@driver.quit
	end
	def open(url)

		@driver.navigate.to 'http://12.0.0.25/myFMSPlayer.html'
		url_text = @driver.find_element(:name, 'sendField')
		url_text.clear()
		url_text.send_keys url
		@driver.find_element(:xpath,'//input[@value="Start"]').click()

	end
	def get_result()

		result_text = @driver.find_element(:name, 'PlayerResult')
		puts result_text.attribute('value')
	end

	def get_status()

		result_text = @driver.find_element(:name, 'statusinfo')
		puts result_text.attribute('value')
	end

end
flashclient1 = FMSClientWebDriver.new('10.74.61.148')
flashclient2 = FMSClientWebDriver.new('12.0.0.27')
flashclient1.open('rtmp://10.74.61.77/vod/sample')
flashclient2.open('rtmp://10.74.61.77/vod/sample')
sleep(5)
flashclient1.get_result()
flashclient1.get_status()
flashclient1.teardown

flashclient2.get_result()
flashclient2.get_status()
flashclient2.teardown

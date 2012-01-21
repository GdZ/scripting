#!/usr/bin/ruby
require "rubygems"
require "selenium-webdriver"
#driver = Selenium::WebDriver.for(:android)
wb_url = "http://" + "10.74.61.148" + ":4444" + "/wd/hub"
driver = Selenium::WebDriver.for(:remote,:url => wb_url)

driver.manage.timeouts.implicit_wait = 10
#driver.navigate.to("http://172.22.30.14/html5video/demo.html")
driver.navigate.to("http://172.22.30.14/testplayer/index.html")
url_text = driver.find_element(:id,"lib_single_url");
url_text.send_keys "http://video-js.zencoder.com/oceans-clip.mp4"

add_single = driver.find_element(:id,"lib_add_single");
add_single.click

item_select = driver.find_element(:id=> "lib_box")
options = item_select.find_elements(:tag_name=>"option")
options.each do |el|
    if (el.text == "http://video-js.zencoder.com/oceans-clip.mp4") 
        el.click
        break
    end
end
player_select = driver.find_element(:id=> "settings_player")
options = player_select.find_elements(:tag_name=>"option")
options.each do |el|
    if (el.text == "HTMP5") 
        el.select()
        break
    end
end
lib_add = driver.find_element(:id,"lib_add");
lib_add.click

#play_button = driver.find_element(:css,".vjs-big-play-button:first-child");
#w2 = driver.find_element(:id, 'w2')             # get a reference to an Element
#driver.execute_script("d=new Date();return(d.valueOf());")              # very useful
#driver.wait.until { w2.displayed? }

sleep(5)
driver.quit()

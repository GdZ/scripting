=begin
    
    This env.rb will use capybara-mechanize by default and capybara's normal selenium 2 (webdriver) driver for
    cucumber tests tagged with @javascript.
    
    It also helps you pass your tests on to a selenium 2 grid, with some extra bits specifically for SauceLabs
    (which it uses as a remote selenium 2 grid).

    
    Environment variables you can set:

    MHT_HOST=domain.com ... the host to test, default is WWW.YOURDOMAIN.COM
    MHT_DRIVER='rack_test' ... default capybara driver to use, valid values are:
        chrome,
        culerity,
        selenium,
        rack_test,
        Poltergeist
    [HERRY] when using Cucuber, you may consider leaving rack_test as the default driver and marking only those tests that require 
            a js-capabale driver using :js => true or @javascript respectively. By default js tests are run using the :selenium driver.
    [HERRY] if your app is not a Rack app, you cann't user rack_test driver. You can't use racktest driver to test a remote application.
    MHT_JAVASCRIPT_DRIVER='selenium' ... javascript capybara driver to use, valid values are:
        selenium [selenium server]
        webkit [uses headless webkit]
        webdriver [remote webdriver, aka Sauce Labs]
    MHT_WAIT_TIME=6 ... the number of seconds to wait for things to load
    MHT_OS='ANY' ... OS to use for remote webdriver, valid values are:
        ANDROID
        ANY
        LINUX
        MAC
        UNIX
        VISTA
        WINDOWS
        XP
    MHT_BROWSER=browser_name ... the browser driver to use, default is firefox, valid values are:
        firefox
        iexplore
        chrome
        android
    MHT_BROWSER_VERSION='5' ... browser version to use for remote webdriver, defaults to '5'
        (nb, if you specify something other than MHT_BROWSER='firefox' you will want to set this too!)
    MHT_REMOTE_WEBDRIVER=false ... URL of the remote webdriver hub, valid values are:
        false
        http://wd.com:80/wd/hub

    You have 3 options for setting environment variables (higher numbers below take precedence):
        1. System level (i.e. in "Computer -> Properties" on Windows, or in the terminal in Linux/OS X)
        2. Config level (i.e. by setting up a profile in cucumber.yml)
        3. Run level (i.e. by running "$ cucumber MHT_BROWSER=chrome")
=end



########### Global Requirements

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'selenium-webdriver'




########### Get Configuration

config = {
    'mht_host'              => ENV['MHT_HOST']              || 'WWW.YOURDOMAIN.COM',
    'mht_driver'            => ENV['MHT_DRIVER']            || 'chrome',
    'mht_javascript_driver' => ENV['MHT_JAVASCRIPT_DRIVER'] || 'selenium',
    'mht_wait_time'         => ENV['MHT_WAIT_TIME']         || 6,
    'mht_os'                => ENV['MHT_OS']                || 'ANY',
    'mht_browser'           => ENV['MHT_BROWSER']           || 'chrome',
    'mht_browser_version'   => ENV['MHT_BROWSER_VERSION']   || '5',
    'mht_remote_webdriver'  => ENV['MHT_REMOTE_WEBDRIVER']  || 'http://127.0.0.1:4444/wd/hub'
}




########### Configure Capybara

# Create a "chrome" driver
Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
# Use the "chrome" driver if we specified "chrome" through the browser name
if ( config['mht_browser'] == 'chrome' && config['mht_driver'] == 'selenium' ) then
    config['mht_driver'] = 'chrome'
end

if ( config['mht_javascript_driver'] == 'webkit' )
    require 'capybara-webkit'
end

if config['mht_remote_webdriver'] then
    Capybara.register_driver :webdriver do |app|
        remote_url = config['mht_remote_webdriver']
        ## create the options for the new Remote Capabilities object
        capabilities_opts = {
            :platform => config['mht_os'],
            :version => config['mht_browser_version'],
            :javascript_enabled => true,
            :css_selectors_enabled => true,
        }
        capabilities_opts[:browser_name] = config['mht_browser'] if config['mht_browser']
        capabilities_opts[:version] = config['mht_browser_version'] if config['mht_browser_version']
        # make the new Remote Capabilities object
        capabilities = Selenium::WebDriver::Remote::Capabilities.new(capabilities_opts)

        ## make the actual client
        client = Selenium::WebDriver::Remote::Http::Default.new

        ## make the opts for the new driver
        opts = {
            :url => remote_url,
            :desired_capabilities => capabilities,
            :http_client => client,
            :browser => :remote
        }

        ## make the new driver
        Capybara::Selenium::Driver.new(app,opts)
    end
end


Capybara.app_host = 'http://' + config['mht_host']

#puts config['mht_remote_webdriver']
if config['mht_remote_webdriver']  == 'http://127.0.0.1:4444/wd/hub' then
   #puts config['mht_driver']
   Capybara.default_driver = config['mht_driver'].to_sym
else 
   Capybara.default_driver = :webdriver
end
Capybara.javascript_driver = config['mht_javascript_driver'].to_sym
Capybara.default_wait_time = config['mht_wait_time']





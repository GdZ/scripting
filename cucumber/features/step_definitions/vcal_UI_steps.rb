

Capybara.add_selector(:element) do
  xpath { |locator| "//*[normalize-space(text())=#{XPath::Expression::StringLiteral.new(locator)}]" }
end

Given /^I am login$/ do
  visit('/users/hailwang/WebClient/Videoscape/login.html')
  fill_in('username',:with => 't6@cisco.com')
  fill_in('password',:with => 'cisco123')
  click_button('submit')
end

When /^I enter "([^"]*)"$/ do |term|
  fill_in('q',:with => term)
end
When /^I click others$/ do
   #click_button('ON NOW')
   #click_on('ON NOW')
   #click_button('nav-onnow')

end
When 'I click "$locator"' do |locator|
  msg = "No element found with the content of '#{locator}'"
  find(:element, locator, :message => msg).click
end

Then 'I should see channel $ch_num' do |ch_num|
  page.should have_xpath("//*[@id=\"listing-content\"]/div[#{ch_num}]/span[2]")
end

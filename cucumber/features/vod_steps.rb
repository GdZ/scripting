Before do
   puts "Before any test"
end
After do
   puts "After all tests"
end

Given /^I am Product detail page$/ do
     puts "Given "
     # express the regexp above with the code you wish you had
end

When /^I click botton 'play'$/ do
     puts "click play"
     @action = 'play'
     @status = "playing"
     # express the regexp above with the code you wish you had
end

Then /^I should see$/ do |string|
     #puts "str " + string 
     #puts "others"
     @status.should === string
     # express the regexp above with the code you wish you had
end

at_exit do
   puts "after all"
end

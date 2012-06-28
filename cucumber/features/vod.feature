

Feature: vod

Scenario: click play get status playing 

Given I am Product detail page
When I click botton 'play'
Then I should see
"""
playing
"""


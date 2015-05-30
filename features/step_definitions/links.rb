# -*- coding: UTF-8 -*-
Then(/^I (should|shouldn't) see link to "([^"]*)"$/) do |action, link|
	result = (action == "should")
	link = link.gsub('__SERVOR__', SERVOR)
	expect(@browser.link(href: /#{link}/).exists?).to equal(result)
end


Then(/^I should see link "([^"]*)"$/) do |text|
	@browser.link(text: text).visible?
end


When(/^I follow link "([^"]*)"$/) do |text|
	begin
		@browser.link(text: text).click
	rescue
		@browser.link(text: /#{text}/).click
	end
end


Then(/^status of button "([^"]*)" (should|shouldn't) be disabled$/) do |button_text, status_to_check|
	result = (status_to_check == "should")
	sleep(1)
	expect(@browser.button(text: button_text).disabled?).to equal(result)
end


When(/^I click button "([^"]*)"$/) do |text|
	@browser.button(text: text).click
end


When(/^I click on "([^"]*)"$/) do |text|
	@browser.span(text: text).click
end

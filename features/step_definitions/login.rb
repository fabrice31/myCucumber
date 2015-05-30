# -*- coding: UTF-8 -*-
Given(/^I am on portal$/) do
	visit_page(SitePage)
end

When(/^I connect with my account "([^"]*)"$/) do |which|
	on_page(SitePage).connect(which)
end

When(/^I disconnect$/) do
	on_page(SitePage).logout
end

Then(/^I (am|am not) connected$/) do |action|
	result = (action == 'am')
	# Check if logout link is present or not
	expect(on_page(SitePage).logout_element.exists?).to eq(result)
end

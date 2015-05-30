# -*- coding: UTF-8 -*-
When(/^I refresh my page$/) do
	@browser.refresh
	# need to wait for javascript
	sleep(SHORT_TIMEOUT)
end


When(/^I goto "([^ ]*)"$/) do |url|
	@browser.goto(url)
end


When(/^I accept the confirmation$/) do
	@browser.wait_until(SHORT_TIMEOUT) do
		@browser.alert.exists?
	end
	@browser.alert.ok
end


Then(/^I scroll down (\d+) times$/) do |nb|
	nb.to_i.times do
		@browser.send_keys :page_down
	end
end


When(/^I scroll up to top$/) do
	@browser.send_keys :home
end

When(/^I scroll down to bottom$/) do
	@browser.ps.last.wd.location_once_scrolled_into_view
end


When(/^I maximize my window$/) do
	@browser.driver.manage.window.maximize
end

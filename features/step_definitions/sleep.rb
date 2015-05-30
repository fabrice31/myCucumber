# -*- coding: UTF-8 -*-
Then(/^I need to sleep$/) do
	sleep(TIMEOUT)
end

Then(/^I need to sleep twice$/) do
	sleep(LONG_TIMEOUT)
end

Then(/^I need to sleep a little$/) do
	sleep(SHORT_TIMEOUT)
end

Then(/^I wait (\d+) seconds$/) do |duration|
	sleep(duration.to_i)
end

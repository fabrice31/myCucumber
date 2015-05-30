# -*- coding: UTF-8 -*-
Then(/^I (should|shouldn't) see "([^"]*)"$/) do |action, text|
	result = (action == "should")
	text = text.gsub('__SERVOR__', SERVOR).gsub('__TOKEN__', "#{$token.value}")
	@browser.wait_until(SHORT_TIMEOUT) do
		@browser.body.exists? && @browser.body.visible?
	end
	page = @browser.html
	nb_occurence = page.scan(text).size
	if result
		expect(nb_occurence).to be >= (1), "Page should contain #{text}"
	else
		# shouldn't
		expect(nb_occurence).to equal(0), "Page should not contain #{text}"
	end
end

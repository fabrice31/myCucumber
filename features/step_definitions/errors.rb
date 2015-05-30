# -*- coding: UTF-8 -*-
Then(/^I don't see errors$/) do
	@browser.wait_until(SHORT_TIMEOUT) do
		@browser.body.exists? && @browser.body.visible?
	end
	text = @browser.text.downcase
	errors = ["undefined ", "untitled", "not found ", "forbidden", "unavailable", "erreur 404", "error 404", " 503", "fail"]
	errors.each do |error|
		if (text.include?(error))
			puts "#{error} seen on #{@browser.url}"
			expect(error).to eq(false)
		end
	end
end

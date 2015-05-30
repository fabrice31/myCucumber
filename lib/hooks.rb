# -*- coding: utf-8 -*-
# Before a scenario, open a browser
# Create a token for this test
# Author:: Fabrice
Before do |_scenario|
	# Create a uniq token, and showing some debug infos
	$token = Token.new
	puts "Token for this test : #{$token.value}"
	puts "OS: #{$token.current_os()} - Browser : #{ENV['BROWSER']}"
	puts "Starting time: " + Time.new.inspect

	# open browser
	@browser = launch_browser(ENV['BROWSER'], ENV['KILL'])
end


# After a scenario, close the browser
# Capture a screen and add in the cucumber report
# Author:: Fabrice
After do |scenario|
	begin
		if scenario.failed?
			# @browser have only url for web test, not sdk
			# We need to catch this because if fail on this step, the browser has not properly quit
			begin
				puts @browser.url
			rescue => e
				puts 'Browser without url, should be SDK test or browser crashed'
				puts e
			end

			take_screen(scenario)
		end
		@browser.quit
	rescue => e
		puts 'Error when finishing scenario'
		puts e
	end
end


# For all scenarios, limit is 240 seconds.
# Author:: Fabrice
Around do |_scenario, block|
	Timeout.timeout(240) do
		block.call
	end
end

# -*- coding: UTF-8 -*-
# Deleting previous screen and report
# Author:: Fabrice
def empty_report
	# previous reports and screen should be deleted by jenkins jobs
	# General case : delete old screen and all reports
	# Deleting old screen before to make test
	if !File.directory?(Dir.pwd + "/../screen")
		Dir.mkdir(Dir.pwd + "/../screen")
	else
		base_dir = Dir.pwd + "/../screen/"
		Dir.glob(File.join(base_dir, '*')).each do |old_screen|
			File.delete(old_screen)
		end
	end

	# Deleting result report
	base_dir = Dir.pwd + "/../"
	Dir.glob(File.join(base_dir, 'result*.html')).each do |old_report|
		File.delete(old_report)
	end
end


# Taking a screenshot, saving, and including in cucumber report
# In:: Object scenario
# Author:: Fabrice
def take_screen(scenario)
	if !File.directory?(Dir.pwd + "/../screen")
		Dir.mkdir(Dir.pwd + "/../screen")
	end

	# Get the name of the scenario, without special characters
	name = scenario.name.split(", Scenario")[0].gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')

	# adding time
	name = Time.now.strftime("%Hh%Mm%Ss-") + name.gsub('__', '_')
	name = name[0..59]

	screenshot = "../screen/#{name}.png"
	screenshot_file = Dir.pwd + "/../screen/#{name}.png"
	@browser.driver.save_screenshot(screenshot_file)
	embed screenshot, 'image/png'
end

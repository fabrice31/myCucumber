# -*- coding: UTF-8 -*-
# !/usr/bin/env ruby -w
require 'rubygems'



# Read junit file
# Out:: String
# Author:: Fabrice
def get_junit_line
	# Folder for the junit files
	folder = Dir.pwd + "/junit"

	# Junit file
	junit_file = ''
	Dir.glob(File.join(folder, "*.xml")).each do |junit|
		junit_file = junit
	end

	# Read junit datas
	line_num = 0
	File.open(junit_file).each do |line|
		if line_num == 1
			# line 2 should be :
			# <testsuite failures="1" errors="0" skipped="0" tests="1" time="2.749695" name="I can use login tools">
			return line
		end
		line_num += 1
	end
end

# Check if rerun is needed and useful
# Out:: Float ratio of error
# Author:: Fabrice
def check_rerun
	content = get_junit_line

	# Check number of failures, nb of errors, nb of tests
	/failures=\"(?<failure>[^\"]*)\"/ =~ content
	/errors=\"(?<error>[^\"]*)\"/ =~ content
	# /skipped=\"([^\"]*)\"/ =~ content
	/tests=\"(?<test>[^\"]*)\"/ =~ content

	errors = error.to_i + failure.to_i
	ratio = errors.to_f / test.to_f

	# Debug line and return results
	if ratio == 0
		puts "Nothing to rerun"
	elsif ratio > 0 && ratio < 0.4
		puts "Rerun"
	else
		puts "Too many errors (#{errors} / #{test}) , please launch again the whole job"
	end
	ratio
end

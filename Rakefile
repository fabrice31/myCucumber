# -*- coding: UTF-8 -*-
# !/usr/bin/env ruby -w
require 'cucumber'
require 'cucumber/rake/task'
require_relative 'lib/check_rerun.rb'

# Prepare a cucumber execution
# In:: String browser
# In:: String tag
# In:: String env
# In:: Boolean firstrun (true for first run, false for rerun)
# Author:: Fabrice
def create_cucumber_command(browser, tag, env, firstrun)
	command = "cucumber --tags @#{tag} -p kill -p #{browser} -p #{env}"
	if firstrun
		command += " -p rerun"
	else
		command += " -p second_run @rerun.txt"
	end
end

namespace :automate do
	desc "Launch test with params browser, tag, env, rerun"
	task :tests, [:browser, :tag, :env, :rerun] do |t, args|
		# Create the task with parameters
		system(create_cucumber_command(args.browser, args.tag, args.env, true))
		if args.rerun == "true"
			# If not unactivate by command line
			# Check if rerun mode should be use
			ratio = check_rerun
			# Rerun activation, if less of 40% tests failed
			if ratio > 0 && ratio < 0.4
				system(create_cucumber_command(args.browser, args.tag, args.env, false))
			end
		end
	end
end

namespace :doc do
	desc 'List all defined steps'
	task :steps do
	require 'hirb'
	extend Hirb::Console
	puts "CUCUMBER steps:"
	puts ""
	step_definition_dir = "features/step_definitions"

	Dir.glob(File.join(step_definition_dir,'**/*.rb')).each do |step_file|

	puts "File: #{step_file}"
	puts ""
	results = []
	File.new(step_file).read.each_line.each_with_index do |line, number|

		next unless line =~ /^\s*(?:Given|When|Then)\s+|\//
			res = /(?:Given|When|Then)[\s\(]*\/(.*)\/([imxo]*)[\s\)]*do\s*(?:$|\|(.*)\|)/.match(line)
			next unless res
				matches = res.captures
				results << OpenStruct.new(
					:steps => matches[0],
					:modifier => matches[1],
					:args => matches[2]
				)
			end
			table results, :resize => false, :fields=>[:steps, :modifier, :args]
			puts ""
		end
	end
end

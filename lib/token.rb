# -*- coding: UTF-8 -*-
# Use to got random value
# Useful to post a data with random string but keep the value to check it later
# Author:: Fabrice
class Token
	# Create a new token
	# Author:: Fabrice
	def initialize
		@value = "#{ENV['BROWSER']}#{256 * 256 + rand(1024 * 1024)}#{current_os()[0..2]}"
	end

	attr_reader :value

	# Get the current OS
	# Author:: Fabrice
	def current_os
		if !(/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
			return "windows"
		elsif !(/darwin/ =~ RUBY_PLATFORM).nil?
			return "mac"
		else
			return "debian"
		end
	end
end

# -*- coding: UTF-8 -*-
# Accounts used during the functionnal tests
# This file should never become public
class Account
	# email : email of the account
	attr_reader :email
	# password : password of the account
	attr_reader :password

	# List of all accounts used in the tests
	config = YAML.load_file('support/config.yml')
	TAB_ACCOUNTS = config['accounts']


	# Get a complete account from the TAB_ACCOUNT
	# Some of the account can't login
	#
	# In:: The name of the account
	# Out:: complete account
	# Author:: Fabrice
	def initialize(which)
		@email = TAB_ACCOUNTS[which]['email']
		@password = TAB_ACCOUNTS[which]['password']
	end

	# Magic getter for the account
	#
	# Use in the SA tool to check
	# In:: The param to get
	# Out:: The value of this param
	# Author:: Fabrice
	def get(type)
		case type
		when 'email'
			@email
		when 'password'
			@password
		end
	end
end

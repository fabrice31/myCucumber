# -*- coding: UTF-8 -*-
# Author:: Fabrice
class SitePage
	include PageObject
	include RSpec::Matchers

	page_url "http://#{SERVOR}/"

	# Login field
	text_field(:login_email, id: 'login_email')
	text_field(:login_pwd, class: 'password', index: 0)
	button(:login, text: /Connect/)

	# Logout
	link(:logout, url: /logout\.php/)

	# Connect with the account
	# In:: String which account to use (from config.yml)
	# Author:: Fabrice
	def connect(which)
		account = Account.new(which)

		# Wait for page to load
		self.wait_until(TIMEOUT) do
			self.login_email? && self.login_email_element.visible?
		end

		# fill form
		self.login_email = account.email
		self.login_pwd = account.password
		# go
		self.login_go
		# Need to wait
		sleep(2)
	end	

end
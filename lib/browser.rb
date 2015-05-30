# -*- coding: UTF-8 -*-

# download folder
# used for proxy sessions
# Internet explorer can't be configure by code : be careful
$download_directory = "#{Dir.pwd}/downloads/"
$download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?


# Kill all browsers instances if needed
# Auhtor:: fabrice
def clean_browsers
	if $token.current_os == 'windows'
		`taskkill /im chromedriver.exe /F 2>NUL`
		`taskkill /im firefox.exe /F 2>NUL`
		`taskkill /im firefoxdriver.exe /F 2>NUL`
		`taskkill /im ieDriverServer.exe /F 2>NUL`
		`taskkill /im iexplore.exe /F 2>NUL`
	else
		`pkill firefox`
		`pkill chrome`
	end
end

# Launch browser with good configuration
# In:: String which browser / device to launch
# In:: Boolean true to kill old browser instance
# Out:: Browser / App on device
# Author:: Fabrice
def launch_browser(which, kill = false)
	if %w(ch ff ie ie8 ie9 ie10 ie11).include? which
		browser = launch_browser_desktop(which, kill)
	else
		browser = nil
	end

	# Check browser really launch
	if browser.nil?
		fail "Browser #{which} is not launched properly"
	end

	# return browser
	browser
end


# Launch desktop browser
# In:: String which browser
# In:: Boolean true to kill old browser instance
# Out:: Desktop browser
# Author:: Fabrice
def launch_browser_desktop(which, kill)
	# generic params for all browsers
	client = Selenium::WebDriver::Remote::Http::Default.new
	client.timeout = 45 # seconds default is 60

	# we need to kill all browsers
	if kill
		clean_browsers
	end

	case which
	when 'ch'
		prefs = {
			download: {
				prompt_for_download: false,
				default_directory: $download_directory
			}
		}
		caps = Selenium::WebDriver::Remote::Capabilities.chrome(
				"chromeOptions" => {
					"args" => ["test-type"]
				})

		browser = Watir::Browser.new :chrome, http_client: client, prefs: prefs, desired_capabilities: caps

	when 'ff'
		profile = Selenium::WebDriver::Firefox::Profile.new
		profile['browser.download.folderList'] = 2
		profile['browser.download.dir'] = $download_directory
		profile['browser.link.open_newwindow'] = 3
		profile['download.prompt_for_download'] = false
		profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream,text/csv,application/pdf"
		profile['network.http.use-cache'] = false
		browser = Watir::Browser.new :firefox, http_client: client, profile: profile

	when 'ie', 'ie8', 'ie9', 'ie10', 'ie11'
		# we launch the explorer on the current "servor"
		# You have to launch the job on the correct servor

		browser = Watir::Browser.new :ie, http_client: client
		# Clearing cookie because IE is dumb
		# Need to configure the browser with "Delete history after each close"
	else
		fail "WARNING : Desktop #{which} is not a valid browser in the project"
	end

	# Resize browser
	browser.driver.manage.window.resize_to(1250, 900)
	# Adding user agent to debug console log
	# puts browser.execute_script("return navigator.userAgent").to_s

	# return browser
	browser
end


# Get height of the screen
# Author:: Fabrice
def browser_height
	@browser.execute_script("return window.innerHeight").to_i
end

# Get width of the screen
# Author:: Fabrice
def browser_width
	@browser.execute_script("return window.innerWidth").to_i
end

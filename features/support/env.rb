$: << File.dirname(__FILE__)+'/../lib'

require('watir-webdriver')

module Browser
  BROWSER = Watir::Browser.new

  TIMEOUT = 10
end

World Browser


Before do |scenario|
  # in case you use media queries, you need a standard size
  Browser::BROWSER.window.resize_to(1150,800)
  # always a token, in case it is need during scenario
  $token = Token.new
  puts "Token: #{$token.value}"
end

After do |scenario|
  if scenario.failed?
    # screen
    Dir::mkdir('screen') if not File.directory?('screen')
    screenshot = "./screen/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
    Browser::BROWSER.driver.save_screenshot(screenshot)
    embed screenshot, 'image/png'
  end
end

at_exit do
  Browser::BROWSER.close
end

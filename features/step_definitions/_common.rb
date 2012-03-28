################################################################################
# DEBUG step
################################################################################
When /^I create a token$/ do
  $token = Token.new
  puts "Token: #{$token.value}"
end

Then /^I take a screen$/ do
  Dir::mkdir('screen') if not File.directory?('screen')
  screenshot = "./screen/debug.png"
  Browser::BROWSER.driver.save_screenshot(screenshot)
  embed screenshot, 'image/png'
end


################################################################################
# Basic action
################################################################################
Given /^I am on project (.+)$/ do |page|
  Browser::BROWSER.goto(Common::SITES[page])
  if (page == 'HomePage')
    # specifif treatment ?
  end
end

When /^I click on link "([^"]*)"$/ do |text|
  Browser::BROWSER.wait_until(Browser::TIMEOUT){
    Browser::BROWSER.link(:text, text).exists?
  }
  Browser::BROWSER.link(:text, text).click
end

When /^I click on link ([^"]*)$/ do |text|
  texte = translate(text)
  Browser::BROWSER.wait_until(Browser::TIMEOUT){
    Browser::BROWSER.link(:text, texte).exists?
  }
  Browser::BROWSER.link(:text, texte).click
end

When /^I reload the page$/ do
  Browser::BROWSER.refresh
end

When /^I click on button "([^"]*)"$/ do |text|
  Browser::BROWSER.button(:text, text).click
end

When /^I add to url "([^"]+)"$/ do |extend|
  Browser::BROWSER.goto("#{Browser::BROWSER.url}#{extend}")
end


################################################################################
# Error detection
################################################################################
Then /^I shouldn't see errors$/ do
  Browser::BROWSER.wait_until(Browser::TIMEOUT){
    Browser::BROWSER.body.exists?
  }
  errors = ["Call Stack", "Undefined ", "Trying to", "Can't publish post",
            "Error", "Error 404", "Error 503",
            "Warning ", "Fatal exception", "Syntax error"]
  errors.each do |error|
    if (Browser::BROWSER.html.include?(error))
      puts error
      error.should == false
    end
    if (Browser::BROWSER.text.include?(error))
      puts error
      error.should == false
    end
  end
end


Then /^the error "(.*)" is displayed$/ do |error|
  Browser::BROWSER.wait_until(Browser::TIMEOUT){
    Browser::BROWSER.div(:class, "error-container").visible?
  }
  i=0
  find = false
  while (!find and Browser::BROWSER.li(:index, i).visible?)
    if (Browser::BROWSER.li(:index, i).text.include?error)
      find = true
    end
    i = i+1
  end
  # error not found
  find.should == true
end


################################################################################
# Title control
################################################################################
Then /^title should contain "(.*)"$/ do |title|
  Browser::BROWSER.title.include?(title).should == true
end

Then /^title shouldn't contain "(.*)"$/ do |title|
  Browser::BROWSER.title.include?(title).should == false
end

Then /^title should contain ([^"]*)$/ do |key|
  Browser::BROWSER.title.include?(translate(key)).should == true
end

Then /^title shouldn't contain ([^"]*)$/ do |key|
  Browser::BROWSER.title.include?(translate(key)).should == false
end


################################################################################
# Page control
################################################################################
Then /^page should contain "(.*)"$/ do |txt|
  Browser::BROWSER.wait_until(Browser::TIMEOUT){
    Browser::BROWSER.body.exists?
  }
  # don't search in frame
  Browser::BROWSER.text.include?(txt).should == true
end

Then /^page shouldn't contain "(.*)"$/ do |txt|
  Browser::BROWSER.wait_until(Browser::TIMEOUT){
    Browser::BROWSER.body.exists?
  }
  # don't search in frame
  Browser::BROWSER.text.include?(txt).should == false
end

Then /^page should contain ([^"]*)$/ do |key|
  Browser::BROWSER.wait_until(Browser::TIMEOUT){
    Browser::BROWSER.body.exists?
  }
  Browser::BROWSER.text.include?(translate(key)).should == true
end

Then /^page shouldn't contain ([^"]*)$/ do |key|
  Browser::BROWSER.wait_until(Browser::TIMEOUT){
    Browser::BROWSER.body.exists?
  }
  Browser::BROWSER.text.include?(translate(key)).should == false
end


Then /^html should contain "(.*)"$/ do |txt|
  # don't search in frame
  Browser::BROWSER.html.include?(txt)
end

################################################################################
# Action in form
################################################################################
When /^I puts in form name ([^ ]+) the value (.+)$/ do |name, value|
  Browser::BROWSER.text_field(:name, name).set(value)
end

Then /^the form name ([^ ]+) get the value (.+)$/ do |name, value|
  Browser::BROWSER.text_field(:name, name).value.should == value
end


################################################################################
# Resize browser
################################################################################
When /^I set size of browser to default$/ do
  step "I set size of browser to 1150x800"
end

When /^I set size of browser to ([^x]*?)x([^x]*?)$/ do |width, height|
  Browser::BROWSER.window.resize_to(width,height)
end

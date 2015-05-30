# -*- coding: UTF-8 -*-
# !/usr/bin/env ruby -w
# Define global requirement, constants and environment
require 'rubygems'
require 'watir-webdriver'
require 'watir-ng'
require 'rspec'
require 'page-object'
require 'page-object/page_factory'
require 'require_relative'
require 'yaml'


# PageObject Factory
World(PageObject::PageFactory)

# Common stuff for all test projects
# Create folder or empty them
# Adding token class, scenario methods
require_relative '../lib/token.rb'
require_relative '../lib/screen.rb'
require_relative '../lib/browser.rb'
require_relative '../lib/hooks.rb'
require_relative '../lib/element.rb'
require_relative '../lib/account.rb'


# Global timeout when you wait for ajax or something slow
SHORT_TIMEOUT = 3
TIMEOUT = 5
LONG_TIMEOUT = 10

if ENV['rerun'].nil? || ENV['rerun'] != 'true'
	empty_report()
end

# Depending of environnement / servers to test
case ENV['ENV']
when 'prod'
	SERVOR = 'blog.fabricebournisien.eu'
else
	SERVOR = "127.0.0.1/blog"
end

# -*- coding: UTF-8 -*-
# !/usr/bin/env ruby -w
require 'yaml'

# Configurations of the convention checkers
$errors = false

# Do all the checks
# Author:: Fabrice
def check_conventions
	check_encoding
	check_yaml
	check_merge
	check_cucumber
	check_ruby
end


# Check cucumber
# Author:: Fabrice
def check_cucumber
	system("cucumber --dry-run .. >> pre-commit-features.txt 2>&1")
	file = "pre-commit-features.txt"
	lines = File.open(file).to_a
	result = lines.first
	if result.include? "error"
		$errors = true
		puts "Error in cucumber file for #{folder}"
	end
	File.delete(file)
end


# Check encoding for all files
# Author:: Fabrice
def check_encoding
	all_encoding = []
	files = Dir.glob("**/*.rb") + Dir.glob("**/*.yml") + Dir.glob("**/*.feature")
	files.each do |file|
		all_encoding.push(File.open(file).map { |line| line.to_s.encoding })
	end

	nb = all_encoding.flatten.count { |encoding| encoding.name != 'UTF-8' }
	if nb > 0
		puts "Error encoding file"
		$errors = true
	end
end


# Check merge error for cucumber
# Author:: Fabrice
def check_merge
	res = ''
	files = Dir.glob("**/*.rb") + Dir.glob("**/*.yml") + Dir.glob("**/*.feature")
	files.each do |file|
		nb = 0
		if !file.include? 'convention.rb'
			errors = %w(<<<<< >>>>> ===== binding\.pry $\tAnd)
			errors.each do |reg|
				nb += File.readlines(file).grep(reg).size
			end
		end
		if nb > 0
			res += "#{file}, "
			$errors = true
		end
	end

	if res != ''
		puts "Some file seems to be incorrect, with error like <<<<, >>>>, ====, binding.pry..."
		puts res
	end
end


# Check ruby convention
# Author:: Fabrice
def check_ruby
	command = "rubocop -c rubocop.yml . -D -o pre-commit-rubocop.txt"
	system(command)
	file = "pre-commit-rubocop.txt"
	lines = File.open(file).to_a
	result = lines.last
	/, (?<nb_error>[^ ]*) offense/ =~ result
	if nb_error.to_i > 0
		puts "Error ruby convention"
		puts lines
		$errors = true
	end
	File.delete(file)
end


# Check Yaml files
# Author:: Fabrice
def check_yaml
	nb_error = 0
	Dir.glob("**/*.yml").each do |file|
		begin
			YAML.load_file(file)
		rescue => e
			nb_error += 1
			puts e
		end
	end
	if nb_error > 0
		$errors = true
	end
end


# Do the job
check_conventions
# Results expected
exit $errors

When /^I see informations about environnement$/ do
  puts "Environnement => #{$ENV}"
  puts "Language => #{$LANG}"
end

When /^I see informations about general$/ do
  Common::SITES.each { |key, value|
    puts "#{key} => #{value}"
  }
  t = Time.now
  puts t.strftime("Date : %d/%m/%Y %H:%M:%S")
end

# List of french text used in text
# order by alphabetic
if ($LANG == 'fr')
  def translate(str)
    case str
    when 'debug'
      'I am debug'
    else
      puts "Translation of #{str} not found"
      return str
    end
  end
end
# List of french text used in text
# order by alphabetic
if ($LANG == 'fr')
  TRANSLATEARRAY = {
    ############################
    # Special text
    ############################
    'site.title'            => 'Default'
  }

  def translate(str)
    if (!TRANSLATEARRAY[str])
      puts "Translation of #{str} not found in FR"
      return str
    else
      return TRANSLATEARRAY[str]
    end
  end
end

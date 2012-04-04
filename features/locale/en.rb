# List of english text used in text
# order by alphabetic
if ($LANG == 'en')
  TRANSLATEARRAY = {
    ############################
    # Message errors
    ############################
    'error.articlenotexist' => 'This post does not exist',

    ############################
    # Menu
    ############################
    'menu.publish'      => 'Publish',

    ############################
    # Text buttons
    ############################
    'button.save'           => 'Save',

    ############################
    # Text links
    ############################
    'link.admin'      => 'Admin',
    'link.login'      => 'Log in',
    'link.logout'     => 'Log out',
    'link.publish'    => 'Publish',
    'link.select'     => 'Select',
    'link.set'        => 'Set',
    'link.upload'     => 'Upload',

    ############################
    # Special text
    ############################
    'site.title'            => 'Overblog',

    ############################
    # Other text
    ############################
    'text.howto'		=> 'How to start a cucumber project ?'
	}

  def translate(str)
    if (!TRANSLATEARRAY[str])
      puts "Translation of #{str} not found in EN"
      return str
    else
      return TRANSLATEARRAY[str]
    end
  end
end

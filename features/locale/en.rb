# List of english text used in text
# order by alphabetic
if ($LANG == 'en')
  def translate(str)
    case str
    ############################
    # Message errors
    ############################
    when 'error.not_allowed'
      'You are not allowed to acces this page.'

    ############################
    # Menu
    ############################
    when 'menu.publish'
      'Publish'

    ############################
    # Text buttons
    ############################
    when 'button.save'
      'Save'

    ############################
    # Text links
    ############################
    when 'link.admin'
      'Admin'
    when 'link.login'
      'Log in'
    when 'link.logout'
      'Log out'
    when 'link.publish'
      'Publish'
    when 'link.select'
      'Select'
    when 'link.set'
      'Set'
    when 'link.upload'
      'Upload'


    ############################
    # Special text
    ############################
    when 'site.title'
      'myCucumber'

    ############################
    # Other text
    ############################
    when 'text.howto'
      'How to start a cucumber project ?'


    else
      puts "Translation of #{str} not found"
      return str
    end
  end
end

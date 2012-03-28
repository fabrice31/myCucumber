# test environment
$ENV = 'DEV'

# test language
$LANG = ENV['lang']
if ($LANG  == nil)
  $LANG = 'en'
end
$: << File.dirname(__FILE__)+'/../../locale/'+$LANG+'.rb'

module Common
  if $ENV == "DEV"
  	ndd = "github.com/fabrice31/myCucumber"
  else
    puts "ERROR : FAIL - wrong environment"
  end

  SITES = {
    'HomePage'  => "http://www.#{ndd}"
  }

  ACCOUNTS = {
    'free' =>
      {
        'email'   => "someone@company.com",
        'pwd'     => "myPassword"
      },
    'admin' =>
      {
        'email'   => "boss@company.com",
        'pwd'     => "theVerySecurPasswd"
      }
    }
end

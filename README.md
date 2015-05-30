# MyCucumber project

This is a project to start cucumber, watir and page object with good practices.

## How to install

* Install ruby 2.2.1
* Install gem bundle with ```gem install bundle```
* Install all useful gem with ```bundle install```

That's all :)

## How to work

You can launch test using cucumber profiles. Here some example:

* ```cucumber -p prod``` for production tests
* ```cucumber -p testing``` for tests in test environment
* ```cucumber --tag @login``` for all tests about login

## Security

You can check that your repository is fine with the pre commit hook. Just type ```./pre-commit-rubocop.sh```. It will check:

* Ruby convention (you can change them in lib/rubocop.yml)
* Encoding file (UTF-8)
* yaml file
* No git merge errors
* etc. 

## Rake tasks

Some rake tasks are configured to help you:

* ```rake doc:steps``` : generate documentation
* ```rake automate:tests[ff,login,testing,true]``` : launch tests for the browser, tag, environment in parameter. Last parameter: failed tests are rerun once to avoid random false positives.
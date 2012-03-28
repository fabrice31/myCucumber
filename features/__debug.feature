Feature: Debug Information
  @debugInfo
  Scenario: Show information
    When I see informations about environnement
    When I see informations about general

  @debugInfo
  Scenario: debug
    Given I am on project HomePage
    When I create a token
		Then I shouldn't see errors
		And page should contain text.howto
		And title should contain site.title

Feature: Test login page

@login
Scenario: I can connect to my account
	Given I am on portal
	When I connect with my account "admin"
	Then I am connected
	When I disconnect
	Then I am not connected

@login @wip
Scenario Outline: I can't connect with wrong datas
	Given I am on portal
	When I connect with my account "<account>"
	Then I am not connected
	Then I should see "<error>"

	Scenarios:
	| account 			| error 			|
	| space_pwd			| Wrong datas 		|
	| uppercase_email 	| Account unknown 	|
	| uppercase_pwd		| Wrong datas 		|
	| wrong_email		| Account unknown	|
	| wrong_pwd 		| Wrong datas		|

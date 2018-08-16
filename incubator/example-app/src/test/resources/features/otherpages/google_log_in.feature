@test5 
Feature: Log in/sign up with gmail 

	As a user, 
    I want to log in with my gmail account
    so I don't need to take time to register an iorad account

	#==> expected: after login then I should be redirected to the Shared tab
	#==> actual: after login, redirected to the Choose page
@smoke @fail 
Scenario: log in with Gmail which is used to registered iorad account 
	When I go to "/login" 
	And I click "login.login_with_google_button" 
	And Login to gmail with user "googlefreeverifieduseruser" and password "googlefreeverifieduserpass" 
	Then I should see the My tutorials page content 
	
@smoke @chrome @firefox @edge 
Scenario: log in with Gmail which is not registered yet 
	When I go to "/login" 
	And I click "login.login_with_google_button" 
	And Login to gmail with user "gmailunregisteruser" and password "gmailunregisterpass" 
	And My public name should be "gmailunregisterfullname" 
	And I should be redirected to the Choose page 
	
@smoke @safari 
Scenario: log in with Gmail which is not registered yet 
	When I go to "/login" 
	And I click "login.login_with_google_button" 
	And Login to gmail with user "gmailunregisteruser" and password "gmailunregisterpass" 
	And I should be redirected to the Download page 
	
	#==> expected: after login then I should be redirected to the Shared tab
	#==> actual: after login, redirected to the Choose page
@smoke @fail 
Scenario: sign up with Gmail which is registered iorad account 
	When I go to "/signup" 
	And I click "signup.signup_with_google_button" 
	And Login to gmail with user "googlefreeverifieduseruser" and password "googlefreeverifieduserpass" 
	Then I should see the My tutorials page content 
	
@smoke @chrome @firefox @edge 
Scenario: sign up with Gmail which is not used to register iorad account yet 
	When I go to "/signup" 
	And I click "signup.signup_with_google_button" 
	And Login to gmail with user "gmailunregisteruser" and password "gmailunregisterpass" 
	And My public name should be "gmailunregisterfullname" 
	And I should be redirected to the Choose page 
	
@smoke @safari 
Scenario: sign up with Gmail which is not used to register iorad account yet 
	When I go to "/signup" 
	And I click "signup.signup_with_google_button" 
	And Login to gmail with user "gmailunregisteruser" and password "gmailunregisterpass" 
	And I should be redirected to the Download page 
	
@function 
Scenario: sign up/log in with Gmail not registered after going Pricing page 
	Given I am at "/logout" 
	Then I should be logged out and redirected to the home page 
	When I go to "/pricing" 
	And I click "pricing.go_live_button" 
	And I click "login.login_with_google_button" 
	And Login to gmail with user "gmailunregisteruser" and password "gmailunregisterpass" 
	Then I should see the Checkout page content 
	And My public name should be "gmailunregisterfullname" 

@test1
Feature: Unverified user activates account
  
    As an unverified user,
    I want to activate my account
    so that I can user the features for verified user.

  @smoke @low_priority
  Scenario: Activate account successfully as logged-in user
    Given I go to "/signup"
    When I fill value "signup.verify_full_name" to "signup.public_name" textbox
    When I fill value "signup.verify_user" to "signup.email" textbox
    When I fill value "signup.verify_password" to "signup.password" textbox
    When I click "signup.terms"
    Then The "signup.signup_button" should be enabled
    When I click "signup.signup_button"
    When Open gmail with user "signup.gmail_verify_user" and password "signup.gmail_verify_password"
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link" and switch to the second tab
    Then I should be redirected to the "/tutorials"
    Then I should see the message "Thanks. You're good to go."

  @smoke
  Scenario: Activate account as an anonymous user
    Given I go to "/signup"
    When I fill value "signup.unverified_fullname" to "signup.public_name" textbox
    When I fill value "signup.unverified_user" to "signup.email" textbox
    When I fill value "signup.unverified_password" to "signup.password" textbox
    When I click "signup.terms"
    Then The "signup.signup_button" should be enabled
    When I click "signup.signup_button"
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When Open gmail with user "signup.gmail_unverified_user" and password "signup.gmail_unverified_password"
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link" and switch to the second tab
    Then I should be redirected to the "/login"
    Then The element "login.login_button" should be shown
    Then The element "login.email" should be shown
    Then The element "login.password" should be shown
    When I fill value "signup.unverified_user" to "login.email" textbox
    When I fill value "signup.unverified_password" to "login.password" textbox
    And I click "login.login_button"
    Then I should be redirected to the "/tutorials" page
    Then I should see the message "Thanks. You're good to go."
    
 @low_priority
Scenario Outline: The activation email is expired 
# Sign-up a new unverified user
	Given I go to "/signup" 
	When I fill value "<public_name>" to "signup.public_name" textbox 
	When I fill value "<sign_up_user>" to "signup.email" textbox 
	When I fill value "<password>" to "signup.password" textbox 
	When I click "signup.terms" 
	Then The "signup.signup_button" should be enabled 
	And I click "signup.signup_button" 
	# Delete the account
	When I go to "/account" 
	Then The element "my_plan.my_plan_link" should be shown 
	And The element "my_account.my_account_link" should be shown 
	When I click "my_account.my_account_link" 
	Then The element "my_account.delete_account_link" should be shown 
	When I click "my_account.delete_account_link" 
	And I fill value "<password>" to "my_account.delete_account.confirm_password" textbox 
	When I click "my_account.delete_account.delete_account_button" 
	Then I should see the message "A confirmation link has been emailed. Click that to confirm deletion." 
	# Open email to confirm deletion
	When Open gmail with user "<sign_up_user>" and password "<email_password>" 
	And I close other tabs 
	Then The element "servermail.delete_my_account_link" should be shown in gmail 
	When I click "servermail.delete_my_account_link" and switch to the second tab 
	Then I should see the message "We're sorry to see you go. Your account has been deleted" 
	# Try to active account again
	When Open gmail with user "<sign_up_user>" and password "<email_password>" 
	And I close other tabs 
	And I click "servermail.second_mail" 
	Then The element "signup.verify_user_link" should be shown in gmail 
	When I click "signup.verify_user_link" and switch to the second tab 
	Then I should see the message "Activation link is expired." 
	Examples: 
		|	sign_up_user											|	email_password	|	login_password	|	public_name						|
		| {S5,N4,!@gmail.com}		|	iorad@123				|	123456					|	{S5,N4}		|
		
    
# Need to check the outcome
    @low_priority 
Scenario Outline: Logged-in user - The activation email is already used 
# Sign-up a new user and active it first
	Given I go to "/signup" 
	When I fill value "<public_name>" to "signup.public_name" textbox 
	When I fill value "<sign_up_user>" to "signup.email" textbox 
	When I fill value "<password>" to "signup.password" textbox 
	When I click "signup.terms" 
	Then The "signup.signup_button" should be enabled 
	When I click "signup.signup_button" 
	When Open gmail with user "<sign_up_user>" and password "<email_password>" 
	And I close other tabs 
	Then The element "signup.verify_user_link" should be shown in gmail 
	When I click "signup.verify_user_link" and switch to the second tab 
	Then I should be redirected to the "/tutorials" 
	And I should see the message "Thanks. You're good to go." 
	# Open the activate link again
	When Open gmail with user "<sign_up_user>" and password "<email_password>" 
	And I close other tabs 
	Then The element "signup.verify_user_link" should be shown in gmail 
	When I click "signup.verify_user_link" and switch to the second tab 
	Then I should be redirected to the "/tutorials" 
	Then I should see the message "Thanks. You're good to go." 
	Examples: 
		|	sign_up_user											|	email_password	|	login_password	|	public_name		|
		| {S5,N4,!@gmail.com}	|	iorad@123				|	123456					|	{S5,N4}		|
		
		
# need to check expected result
Scenario Outline: Anonymous user - The activation email is already used 
# Sign-up a new user and active it first
	Given I go to "/signup" 
	When I fill value "<public_name>" to "signup.public_name" textbox 
	When I fill value "<sign_up_user>" to "signup.email" textbox 
	When I fill value "<password>" to "signup.password" textbox 
	When I click "signup.terms" 
	Then The "signup.signup_button" should be enabled 
	When I click "signup.signup_button" 
	When Open gmail with user "<sign_up_user>" and password "<email_password>" 
	And I close other tabs 
	Then The element "signup.verify_user_link" should be shown in gmail 
	When I click "signup.verify_user_link" and switch to the second tab 
	Then I should be redirected to the "/tutorials" 
	And I should see the message "Thanks. You're good to go." 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	# Open the activate link again
	When Open gmail with user "<sign_up_user>" and password "<email_password>" 
	And I close other tabs 
	Then The element "signup.verify_user_link" should be shown in gmail 
	When I click "signup.verify_user_link" and switch to the second tab 
	Then I should be redirected to the "/login" page 
	And The element "login.email" should be shown 
	And The element "login.password" should be shown 
	Examples: 
		|	sign_up_user											|	email_password	|	login_password	|	public_name		|
		| {S5,N4,!@gmail.com}	|	iorad@123				|	123456					|	{S5,N4}		|

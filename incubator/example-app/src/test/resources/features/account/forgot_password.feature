@test1 
Feature: Forgot Password 
	As an anonymous user,
  I want to reset my password,
  so that I can log in and use the features of iorad.

Background: 
	Given I am an anonymous user 
	
@smoke 
Scenario: access reset password page 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	And The element "forgot_password.forgot_your_password?" should be shown 
	And The element "forgot_password.send_reset_link_button" should be shown 
	And The element "forgot_password.email" should be shown 
	
@smoke 
Scenario: reset password successful 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	And The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "gmailupplanunverifieduser" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "Check your email and click the Change Password link." 
	When Open gmail with user "gmailupplanunverifieduser" and password "gmailupplanunverifieduserpass" 
	Then The element "gmail.reset_password_button" should be shown in gmail 
	When I click "gmail.reset_password_button" and switch to the second tab 
	When I fill value "validpassword" to "forget_password.password_textbox" textbox 
	When I click "forgot_password.change_password_button" 
	And I should see the message "Password changed. Please login again." 
	And I should be redirected to the "/login" page 
	
Scenario: send reset link with empty email 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	Then The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "Please enter your email." 
	
Scenario Outline: send reset link with invalid email 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	Then The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "<invalid_email>" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "Please enter a valid email address." 
	
	Examples: 
		|	invalid_email 						|
		|	this_is_an_invalid_email	|
		
Scenario Outline: send reset link with unregistered email 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	Then The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "<unregister_email>" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "User with this email address not found." 
	
	Examples: 
		|	unregister_email 												|
		|	this_is_an_unregister_email@gmail.com		|
		
Scenario Outline: send reset link with deleted account's email 
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
	
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	Then The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "<sign_up_user>" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "User with this email address not found." 
	Examples: 
		|	sign_up_user											|	email_password	|	login_password	|	public_name						|
		| {S5,N4,!@gmail.com}		|	iorad@123				|	123456					|	{S5,N4}		|
		
Scenario Outline: reset password with empty new password 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	Then The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "<forgot_password_user>" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "Check your email and click the Change Password link." 
	When Open gmail with user "<forgot_password_user>" and password "<email_pass>" 
	And I close other tabs 
	Then The element "gmail.reset_password_button" should be shown in gmail 
	When I click "gmail.reset_password_button" and switch to the second tab 
	And I fill value "" to "forget_password.password_textbox" textbox 
	And I click "forgot_password.change_password_button" 
	Then I should see the message "Please enter your password." 
	
	Examples: 
		|	forgot_password_user|	email_pass						|
		|	googlefreeuser			| googleunverifiedpass	|
		
		
Scenario Outline: reset password with new password containing of less than 6 characters 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	Then The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "<forgot_password_user>" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "Check your email and click the Change Password link." 
	When Open gmail with user "<forgot_password_user>" and password "<email_pass>" 
	And I close other tabs 
	Then The element "gmail.reset_password_button" should be shown in gmail 
	When I click "gmail.reset_password_button" and switch to the second tab 
	And I fill value "<new_password>" to "forget_password.password_textbox" textbox 
	And I click "forgot_password.change_password_button" 
	Then I should see the message "Please enter a valid password. Use at least 6 characters, and don't use spaces." 
	
	Examples: 
		|	forgot_password_user|	email_pass						|	new_password	|	
		|	googlefreeuser			| googleunverifiedpass	| 1234					|
		
Scenario Outline: reset password with new password containing of more 16 characters 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	Then The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "<forgot_password_user>" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "Check your email and click the Change Password link." 
	When Open gmail with user "<forgot_password_user>" and password "<email_pass>" 
	And I close other tabs 
	Then The element "gmail.reset_password_button" should be shown in gmail 
	When I click "gmail.reset_password_button" and switch to the second tab 
	And I fill value "<new_password>" to "forget_password.password_textbox" textbox 
	And I click "forgot_password.change_password_button" 
	Then I should see the message "Password should not be more than 16 characters." 
	
	Examples: 
		|	forgot_password_user|	email_pass						|	new_password						|	
		|	googlefreeuser			| googleunverifiedpass	| thisisatoolongpassword	|
		
Scenario Outline: reset password with space-key password 
	Given I am at the "/login" page 
	When I click "login.forgot_password" 
	Then The element "forgot_password.forgot_your_password?" should be shown 
	When I fill value "<forgot_password_user>" to "forgot_password.email" textbox 
	And I click "forgot_password.send_reset_link_button" 
	Then I should see the message "Check your email and click the Change Password link." 
	When Open gmail with user "<forgot_password_user>" and password "<email_pass>" 
	And I close other tabs 
	Then The element "gmail.reset_password_button" should be shown in gmail 
	When I click "gmail.reset_password_button" and switch to the second tab 
	And I fill value "<new_password>" to "forget_password.password_textbox" textbox 
	And I click "forgot_password.change_password_button" 
	Then I should see the message "Please enter a valid password. Use at least 6 characters, and don't use spaces." 
	
	Examples: 
		|	forgot_password_user|	email_pass						|	new_password	|	
		|	googlefreeuser			| googleunverifiedpass	| contain space |

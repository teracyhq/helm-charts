@test1 
Feature: Log in 

	As a user,
  I want to log in Iorad
  so that I can use the features of Iorad.

Background: 
	Given I am an anonymous user 
	
@smoke 
Scenario: log in with valid username and password & user has tutorials in My Tutorials 
	Given I logged in iroad with user "googlefreeverifieduseruser" and password "validpassword" 
	Then I should be redirected to the "/tutorials" page 
	And The element "tutorials.current_my_tutorial_tab" should be shown 
	
	#==> expected: after login then I should be redirected to the Shared tab
	#==> actual: after login, redirected to the Choose page
@smoke @fail 
Scenario: check redirection when user has no tutorials in My Tutorials 
	Given I logged in iroad with user "teammemberuser" and password "validpassword" 
	When Clear all my tutorials 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "decreaseuser1" and password "validpassword" 
	Then I should be redirected to the "/tutorials" page 
	And The element "tutorials.current_shared_tab" should be shown 
	
	#==> expected: after login then I should be redirected to the Shared tab
	#==> actual: after login, redirected to the Choose page
@smoke @fail 
Scenario: check redirection when the member has tutorials in Shared Edit only 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I go to "/tutorials" 
	When Clear all my tutorials and shared tutorials 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "decreaseuser1" and password "validpassword" 
	Then I should be redirected to the "/tutorials" page 
	And The element "tutorials.current_share_edit_tab" should be shown 
	
	#==> expected: I should not see Shared tabs
	#==> actual: still see Shared tabs
@smoke @chrome @fail 
Scenario: check redirection when user has no tutorials in Tutorials 
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	When I go to "/tutorials" 
	When Clear all my tutorials 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	When switch to "signup.iframe_choose_mode" frame 
	Then The element "signup.choose_mode_tab" should be shown 
	When I go to "/tutorials" 
	And The element "tutorials.share_edit_tab" should not be shown 
	And The element "tutorials.shared_tab" should not be shown 
	
	#can not automaticly install iorad app
@smoke @firefox, @safari @IE11 @wip 
Scenario: check redirection when user has no tutorials in Tutorials & iorad app installed 
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	When I go to "/tutorials" 
	When Clear all my tutorials 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	Then I should be redirected to the Connecting page 
	#    And The capture frame should launch
	
	#==> expected: I should be redirected to the Download page but
	#==> Actual: redirected to the Choose mode page
@smoke @firefox, @safari @IE11 @fail 
Scenario: check redirection when user has no tutorials in Tutorials & iorad app uninstalled 
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	When I go to "/tutorials" 
	When Clear all my tutorials 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	Then The element "signup.download_button" should be shown 
	
Scenario: log in with empty email/password 
	Given I go to "/login" 
	When I fill value "test@gmail.com" to "login.email" textbox 
	When I fill value "" to "login.email" textbox 
	When I fill value "" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the message "Please enter your email." 
	And I should see the message "Please enter your password." 
	
Scenario Outline: log in with wrong email format 
	Given I go to "/login" 
	When I fill value "<wrong_email_format>" to "login.email" textbox 
	When I fill value "<password>" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the message "Please enter a valid email address." 
	
	Examples: 
		| wrong_email_format          | password |
		| invalid_email_format@abcxyz |   123456 |
		
Scenario Outline: log in with incorrect email 
	Given I go to "/login" 
	When I fill value "<incorrect_email>" to "login.email" textbox 
	When I fill value "<correct_password>" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the message "Email / password combination is not valid." 
	
	Examples: 
		| incorrect_email         | correct_password |
		| invalid_email@gmail.com |           123456 |
		
Scenario Outline: log in with incorrect password 
	Given I go to "/login" 
	When I fill value "<correct_email>" to "login.email" textbox 
	When I fill value "<incorrect_password>" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the message "Email / password combination is not valid." 
	
	Examples: 
		| correct_email  | incorrect_password |
		| teammemberuser |           12345678 |
		
Scenario: check the links on Log In page 
	Given I am at "/login" 
	And I click "left_menu.left_menu_icon" 
	When I click "left_menu.signin" 
	Then I should be redirected to the "/login" page 
	When I click "left_menu.signup" 
	Then I should be redirected to the "/signup" page 
	When I click "left_menu.live_pricing" 
	Then I should be redirected to the "/pricing" page 
	When I click "left_menu.about_us" 
	Then I should be redirected to the "/about" page 
	When I click "left_menu.contact_us" 
	Then I should be redirected to the "/contactus" page 
	When I click "left_menu.faq" 
	Then I should be redirected to the "/faq" page 
	When I click "left_menu.terms" 
	Then I should be redirected to the "/termsconditions" page 
	When I click "left_menu.privacy_policy" 
	Then I should be redirected to the "/privacypolicy" page 
	
Scenario: Open/close the left panel 
	Given I am at "/login" 
	When I click "left_menu.left_menu_icon" 
	Then The "left_menu.left_menu_panel" should be visible 
	And The "left_menu.signin" should be visible 
	When I click "left_menu.left_menu_icon" 
	Then The "left_menu.left_menu_panel" should be invisible 
	And The "left_menu.signin" should be invisible 
	
	# 2 below scenarioes can't be automated because each running time, 
	# it starts a new clean browser, so the previous session isn't remembered
@pending @fail 
Scenario: Log in with the "Remember me" checked 
	Given I am at "/login" 
	When I log in with the "Remember me" checked 
	And I close the browser 
	And I return to the web 
	Then I should be redirected to My Tutorials page 
	
@pending @fail 
Scenario: Log in with the "Remember me" unchecked 
	Given I am at "/login" 
	When I log in with the Remember me" unchecked 
	And I close the browser 
	And I return to the web 
	Then I should be redirected to "/login" 
	
Scenario Outline: check the left menu for free user 
	Given I logged in iroad with user "<free_user>" and password "<password>" 
	When I click "left_menu.left_menu_icon" 
	Then The "left_menu.capture" should be visible 
	And The "left_menu.tutorials" should be visible 
	And The "left_menu.account" should be visible 
	And The "left_menu.upgrade_plan" should be visible 
	And The "left_menu.connect" should be visible 
	And The "left_menu.contact_us" should be visible 
	And The "left_menu.privacy_policy" should be visible 
	And The "left_menu.faq" should be visible 
	And The "left_menu.logout" should be visible 
	And The element "left_menu.creators" should not be shown 
	
	Examples: 
		| free_user        | password      |
		| freeverifieduser | validpassword |
		
Scenario Outline: check the left menu for a team owner 
	Given I logged in iroad with user "<team_owner>" and password "<password>" 
	When I click "left_menu.left_menu_icon" 
	Then The "left_menu.capture" should be visible 
	And The "left_menu.tutorials" should be visible 
	And The "left_menu.account" should be visible 
	And The "left_menu.creators" should be visible 
	And The "left_menu.connect" should be visible 
	And The "left_menu.contact_us" should be visible 
	And The "left_menu.privacy_policy" should be visible 
	And The "left_menu.faq" should be visible 
	And The "left_menu.logout" should be visible 
	
	Examples: 
		| team_owner    | password      |
		| teamowneruser | validpassword |
		
Scenario Outline: check the left menu for a premium user as individual 
	Given I logged in iroad with user "<individual_premium_user>" and password "<password>" 
	When I click "left_menu.left_menu_icon" 
	Then The "left_menu.capture" should be visible 
	And The "left_menu.tutorials" should be visible 
	And The "left_menu.account" should be visible 
	And The "left_menu.connect" should be visible 
	And The "left_menu.contact_us" should be visible 
	And The "left_menu.privacy_policy" should be visible 
	And The "left_menu.faq" should be visible 
	And The "left_menu.logout" should be visible 
	And The element "left_menu.creators" should not be shown 
	
	Examples: 
		| individual_premium_user     | password      |
		| premiumindividualuser2 | validpassword |
		
Scenario Outline: check the left menu for a team member 
	Given I logged in iroad with user "<team_member>" and password "<password>" 
	When I click "left_menu.left_menu_icon" 
	Then The "left_menu.capture" should be visible 
	And The "left_menu.tutorials" should be visible 
	And The "left_menu.account" should be visible 
	And The "left_menu.connect" should be visible 
	And The "left_menu.contact_us" should be visible 
	And The "left_menu.privacy_policy" should be visible 
	And The "left_menu.faq" should be visible 
	And The "left_menu.logout" should be visible 
	And The element "left_menu.upgrade_plan" should not be shown 
	And The element "left_menu.change_plan" should not be shown 
	
	Examples: 
		| team_member    | password      |
		| teammemberuser | validpassword |

@test1 
Feature: Sign Up 
	As a user,
  I want to create an account,
  so that I could use the features of Iorad.

Background: 
	Given I am an anonymous user 
	
@smoke @chrome 
Scenario: Sign up with valid values with chrome browser 
	Given I go to "/signup" 
	Then The "signup.signup_button" should be disabled 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value "validpassword" to "signup.password" textbox 
	When I click "signup.terms" 
	Then The "signup.signup_button" should be enabled 
	When I click "signup.signup_button" 
	When switch to "signup.iframe_choose_mode" frame 
	Then The element "signup.choose_mode_tab" should be shown 
	When Open gmail with user "signup.gmail_unverified_user" and password "signup.gmail_unverified_password" 
	And I close other tabs 
	Then The element "signup.verify_user_link" should be shown in gmail 
	When I click "signup.verify_user_link" and switch to the second tab 
	Then I should be redirected to the "/tutorials" 
	Then I should see the message "Thanks. You're good to go." 
	
	#==> expected: I should be redirected to the Download page but
	#==> Actual: redirected to the Choose mode page
@smoke @firefox @safari @fail 
Scenario: Sign up with valid values with firefox browser 
	Given I go to "/signup" 
	Then The "signup.signup_button" should be disabled 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value "validpassword" to "signup.password" textbox 
	When I click "signup.terms" 
	Then The "signup.signup_button" should be enabled 
	When I click "signup.signup_button" 
	When switch to "signup.iframe_choose_mode" frame 
	#Then The element "signup.download_button" should be shown
	When Open gmail with user "signup.gmail_unverified_user" and password "signup.gmail_unverified_password" 
	And I close other tabs 
	Then The element "signup.verify_user_link" should be shown in gmail 
	When I click "signup.verify_user_link" and switch to the second tab 
	Then I should be redirected to the "/tutorials" 
	Then I should see the message "Thanks. You're good to go." 
	
# @currently not supported
# Check Next and Skip on each guide
@functional @wip @pending
Scenario: new user goes to Learning tab at first time 
	Given I've just signed up 
	When I go to Your Learning tab at the first time 
	Then I should see the message "Click New Tutorial to get started." 
	And I should see "iorad guide" 
	And I should see two buttons "Skip" and "Nex" 
	And The iorad guide arrow points to "How iorad works" tutorial 
	When I click "Skip" 
	Then The iorad gui"de should be closed 
	When I click "Next" 
	Then I should be redirected to the next guide pointing to "New Tutorial" button 
	And I should see Next and Skip buttons 
	When I click "Next" 
	Then I should go to the next guide pointing to "Your Learning" 
	And I should see Next and Skip buttons 
	When I click "Next" 
	Then I should see the next guide pointing to "Your Tutorials" 
	And I should see "Done" button 
	When I click "Done" 
	Then The iorad guide should be closed 
	
@functional
Scenario: Create account with empty or space-key Public Name 
	Given I go to "/signup" 
	When I fill value "test" to "signup.public_name" textbox 
	When I fill value " " to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value "123456" to "signup.password_signup" textbox 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should see the message "Please enter your public name." 
	
@functional
Scenario: Create account without Email 
	Given I go to "/signup" 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "test@gmail.com" to "signup.email" textbox 
	When I fill value "" to "signup.email" textbox 
	When I fill value "validpassword" to "signup.password_signup" textbox 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should see the message "Please enter your email." 
	
@functional
Scenario: Create account with invalid Email 
	Given I go to "/signup" 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value "{!auto,s5,n5,!@gmail}" to "signup.email" textbox 
	When I fill value "validpassword" to "signup.password_signup" textbox 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should see the message "Please enter a valid email address." 
	
Scenario: Create account with existing Email 
	Given I go to "/signup" 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "freeverifieduser" to "signup.email" textbox 
	When I fill value "validpassword" to "signup.password_signup" textbox 
	When I click "signup.password_signup" 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should see the message "Email address already in use." 
	
@functional 
Scenario: Create account without password 
	Given I go to "/signup" 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value " " to "signup.password_signup" textbox 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should see the message "Please enter a valid password. Use at least 6 characters, and don't use spaces." 
	
@functional 
Scenario: Create account with password having space keys 
	Given I go to "/signup" 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value "{!au to,s5,n5}" to "signup.password_signup" textbox 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should see the message "Please enter a valid password. Use at least 6 characters, and don't use spaces." 
	
@functional 
Scenario: Create account with less 6 character password length 
	Given I go to "/signup" 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value "12345" to "signup.password_signup" textbox 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should see the message "Please enter a valid password. Use at least 6 characters, and don't use spaces." 
	
@functional 
Scenario: Create account with more than 16 characters password length 
	Given I go to "/signup" 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value "{n17}" to "signup.password_signup" textbox 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should see the message "Password should not be more than 16 characters." 
	
@functional 
Scenario: Redirect to pricing page after signing up 
	Given I am an anonymous user 
	When I click "left_menu.left_menu_icon" 
	When I click "left_menu.live_pricing" 
	Then I should be redirected to the "/pricing" page 
	And I click "pricing.go_live_button" 
	Then The element "login.login_tab" should be shown 
	When I click "signup.signup_tab" 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "signup.email" textbox 
	When I fill value "123456" to "signup.password_signup" textbox 
	When I click "signup.terms" 
	When I click "signup.signup_button" 
	Then I should be redirected to the "/checkout" page 
	
@functional 
Scenario: check the link Terms & Privacy Policy 
	Given I go to "/signup" 
	When I click "signup.terms_&_privacy_policy_link" 
	Then I should be redirected to the "/termsconditions" page 
	
@functional
Scenario: check the links on Sign Up page 
	Given I am at the "/signup" page 
	When I click "left_menu.left_menu_icon" 
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
	
  
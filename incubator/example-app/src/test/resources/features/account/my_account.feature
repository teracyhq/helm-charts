@test1 
Feature: My Account is used for personal Settings 

	As a logged-in user, 
	I want to access My Account page 
	so that I could view and update my personal information, including Full Name,
	Public Nam, Company, Email, change password, and avatar 
	sc
@smoke 
Scenario: Access My Account page as a verified user 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link" 
	Then The element "my_account.full_name" should be shown 
	Then The element "my_account.public_name" should be shown 
	Then The element "my_account.company_name" should be shown 
	Then The element "my_account.email" should be shown 
	Then The element "my_account.avatar" should be shown 
	Then The element "my_account.vat_name" should be shown 
	Then The element "my_account.address" should be shown 
	Then The element "my_account.change_password_button" should be shown 
	Then The element "my_account.deactive_account_button" should be shown 
	
@smoke 
Scenario: view account summary of an unverified user 
	Given I logged in iroad with user "unverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link" 
	Then The element "my_account.full_name" should be shown 
	Then The element "my_account.public_name" should be shown 
	Then The element "my_account.company_name" should be shown 
	Then The element "my_account.email" should be shown 
	Then The element "my_account.avatar" should be shown 
	Then The element "my_account.vat_name" should be shown 
	Then The element "my_account.address" should be shown 
	Then The element "my_account.change_password_button" should be shown 
	Then The element "my_account.deactive_account_button" should be shown 
	
@function
Scenario: Check Change password button for gmail user 
	Given I logged in iroad with my gmail with user "googlepremiumindividualuser" and password "googlepremiumindividualpass"
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	Then The element "my_account.full_name" should be shown 
	Then The element "my_account.public_name" should be shown 
	Then The element "my_account.company_name" should be shown 
	Then The element "my_account.email" should be shown 
	Then The element "my_account.avatar" should be shown 
	Then The element "my_account.vat_name" should be shown 
	Then The element "my_account.address" should be shown 
	Then The element "my_account.change_password_button" should not be shown 
	Then The element "my_account.deactive_account_button" should be shown 
	
@function
Scenario: resend email verification when current plan is unverified 
	Given I logged in iroad with user "unverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	Then The element "my_account.unverified_status_account" should be shown 
	Then The element "my_account.resend_link" should be shown 
	When I click "my_account.resend_link"
	Then I should see the message "Verification email sent."
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	When Open gmail with user "unverifieduser" and password "googleunverifiedpass"
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link" and switch to the second tab
	Then I should be redirected to the "/login"
    Then The element "login.login_button" should be shown
    Then The element "login.email" should be shown
    Then The element "login.password" should be shown
    When I fill value "unverifieduser" to "login.email" textbox
    When I fill value "validpassword" to "login.password" textbox
    And I click "login.login_button"
    When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	Then The element "my_account.unverified_status_account" should not be shown 
	Then The element "my_account.resend_link" should not be shown 
	
@function
Scenario: Full Name is empty 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	And Store the value of element "my_account.full_name" in variable "beforefullname"
	When I fill value " " to "my_account.full_name" textbox 
	And I press Enter 
	Then I should see the message "Full Name is required"
	And I click "my_plan.my_plan_link"
	And I click "my_account.my_account_link"
	And Store the value of element "my_account.full_name" in variable "afterfullname"
	Then The variable "beforefullname" should be equal to variable "afterfullname"
	
@function
Scenario: Public Name is empty 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	And Store the value of element "my_account.public_name" in variable "beforepublicname"
	When I fill value " " to "my_account.public_name" textbox 
	And I press Enter 
	Then I should see the message "Public Name is required"
	And I click "my_plan.my_plan_link"
	And I click "my_account.my_account_link"
	And Store the value of element "my_account.public_name" in variable "afterpublicname"
	Then The variable "beforepublicname" should be equal to variable "afterpublicname"

@function
Scenario: update Company Name 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I fill value "newcompany" to "my_account.company_name" textbox
	And I press Enter 
	And I should see the message "Company Updated" 

@function	
Scenario: update Email 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.email"
	Then I should see the message "Sorry you can't change your email address."

@function
Scenario: keep Company name empty 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I fill value " " to "my_account.company_name" textbox
	And I press Enter 
	And I should see the message "Company Updated" 
	
@function
Scenario: update VAT Number / Address 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I fill value "newvat" to "my_account.vat_name" textbox 
	And I press Enter 
	And I should see the message "VAT Number Updated" 
	When I fill value "newaddress" to "my_account.address" textbox 
	And I press Enter
	And I should see the message "Address Updated" 
	
@function
Scenario: keep VAT Number / Address empty 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I fill value "" to "my_account.vat_name" textbox 
	And I press Enter 
	And I should not see the message "VAT Number Updated" 
	When I fill value "" to "my_account.address" textbox 
	And I press Enter
	And I should not see the message "Address Updated" 
	
@function
Scenario: change password with valid values 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	When I fill value "validpassword" to "my_account.current_password" textbox 
	When I fill value "validpassword" to "my_account.new_password" textbox 
	When I fill value "validpassword" to "my_account.retype_new_password" textbox
	When I click "my_account.save_changes_button"
	And I should see the message "You're all set. Your password has been changed." 
	
@function
Scenario: change password with empty values 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	When I click "my_account.current_password"
	When I click "my_account.new_password"
	Then I should see the message "Please enter your password." 
	
@function
Scenario: change password with illegal characters in current password 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	When I fill value "1" to "my_account.current_password" textbox 
	When I fill value "validpassword" to "my_account.new_password" textbox 
	When I fill value "validpassword" to "my_account.retype_new_password" textbox
	When I click "my_account.save_changes_button"
	Then I should see the message "Current password incorrect" 

@function
Scenario: change password with illegal characters in new password 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	When I fill value "  " to "my_account.new_password" textbox 
	And I move the mouse to another place 
	Then I should see the error message "Please enter a valid password. Use at least 6 characters, and don't use spaces." 
	And The "my_account.save_changes_button" should be disabled
	
@function
Scenario: change password with mismatched new pw and confirm pw 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	When I fill value "validpassword" to "my_account.current_password" textbox 
	When I fill value "validpassword" to "my_account.new_password" textbox 
	When I fill value "validpassword1" to "my_account.retype_new_password" textbox 
	Then I should see the message "Passwords do not match" 
	And The "my_account.save_changes_button" should be disabled 
	
@function
Scenario: change password with incorrect current password 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	When I fill value "invalidpassword" to "my_account.current_password" textbox 
	When I fill value "validpassword" to "my_account.new_password" textbox 
	When I fill value "validpassword" to "my_account.retype_new_password" textbox
	When I click "my_account.save_changes_button"
	Then I should see the message "Current password incorrect" 

@function
Scenario: change password with less than 6 character in new password 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	When I fill value "12345" to "my_account.new_password" textbox 
	And I move the mouse to another place 
	Then I should see the error message "Please enter a valid password. Use at least 6 characters, and don't use spaces." 
	And The "my_account.save_changes_button" should be disabled
	
@function
Scenario: change password with more 16 characters 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	When I fill value "12345678901234567" to "my_account.new_password" textbox 
	And I move the mouse to another place 
	Then I should see the error message "Password should not be more than 16 characters." 
	
@function
Scenario: cancel changing password by Close button 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.change_password_button" 
	Then The element "my_account.current_password" should be shown 
	Then The element "my_account.new_password" should be shown 
	Then The element "my_account.retype_new_password" should be shown 
	When I click "my_account.x_icon"
	Then The element "my_account.current_password" should not be shown 
	Then The element "my_account.new_password" should not be shown 
	Then The element "my_account.retype_new_password" should not be shown 
	Then The element "my_account.full_name" should be shown 
	Then The element "my_account.public_name" should be shown 
	Then The element "my_account.company_name" should be shown 
	Then The element "my_account.email" should be shown 
	Then The element "my_account.avatar" should be shown 
	Then The element "my_account.vat_name" should be shown 
	Then The element "my_account.address" should be shown 
	Then The element "my_account.change_password_button" should be shown 
	Then The element "my_account.deactive_account_button" should be shown
	
@function
Scenario: deactivate account with empty password 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button"
	Then I should see the message "Enter your password below to delete your account."
	And I click "my_account.delete_account.delete_account_button" 
	Then I should see the message "Password incorrect." 
	
@function
Scenario: deactivate account with incorrect password 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button"
	Then I should see the message "Enter your password below to delete your account."
	When I fill value "oldpass" to "my_account.delete_account.confirm_password" textbox
	And I click "my_account.delete_account.delete_account_button" 
	Then I should see the message "Password incorrect." 
	
@function
Scenario: cancel deactivating account with Cancel link 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button" 
	Then I should see the message "Enter your password below to delete your account."
	When I click "my_account.cancel_button" 
	Then I should not see the message "Enter your password below to delete your account."
	
@function
Scenario: cancel deactivating account with X icon 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button"
	Then I should see the message "Enter your password below to delete your account."
	When I click "my_account.x_icon" 
	Then I should not see the message "Enter your password below to delete your account."
	
@function
Scenario: Google users - Deactivate account with empty info 
	Given I logged in iroad with my gmail with user "googlepremiumindividualuser" and password "googlepremiumindividualpass"
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button"
	When I fill value " " to "my_account.delete_account.confirm_email" textbox 
	And I click "my_account.delete_account.delete_account_button" 
	Then I should see the message "Email incorrect." 
	
@function
Scenario: Google users - Deactivate account with invalid email 
	Given I logged in iroad with my gmail with user "googlepremiumindividualuser" and password "googlepremiumindividualpass"
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button" 
	When I fill value "test@gmail.com" to "my_account.delete_account.confirm_email" textbox 
	And I click "my_account.delete_account.delete_account_button" 
	Then I should see the message "Email incorrect." 
	
@function
Scenario: Google users - incorrect email 
	Given I logged in iroad with my gmail with user "googlepremiumindividualuser" and password "googlepremiumindividualpass"
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button" 
	When I fill value "test" to "my_account.delete_account.confirm_email" textbox 
	And I click "my_account.delete_account.delete_account_button" 
	Then I should see the message "Email incorrect." 

@function
Scenario: Google users - cancel deactivate email with X/Cancel button 
	Given I logged in iroad with my gmail with user "googlepremiumindividualuser" and password "googlepremiumindividualpass"
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button"
	Then The element "my_account.delete_account.confirm_email" should be shown 
	When I click "my_account.x_icon" 
	Then The element "my_account.delete_account.confirm_email" should not be shown 
	
@function
Scenario: deactivate account with valid password 
	Given I logged in iroad with user "deactiveuserbypassword" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button"
	Then The element "my_account.full_name" should be shown 
	When I fill value "validpassword" to "my_account.delete_account.confirm_password" textbox 
	And I click "my_account.delete_account.delete_account_button" 
	Then I should be logged out and redirected to the home page
	When Open gmail with user "deactiveuserbypassword" and password "signup.gmail_verify_password"
	Then The element "gmail.delete_account_button" should be shown in gmail 
	When I click "gmail.delete_account_button" and switch to the second tab
	Then I should see the message "We're sorry to see you go. Your account has been deleted."
	Given I am at "/login" 
	When I fill value "freeverifieduser" to "login.email" textbox
    When I fill value "validpassword" to "login.password" textbox
    And I click "login.login_button"
    Then I should see the message "Email / password combination is not valid."
	
@function
Scenario: Google user - Deactivate account with valid email 
	Given I logged in iroad with my gmail with user "deactiveuserbypasswordbyemail2" and password "googlepremiumindividualpass"
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When I click "my_account.deactive_account_button"
	When I fill value "deactiveuserbypasswordbyemail2" to "my_account.delete_account.confirm_email" textbox 
	And I click "my_account.delete_account.delete_account_button" 
	When Open gmail with user "deactiveuserbypasswordbyemail2" and password "googlepremiumindividualpass"
	Then The element "gmail.delete_account_button" should be shown in gmail 
	When I click "gmail.delete_account_button" and switch to the second tab
	Then I should see the message "We're sorry to see you go. Your account has been deleted."
	
#can not check avatar
@function @wip
Scenario: change avatar with the origin size of the image 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When upload file "/src/test/resources/testdata/pic1.jpeg"
	Then I click "my_account.done_avatar_button"
	
#can not check avatar
@function @wip
Scenario: change avatar with image cropped 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When upload file "/src/test/resources/testdata/pic1.jpeg"
	Then I click "my_account.crop_avatar_button"
	
#can not check avatar
@function @wip
Scenario: change avatar with invalid file 
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	And I navigate to the "my_account.my_account_link"
	When upload file "/src/test/resources/testdata/pic1.jpeg"
	Then I should see the message "Invalid extension, supported types are png, jpeg, jpg." 

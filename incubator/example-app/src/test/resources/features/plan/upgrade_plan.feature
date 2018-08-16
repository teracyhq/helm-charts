@test5
Feature: Upgrade plan 

	As a free user,
    I want to upgrade plan
    so I could use the features of a premium plan.
	
	#https://github.com/iorad/iorad/issues/4588
@smoke
Scenario: Upgrade an individual plan 
	Given I logged in iroad with user "upplanverifieduser" and password "validpassword" 
	When I click on the "left_menu.upgrade_plan" on the left panel 
	Then I should be redirected to the "/pricing" page 
	When I click "pricing.go_private_button" 
	Then I should be redirected to the "/checkout/private" page 
	When I click on the "left_menu.upgrade_plan" on the left panel 
	When I click "pricing.go_premium_button" 
	Then I should be redirected to the "/checkout/premium" page 
	When I click on the "left_menu.upgrade_plan" on the left panel 
	When I click "pricing.go_live_button" 
	Then I should be redirected to the "/checkout/live" page 
	And The "checkout.checkout_button" should be disabled 
	And The element "checkout.monthly_checked" should be shown
	When I fill value "checkout.card_number_value" to "checkout.card_number" textbox 
	When I fill value "checkout.expdate_value" to "checkout.expdate" textbox 
	When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
	Then The "checkout.checkout_button" should be enabled 
	When I click "checkout.checkout_button" 
	Then I should be redirected to Thank You page 
	And The element "left_menu.upgrade_plan" should not be shown 
	
	
	#https://github.com/iorad/iorad/issues/4588
@smoke
Scenario: Upgrade a team plan (2) 
	Given I logged in iroad with user "upplanverifieduser1" and password "validpassword" 
	When I click on the "left_menu.upgrade_plan" on the left panel 
	Then I should be redirected to the "/pricing" page 
	When I click "pricing.go_private_button" 
	Then I should be redirected to the "/checkout/private" page 
	When I click on the "left_menu.upgrade_plan" on the left panel 
	When I click "pricing.go_premium_button" 
	Then I should be redirected to the "/checkout/premium" page 
	When I click on the "left_menu.upgrade_plan" on the left panel 
	When I click "pricing.go_live_button" 
	Then I should be redirected to the "/checkout/live" page 
	And The "checkout.checkout_button" should be disabled 
	And The element "checkout.monthly_checked" should be shown
	When I click "checkout.more_creator_button" 
	When I fill value "checkout.card_number_value" to "checkout.card_number" textbox 
	When I fill value "checkout.expdate_value" to "checkout.expdate" textbox 
	When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
	Then The "checkout.checkout_button" should be enabled 
	When I click "checkout.checkout_button" 
	Then I should be redirected to Thank You page 
	And The element "left_menu.upgrade_plan" should not be shown 
	
	
@smoke
Scenario: Unverified user upgrades plan (3) 
	Given I logged in iroad with user "upplanunverifieduser" and password "upplanunverifieduserpass" 
	And I am at "/checkout" page 
	When I fill value "checkout.card_number_value" to "checkout.card_number" textbox 
	When I fill value "checkout.expdate_value" to "checkout.expdate" textbox 
	When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
	And I click "checkout.checkout_button" 
	Then I should see the message "I know you're in a hurry, but you'll need to verify your email address." 
	Then I should see the message "Resend" 
	And The element "checkout.checkout_button" should be shown 
	When I click "left_menu.left_menu_icon" 
	And The element "left_menu.upgrade_plan" should be shown 
	And The element "left_menu.change_plan" should not be shown 
	When I click "checkout.resend_link" 
	And I should see the message "Verification email sent." 
	When Open gmail with user "gmailupplanunverifieduser" and password "gmailupplanunverifieduserpass" 
	Then The element "signup.verify_user_link" should be shown in gmail 
	
@functional
Scenario: check the links on the /pricing page 
	Given I logged in iroad with user "upplanverifieduser" and password "validpassword" 
	And I am at "/pricing" page
	When I click "pricing.contact_us_button" 
	Then I should be redirected to the "/contactus" page 
	And I am at "/pricing" page
	When I click "pricing.faq_button" 
	Then I should be redirected to the "/faq" page 
	And The element "pricing.pricing_faqs_content" should be shown 
	
@functional
Scenario: open/close the left panel on the pricing page 
	Given I logged in iroad with user "upplanverifieduser" and password "validpassword" 
	And I am at "/pricing" page
	When I click by javascript "left_menu.left_menu_icon" 
	Then The element "left_menu.left_menu_panel" should be shown 
	When I click "left_menu.close_left_menu_icon" 
	Then The element "left_menu.left_menu_panel" should not be shown 
	
#can not automaticly install iorad app and iorad extension
@chrome @functional @wip
Scenario: check the Capture button on the Thank You page 
	Given I logged in iroad with user "upplanverifieduser" and password "validpassword" 
	And I am at "/pricing" page
	When I click "Capture" button 
	Then I should be redirected to the Choose page 
	
#can not automaticly install iorad app and iorad extension
@firefox @IE11 @safari @functional @wip
Scenario: check the Capture button on the Thank You page when iorad app's installed 
	Given I already subscribed the individual plan 
	And I am at the Thank You page 
	And I have installed iorad app 
	When I click "Capture" button 
	Then I should be redirected to the Connecting page 
	And The capture framework should be launched 
	
#can not automaticly install iorad app and iorad extension
@firefox @IE11 @safari @functional @wip
Scenario: check the Capture button on the Thank You page when iorad app's not installed yet 
	Given I already subscribed the individual plan 
	And I am at the Thank You page 
	And I haven't installed iorad app yet 
	When I click "Capture" button 
	Then I should be redirected to the Downloading page 
	
@functional
Scenario: Do payment with invalid cc number 
	Given I logged in iroad with user "freeverifieduser" and password "upplanunverifieduserpass" 
	And I am at "/checkout" page 
	When I fill value "checkout.card_number_invalue" to "checkout.card_number" textbox 
	When I fill value "checkout.expdate_value" to "checkout.expdate" textbox 
	When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
	Then The "checkout.checkout_button" should be enabled 
	When I click "checkout.checkout_button" 
	Then I should see the message "Your card number is incorrect."  
	
@functional
Scenario: Do payment with invalid expiration date 
	Given I logged in iroad with user "freeverifieduser" and password "upplanunverifieduserpass" 
	And I am at "/checkout" page 
	When I fill value "checkout.card_number_value" to "checkout.card_number" textbox 
	When I fill value "09/16" to "checkout.expdate" textbox 
	When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
	Then The "checkout.checkout_button" should be enabled 
	When I click "checkout.checkout_button" 
	Then I should see the message "Your card's expiration year is invalid."
	
#check on production
# do not have locked card
@functional @wip
Scenario: Check the payment failed due to credit card declined 
	Given I logged in iroad with user "upplanunverifieduser" and password "upplanunverifieduserpass" 
	And I am at "/checkout" page 
	And My card is locked 
	When I input the cc info into all the required field 
	And I click "Checkout" 
	Then An error message should be shown "Your card was declined." 
	
@functional
Scenario: check the stripe link on the checkout page 
	Given I logged in iroad with user "upplanunverifieduser" and password "upplanunverifieduserpass" 
	And I am at "/checkout" page 
	When I click "checkout.stripe_link" 
	Then I should be redirected to the "https://stripe.com/" page in new tab  
	
@functional
Scenario: check the question links on the checkout page 
	Given I logged in iroad with user "upplanunverifieduser" and password "upplanunverifieduserpass" 
	And I am at "/checkout" page 
	When I click "checkout.pricing_faq_link"
	Then I should be redirected to the "/pricing" page 
	
@functional
Scenario: open/close the left panel on the checkout page 
	Given I logged in iroad with user "upplanunverifieduser" and password "upplanunverifieduserpass" 
	And I am at "/checkout" page 
	When I click by javascript "left_menu.left_menu_icon" 
	Then The element "left_menu.left_menu_panel" should be shown 
	When I click "left_menu.close_left_menu_icon" 
	Then The element "left_menu.left_menu_panel" should not be shown 
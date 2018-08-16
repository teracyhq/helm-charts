@test6
Feature: Downgrade the plan into free 

	As a premium plan user,
    I want to cancel subscription
    so I don't have to pay more for the plan
	
	# run the schedule task with the link for Single User http://test.iorad.com/api/actScheduledDowngradePlan?test=manualRun&userIds=1
@smoke
Scenario: cancel subscription with correct password when there is a pending decrease request 
	Given I logged in iroad with user "cancelinguser3" and password "validpassword" 
	When I get checkout date and store in variable "checkoutDateVar"
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.less_creator_button"
	When I click "checkout.checkout_button"
	When Wait for 5 seconds
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	And I should see the nofification "Your last downgrade request is already pending."
	When I fill value "validpassword" to "checkout.confirm_password_textbox" textbox 
	When I click "checkkout.cancel_subscription_button" 
	When Wait for 8 seconds
	And I should see the nofification "Your last downgrade request is already pending."
	When Wait for 5 seconds
	And I should see the nofification "Your account will convert to the Free Public Plan on" "checkoutDateVar"
	When I click "checkout.cancel_feedback_form.first_checkbox"
	When I click "checkout.cancel_feedback_form.submit_button"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.free_plan_price_0" should be shown 
	When I click "checkout.three_dot_icon" 
	Then The element "checkout.awaiting_downgrade_link" should be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should not be shown  
	When I run schedule task 
	Given I logged in iroad with user "cancelinguser3" and password "validpassword" 
	Then My plan should be changed into free 
	
@smoke
Scenario: gmail users cancel susbcription with correct email, and no pending request 
	Given I logged in iroad with my gmail with user "googlepremiumindividualuser" and password "googlepremiumindividualpass"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown
	#get checkout date
	When I get checkout date and store in variable "checkoutDateVar"
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	When I fill value "googlepremiumindividualuser" to "checkout.email_to_confirm_textbox" textbox 
	When I click "checkkout.cancel_subscription_button" 
	And I should see the nofification "Your account will convert to the Free Public Plan on" "checkoutDateVar"
	When I click "checkout.cancel_feedback_form.first_checkbox"
	When I click "checkout.cancel_feedback_form.submit_button"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.free_plan_price_0" should be shown 
	And I should see the nofification "Your account will convert to the Free Public Plan on" "checkoutDateVar"
	When I click "checkout.three_dot_icon" 
	Then The element "checkout.awaiting_downgrade_link" should be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should not be shown 
	When I run schedule task 
	When I logged in iroad with my gmail with user "googlepremiumindividualuser" and password "googlepremiumindividualpass"
	Then My plan should be changed into free 
	
@function
Scenario: Cancel subscription with incorrect password 
	Given I logged in iroad with user "cancelinguser3" and password "validpassword" 
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	Then I should be redirected to the confirmation page 
	When I fill value "invalidvalidpassword" to "checkout.confirm_password_textbox" textbox 
	When I click "checkkout.cancel_subscription_button" 
	Then I should see the nofification "Password incorrect." 
	
@function
Scenario: Cancel subscription with incorrect gmail 
	Given I logged in iroad with my gmail with user "googlepremiumindividualuser" and password "googlepremiumindividualpass" 
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	Then I should be redirected to the confirmation page 
	When I fill value "invalidvalidpassword" to "checkout.email_to_confirm_textbox" textbox 
	When I click "checkkout.cancel_subscription_button" 
	Then I should see the nofification "Email incorrect." 
	
@function
Scenario: Cancel "cancel subscription" 
	Given I logged in iroad with user "cancelinguser3" and password "validpassword" 
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	Then I should be redirected to the confirmation page 
	When I fill value "validpassword" to "checkout.confirm_password_textbox" textbox 
	When I click "checkout.cancel_cancel_subscription_icon" 
	Then The element "my_plan.current_my_plan_tab" should be shown 

@function
Scenario: Close the Feedback page without sending the feedback 
	Given I logged in iroad with user "cancelinguser3" and password "validpassword" 
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	Then I should be redirected to the confirmation page 
	When I fill value "validpassword" to "checkout.confirm_password_textbox" textbox 
	When I click "checkkout.cancel_subscription_button"
	When I click "checkout.close"
	Then I should be redirected to the My Tutorials
	
@function
Scenario: Reactivate the account from the My Plan tab 
	Given I logged in iroad with user "cancelinguser3" and password "validpassword" 
	When I get checkout date and store in variable "checkoutDateVar"
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.less_creator_button"
	When I click "checkout.checkout_button"
	When wait for 5 seconds
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	When I fill value "validpassword" to "checkout.confirm_password_textbox" textbox 
	When I click "checkkout.cancel_subscription_button" 
	When I click "checkout.cancel_feedback_form.first_checkbox"
	When I click "checkout.cancel_feedback_form.submit_button"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.free_plan_price_0" should be shown 
	When I click "checkout.three_dot_icon" 
	Then The element "checkout.awaiting_downgrade_link" should be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should not be shown  
	When I click "checkout.three_dot_icon" 
	When I click "checkout.reactivate_downgrade_plan"
	When wait for 5 seconds
	Then The element "checkout.awaiting_downgrade_link" should not be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should be shown
	Then The element "checkout.reactivate_downgrade_plan" should not be shown 
	Then The element "checkout.plan_information" should be shown 
	And I should see the nofification "Next invoice on" "checkoutDateVar"

@function
Scenario: Logged-in user Reactivate the account from the Cancel Subscription email 
	Given I logged in iroad with user "cancelinguser2" and password "validpassword" 
	When I get checkout date and store in variable "checkoutDateVar"
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.less_creator_button"
	When I click "checkout.checkout_button"
	When wait for 5 seconds
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	When I fill value "validpassword" to "checkout.confirm_password_textbox" textbox 
	When I click "checkkout.cancel_subscription_button" 
	When Open gmail with user "cancelinguser2" and password "validpassword" 
	And I close other tabs
	When I click on mail with title "checkout.gmail.cancel_mail_title" in gmail
	Then The element "checkout.gmail_reactive_link" should be shown in gmail
	When I click "checkout.gmail_reactive_link" and switch to the second tab
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.reactivate_downgrade_plan"
	Then The element "checkout.awaiting_downgrade_link" should not be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should be shown
	Then The element "checkout.reactivate_downgrade_plan" should not be shown 
	Then The element "checkout.plan_information" should be shown 
	And I should see the nofification "Next invoice on" "checkoutDateVar" 
	
@function
Scenario: Not-logged-in user reactivate the account from the Cancel Subscription email 
	Given I logged in iroad with user "cancelinguser3" and password "validpassword" 
	When I get checkout date and store in variable "checkoutDateVar"
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.less_creator_button"
	When I click "checkout.checkout_button"
	When wait for 5 seconds
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	When I fill value "validpassword" to "checkout.confirm_password_textbox" textbox 
	When I click "checkkout.cancel_subscription_button" 
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	When Open gmail with user "cancelinguser3" and password "validpassword" 
	And I close other tabs
	When I click on mail with title "checkout.gmail.cancel_mail_title" in gmail
	Then The element "checkout.gmail_reactive_link" should be shown in gmail
	When I click "checkout.gmail_reactive_link" and switch to the second tab
	Given I logged in iroad with user "cancelinguser3" and password "validpassword" 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.reactivate_downgrade_plan"
	Then The element "checkout.awaiting_downgrade_link" should not be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should be shown
	Then The element "checkout.reactivate_downgrade_plan" should not be shown 
	Then The element "checkout.plan_information" should be shown 
	And I should see the nofification "Next invoice on" "checkoutDateVar" 
	
@function
Scenario: Check the expired Reactivate Plan button in the email 
	Given I logged in iroad with user "cancelinguser1" and password "validpassword" 
	When I get checkout date and store in variable "checkoutDateVar"
	#go to change plan page to change plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I click "checkout.less_creator_button"
	When I click "checkout.checkout_button"
	When wait for 5 seconds
	When I click "checkout.three_dot_icon" 
	When I click "checkout.downgrade_plan_to_iorad_free_link" 
	When I fill value "validpassword" to "checkout.confirm_password_textbox" textbox 
	When I click "checkkout.cancel_subscription_button" 
	When I click "checkout.cancel_feedback_form.first_checkbox"
	When I click "checkout.cancel_feedback_form.submit_button"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.free_plan_price_0" should be shown 
	When I click "checkout.three_dot_icon" 
	Then The element "checkout.awaiting_downgrade_link" should be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should not be shown 
	When I click "checkout.three_dot_icon"  
	When I click "checkout.reactivate_downgrade_plan"
	When wait for 5 seconds
	Then The element "checkout.reactivate_downgrade_plan" should not be shown 
	Then The element "checkout.awaiting_downgrade_link" should not be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should be shown
	Then The element "checkout.reactivate_downgrade_plan" should not be shown 
	Then The element "checkout.plan_information" should be shown 
	When Open gmail with user "cancelinguser1" and password "validpassword" 
	And I close other tabs
	When I click on mail with title "checkout.gmail.cancel_mail_title" in gmail
	Then The element "checkout.gmail_reactive_link" should be shown in gmail
	When I click "checkout.gmail_reactive_link" and switch to the second tab 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The element "checkout.awaiting_downgrade_link" should not be shown 
	Then The element "checkout.downgrade_plan_to_iorad_free_link" should be shown
	Then The element "checkout.reactivate_downgrade_plan" should not be shown 
	Then The element "checkout.plan_information" should be shown 
	And I should see the nofification "Next invoice on" "checkoutDateVar" 
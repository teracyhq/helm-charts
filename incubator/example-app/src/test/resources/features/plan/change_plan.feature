@test1 
Feature: Change plan 

	As a premium plan user,
    I want to change my plan into another plan
    so I could use the features of the selected plan
	
@smoke
Scenario Outline: Change into another plan 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	Then The element "pricing.go_private_button" should be shown 
	Then The element "pricing.go_premium_button" should be shown 
	Then The element "pricing.go_live_button" should be shown 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content 
	Then I should see the "<new_plan>" 
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	And The "checkout.checkout_button" should be enabled 
	When I click "checkout.close_right_corner" 
	Then I should be redirected to the pricing page 
	Examples: 
		| user      | new_plan      | new_plan_button          |
		| monthlypremiumplanuser1      | Private Plan Checkout | pricing.go_private_button |
		| monthlypremiumplanuser1      | Live Plan Checkout | pricing.go_live_button |
		| yearlypremiumplanuser1      | Private Plan Checkout | pricing.go_private_button |
		| yearlypremiumplanuser1      | Live Plan Checkout | pricing.go_live_button |
		
#--> update again ==> can not descrease creator into 1
 @smoke @pending 
Scenario Outline: Change the plan from Monthly Private into Monthly Premium / Live 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content 
	And I decrease the creator number into 1 
	Then The current period should be checked 
	And Current subscription credit, New monthly subscription, Balance due right now should be shown 
	And The Balance due right should be equal to [Current subscription credit - Balance due right now] 
	Then I should see the "New monthly subscription" info 
	And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit" 
	When I click "checkout.checkout_button" 
	And The anniversary date should be today 
	And The notification "...." should be shown 
	And The billing history should be updated 
	Examples: 
		| user      | new_plan_button          |
		| monthlyprivateplanuser1      | pricing.go_private_button |
		| monthlyprivateplanuser2      | pricing.go_live_button |
				
# run the schedule task with the link for Single User http://test.iorad.com/api/actScheduledDowngradePlan?test=manualRun&userIds=1
@smoke
Scenario Outline: Change the plan from Annual Private into Monthly Premium / Live 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "old_number_billing_history"
	When I click "my_plan.my_plan_link"
	When I get checkout date and store in variable "old_annivesary"
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And I click "checkout.monthly"
	And Store the status of checkbox yearly in variable "new_var_yearly" 
	And Store the status of checkbox monthly in variable "new_var_monthly" 
	Then I should see the "New monthly subscription" info
	And The "Balance due right now" should be $0  
	#And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit"
	When I click "checkout.checkout_button" 
	And I should see the notify "Your plan changes will be effective on" variable "old_annivesary"
	#And I should see the message "Your plan has been updated"
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" 
	When I run schedule task 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And The variable "cur_var_yearly" should not be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should not be equal to variable "old_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "new_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "new_var_monthly" 
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "cur_number_billing_history"
	And The variable "cur_number_billing_history" should be equal to variable "old_number_billing_history" plus "1"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| yearlyprivateplanuser1      | pricing.go_premium_button |Private - Annual|Premium|
		| yearlyprivateplanuser2      | pricing.go_live_button |Private - Annual|Live|
	
@smoke
Scenario Outline: Change the plan from Yearly Premium into Yearly Live 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "old_number_billing_history"
	When I click "my_plan.my_plan_link"
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content 
	And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit"
	When I click "checkout.checkout_button" 
	And wait for 2 seconds
	And I should see the message "Your plan has been updated"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" plus "1"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| yearlypremiumplanuser2      | pricing.go_live_button |Premium - Annual|Live - Annual|
	
@smoke
Scenario Outline: Change the plan from  Monthly Premium into Yearly Private 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "old_number_billing_history"
	When I click "my_plan.my_plan_link"
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content 
	And I click "checkout.yearly"
	And Store the status of checkbox yearly in variable "new_var_yearly" 
	And Store the status of checkbox monthly in variable "new_var_monthly" 
	And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit"
	When I click "checkout.checkout_button" 
	And wait for 2 seconds
	And I should see the message "Your plan has been updated"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And The variable "cur_var_yearly" should not be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should not be equal to variable "old_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "new_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "new_var_monthly" 
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" plus "1"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| monthlypremiumplanuser2      | pricing.go_private_button |Premium|Private - Annual|
	
@smoke
Scenario Outline: Change the plan from Monthly Premium into Monthly Private 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "old_number_billing_history"
	When I click "my_plan.my_plan_link"
	When I get checkout date and store in variable "old_annivesary"
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And Store the status of checkbox yearly in variable "new_var_yearly" 
	And Store the status of checkbox monthly in variable "new_var_monthly" 
	Then I should see the "New monthly subscription" info
	And The "Balance due right now" should be $0  
	When I click "checkout.checkout_button" 
	And I should see the notify "Your plan changes will be effective on" variable "old_annivesary"
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" 
	When I run schedule task 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "new_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "new_var_monthly" 
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" plus "1"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| monthlypremiumplanuser3      | pricing.go_private_button |Premium|Private|
	
# run the schedule task with the link for Single User http://test.iorad.com/api/actScheduledDowngradePlan?test=manualRun&userIds=1
@smoke
Scenario Outline: Change the plan from Yearly Premium into Monthly Live 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "old_number_billing_history"
	When I click "my_plan.my_plan_link"
	When I get checkout date and store in variable "old_annivesary"
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And I click "checkout.monthly"
	And Store the status of checkbox yearly in variable "new_var_yearly" 
	And Store the status of checkbox monthly in variable "new_var_monthly" 
	Then I should see the "New monthly subscription" info
	And The "Balance due right now" should be $0  
	When I click "checkout.checkout_button" 
	And I should see the notify "Your plan changes will be effective on" variable "old_annivesary"
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" 
	When I run schedule task 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And The variable "cur_var_yearly" should not be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should not be equal to variable "old_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "new_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "new_var_monthly" 
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" plus "1"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| yearlypremiumplanuser3      | pricing.go_live_button |Premium - Annual|Live|
	
Scenario Outline: Change the plan from Yearly Live into Yearly Premium 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "old_number_billing_history"
	When I click "my_plan.my_plan_link"
	When I get checkout date and store in variable "old_annivesary"
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And The "Balance due right now" should be $0  
	When I click "checkout.checkout_button" 
	And I should see the notify "Your plan changes will be effective on" variable "old_annivesary"
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" 
	When I run schedule task 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	When I get checkout date and store in variable "new_annivesary"
	And The variable "new_annivesary" should be equal to variable "old_annivesary" 
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| yearlyliveplanuser1      | pricing.go_premium_button |Live - Annual|Premium - Annual|
	
Scenario Outline: Change the monthly Live plan into Yearly Premium / Private 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "old_number_billing_history"
	When I click "my_plan.my_plan_link"
	When I get checkout date and store in variable "old_annivesary"
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And I click "checkout.yearly"
	And Store the status of checkbox yearly in variable "new_var_yearly" 
	And Store the status of checkbox monthly in variable "new_var_monthly" 
	Then I should see the "New annual subscription" info
	And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit"
	When I click "checkout.checkout_button" 
	And wait for 2 seconds
	#And I should see the message "Your plan has been updated"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And The variable "cur_var_yearly" should not be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should not be equal to variable "old_var_monthly" 
	And The variable "cur_var_yearly" should be equal to variable "new_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "new_var_monthly" 
	When I click "billing_information.billing_information_link"
	And Store the number of element "checkout.transaction_list" in variable "new_number_billing_history"
	And The variable "new_number_billing_history" should be equal to variable "old_number_billing_history" plus "1"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| monthlyliveplanuser1      | pricing.go_private_button |Live|Private - Annual|
		| monthlyliveplanuser2      | pricing.go_premium_button |Live|Premium - Annual|
	
	
	#############CHECK TUTORIALS LOCKED AFTER CHANGING THE PLAN effectively ##################
Scenario Outline: Change Live into Premium / Private - Live Tutorials should be locked 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.my_tutorial_tab"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_private" in variable "number_private_tutorials"
	Then The variable "number_private_tutorials" should be equal "6"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_locked" in variable "number_locked_tutorials"
	Then The variable "number_locked_tutorials" should be equal "0"
	And Store the number of element "tutorials.live_column" in variable "number_live_tutorials"
	Then The variable "number_live_tutorials" should be equal "6"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And I click "checkout.yearly"
	When I click "checkout.checkout_button" 
	And wait for 2 seconds
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.my_tutorial_tab"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_private" in variable "number_private_tutorials"
	Then The variable "number_private_tutorials" should be equal "0"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_locked" in variable "number_locked_tutorials"
	Then The variable "number_locked_tutorials" should be equal "6"
	#unlock tutorial 1
	When I click "tutorials.lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes"
	#unlock tutorial 2
	When I click "tutorials.lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes"
	#unlock tutorial 3
	When I click "tutorials.lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes"
	#unlock tutorial 4
	When I click "tutorials.lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes"
	#unlock tutorial 5
	When I click "tutorials.lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes"
	#unlock tutorial 6
	When I click "tutorials.lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes"
	And Store the number of element "tutorials.live_column" in variable "number_live_tutorials"
	Then The variable "number_live_tutorials" should be equal "5"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| monthlyliveplanuser3      | pricing.go_private_button |Live|Private - Annual|
		| monthlyliveplanuser4      | pricing.go_premium_button |Live|Premium - Annual|
	
@smoke21
Scenario Outline: Change Live / Premium into Private - tutorials having Audio should be locked 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.my_tutorial_tab"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_private" in variable "number_private_tutorials"
	Then The variable "number_private_tutorials" should be equal "3"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_locked" in variable "number_locked_tutorials"
	Then The variable "number_locked_tutorials" should be equal "0"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And I click "checkout.yearly"
	When I click "checkout.checkout_button" 
	And wait for 2 seconds
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.my_tutorial_tab"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_private" in variable "number_private_tutorials"
	Then The variable "number_private_tutorials" should be equal "2"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_locked" in variable "number_locked_tutorials"
	Then The variable "number_locked_tutorials" should be equal "1"
	#unlock tutorial 1
	When I click "tutorials.lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes"
	#verify audio is removed from tutorial
	And I click "tutorials.edit_icon" 
	Then I should be redirected to the Editor page to edit that tutorial 
	And I click "tutorials.edit_icon" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then I open the Audio Editor form
	And The element "tutorials.add_audio_generate_all_step" should be shown
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| monthlyliveplanuser5      | pricing.go_private_button |Live|Private - Annual|
		| monthlypremiumplanuser4      | pricing.go_private_button |Premium|Private - Annual|
	
@smoke2
Scenario Outline: Change Live/ Premium into Private - tutorials having custom theme should be locked 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And I click "checkout.yearly"
	When I click "checkout.checkout_button" 
	And wait for 2 seconds
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.my_tutorial_tab"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_private" in variable "number_private_tutorials"
	Then The variable "number_private_tutorials" should be equal "0"
	And Store the number of element "tutorials.my_tutorials.tutorial_privacy_locked" in variable "number_locked_tutorials"
	Then The variable "number_locked_tutorials" should be equal "1"
	#unlock tutorial 1
	When I click "tutorials.lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes"
	#verify he custom theme should be removed from the tutorials
	And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The "tutorials.settings.customize_theme.theme_control" should be visible
	# See 4 themes
	When I click "tutorials.settings.customize_theme.theme_control"
	Then The text of element "tutorials.settings.customize_theme.selected_theme" should contain "Custom 1 (Upgrade plan to apply)"
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| monthlyliveplanuser6      | pricing.go_private_button |Live|Private - Annual|
		| monthlypremiumplanuser5      | pricing.go_private_button |Premium|Private - Annual|
	
Scenario Outline: Check Creators kept when Live / Premium Plan is changed into Private 
	Given I logged in iroad with user "<user>" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The text of element "checkout.plan_type_info" should be "<old_plan>"
	When I click "checkout.three_dot_icon" 
	When I click "checkout.change_plan" 
	Then I should be redirected to the pricing page 
	When I click "<new_plan_button>" 
	Then I should see the Checkout page content  
	And I click "checkout.yearly"
	When I click "checkout.checkout_button" 
	And wait for 2 seconds
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.my_plan_link"
	And The anniversary date should be today
	Then The text of element "checkout.plan_type_info" should be "<new_plan>"
	When I click "left_menu.left_menu_icon"
	Then The element "left_menu.creators" should not be shown
	Examples: 
		| user      | new_plan_button          |old_plan|new_plan|
		| monthlyliveplanuser7      | pricing.go_private_button |Live|Private - Annual|
		| monthlypremiumplanuser6      | pricing.go_private_button |Premium|Private - Annual|

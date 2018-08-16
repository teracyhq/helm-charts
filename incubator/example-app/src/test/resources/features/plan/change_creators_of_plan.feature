Feature: Change the creators of the current plan 

	As a premium plan user,
    I want to change my plan into another plan
    so I could add, remove some creators from my plan and change the plan period

# run the schedule task with the link for Single User http://dev.iorad.local/api/actScheduledDowngradePlan?test=manualRun&userIds=13
@smoke @test5 @fail
Scenario Outline:Decrease creators & no the plan period change when current plan is yearly
	Given I logged in iroad with user "<username>" and password "<password>" 
	#see information before changing plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	When I click "checkout.less_creator_button" 
	And Store the number of creator in variable "new_var_creator" 
	Then I should see the "New annual subscription" info
	And The "Balance due right now" should be $0 
	And The "checkout.checkout_button" should be enabled
	And I should see the nofification "Your new plan will become active on" "old_annivesary"
	When I get checkout date and store in variable "current_annivesary" 
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	When I click "checkout.checkout_button" 
	And I should see the nofification "Account updated - 1 creator will be removed on" "old_annivesary"
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I get checkout date and store in variable "current_annivesary" 
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	#And The plan change request should be pending and be effective on the anniversary day 
	#Verify the plan will be changed after running schedule task
	When I run schedule task 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "current_annivesary" 
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And Store the number of creator in variable "current_var_creator"  
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	And The variable "current_var_creator" should be equal to variable "new_var_creator" 
	And The variable "old_var_creator" should be equal variable "current_var_creator" plus "1"
	
	Examples: 
		| username       | password      |
		| decreaseuser8  | validpassword |

@smoke @test5
Scenario Outline:Decrease creators & no the plan period change when current plan is monthly
	Given I logged in iroad with user "<username>" and password "<password>" 
	#see information before changing plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	When I click "checkout.less_creator_button" 
	And Store the number of creator in variable "new_var_creator" 
	Then I should see the "New monthly subscription" info
	And The "Balance due right now" should be $0 
	And The "checkout.checkout_button" should be enabled
	And I should see the nofification "Your new plan will become active on" "old_annivesary"
	When I get checkout date and store in variable "current_annivesary" 
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	When I click "checkout.checkout_button" 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	And I should see the nofification "Account updated - 1 creator will be removed on" "old_annivesary"
	When I get checkout date and store in variable "current_annivesary" 
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	And Store the number of creator in variable "current_var_creator"  
	And The variable "current_var_creator" should be equal to variable "old_var_creator" 
	#And The plan change request should be pending and be effective on the anniversary day 
	#Verify the plan will be changed after running schedule task
	When I run schedule task 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "current_annivesary" 
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And Store the number of creator in variable "current_var_creator"  
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	And The variable "current_var_creator" should be equal to variable "new_var_creator" 
	And The variable "old_var_creator" should be equal variable "current_var_creator" plus "1"
	
	Examples: 
		| username       | password      |
		| decreaseuser18 | validpassword |
		
@smoke @test5
Scenario Outline: Increase creators & no the plan period change when current plan is yearly or monthly and no descrease request is pending 
	Given I logged in iroad with user "<username>" and password "<password>"
	#see information before changing plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	#increasing creator
	When I click "checkout.more_creator_button" 
	And Store the number of creator in variable "new_var_creator" 
    And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit"
   	And I should see the info about "Next invoice of xxxx is due on Month dd yyyy"
    And The element "checkout.update_link" should be shown 
   	When I click "checkout.checkout_button" 
    Then The element "my_plan.current_my_plan_tab" should be shown 
    And I should see the notification "Account updated - 1 creator added"
    And Store the number of creator in variable "current_var_creator"  
    And The variable "current_var_creator" should be equal to variable "new_var_creator" 
	And The variable "current_var_creator" should be equal variable "old_var_creator" plus "1"
	When I get checkout date and store in variable "current_annivesary" 
    And The anniversary date should be today
	Examples: 
		| username       | password      |
		| decreaseuser8  | validpassword |
		| decreaseuser18 | validpassword |

@smoke @test8
Scenario: Change from Monthly into Yearly & Decrease creators 
	Given I logged in iroad with user "decreaseuser18" and password "validpassword" 
	#see information before changing plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	#increasing creator
	When I click "checkout.less_creator_button" 
	When I click "checkout.yearly"
	And Store the number of creator in variable "new_var_creator" 
    And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit"
   	And I should see the info about "Next invoice of xxxx is due on Month dd yyyy"
    And The element "checkout.update_link" should be shown 
   	When I click "checkout.checkout_button" 
    Then The element "my_plan.current_my_plan_tab" should be shown 
    And I should see the notification "Account updated - 1 creator removed"
    And Store the number of creator in variable "current_var_creator"  
    And The variable "current_var_creator" should be equal to variable "new_var_creator" 
	And The variable "old_var_creator" should be equal variable "current_var_creator" plus "1"
	When I get checkout date and store in variable "current_annivesary" 
    And The anniversary date should be today 
	
@smoke @test8
Scenario: Change from Monthly into Yearly & Increase the creators 
	Given I logged in iroad with user "decreaseuser19" and password "validpassword"
	#see information before changing plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	#increasing creator
	When I click "checkout.more_creator_button" 
	When I click "checkout.monthly"
	And Store the number of creator in variable "new_var_creator" 
    And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit"
   	And I should see the info about "Next invoice of xxxx is due on Month dd yyyy"
    And The element "checkout.update_link" should be shown 
   	When I click "checkout.checkout_button" 
    Then The element "my_plan.current_my_plan_tab" should be shown 
    And I should see the notification "Account updated - 1 creator added"
    And Store the number of creator in variable "current_var_creator"  
    And The variable "current_var_creator" should be equal to variable "new_var_creator" 
	And The variable "current_var_creator" should be equal variable "old_var_creator" plus "1"
	When I get checkout date and store in variable "current_annivesary" 
    And The anniversary date should be today 
	
@smoke @test8
Scenario: Change from Monthly into Yearly & no creator change 
	Given I logged in iroad with user "decreaseuser20" and password "validpassword" 
	#see information before changing plan
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	#increasing creator
	When I click "checkout.yearly"
	And Store the number of creator in variable "new_var_creator" 
    And The "Balance due right now" should be equal to the price of "New annual / monthly subscription - Current subscription credit"
   	And I should see the info about "Next invoice of xxxx is due on Month dd yyyy"
    And The element "checkout.update_link" should be shown 
   	When I click "checkout.checkout_button" 
    Then The element "my_plan.current_my_plan_tab" should be shown 
    And I should see the notification "Account updated - 0 creator added"
    And Store the number of creator in variable "current_var_creator"  
    And The variable "current_var_creator" should be equal to variable "new_var_creator" 
	And The variable "old_var_creator" should be equal to variable "current_var_creator"
	When I get checkout date and store in variable "current_annivesary" 
    And The anniversary date should be today 
	
	# run the schedule task with the link for Single User http://test.iorad.com/api/actScheduledDowngradePlan?test=manualRun&userIds=1
@smoke @test8
Scenario: Change from Yearly into Monthly & Decrease creators 
	Given I logged in iroad with user "decreaseuser21" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	When I click "checkout.less_creator_button" 
	When I click "checkout.monthly" 
	And Store the number of creator in variable "new_var_creator" 
	Then I should see the "New monthly subscription" info
	#And The "Balance due right now" should be $0 
	And The "checkout.checkout_button" should be enabled
	When I get checkout date and store in variable "current_annivesary" 
	When I get new subscription and store in variable "new_subscription"
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	When I click "checkout.checkout_button" 
	And I should see the nofification "Account updated - Your next invoice will be" "new_subscription" ". &" "new_var_creator" "Creators on" "old_annivesary"
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I get checkout date and store in variable "current_annivesary" 
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	#And The plan change request should be pending and be effective on the anniversary day 
	#Verify the plan will be changed after running schedule task
	When I run schedule task 
	Given I logged in iroad with user "decreaseuser21" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "current_annivesary" 
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And Store the number of creator in variable "cur_var_creator"  
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	And The variable "cur_var_creator" should be equal to variable "new_var_creator" 
	And The variable "old_var_creator" should be equal variable "cur_var_creator" plus "1"
	
	# run the schedule task with the link for Single User http://test.iorad.com/api/actScheduledDowngradePlan?test=manualRun&userIds=1
@smoke @test8
Scenario: Change from Yearly into Monthly & Increase creators 
	Given I logged in iroad with user "increaseuser02" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	When I click "checkout.more_creator_button" 
	When I click "checkout.monthly" 
	And Store the number of creator in variable "new_var_creator" 
	Then I should see the "New monthly subscription" info
	And The "Balance due right now" should be $0 
	And The "checkout.checkout_button" should be enabled
	And I should see the info about "Next invoice of xxxx is due on Month dd yyyy"
	When I get checkout date and store in variable "current_annivesary" 
	When I get new subscription and store in variable "new_subscription"
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	When I click "checkout.checkout_button" 
	And I should see the nofification "Account updated - Your next invoice will be" "new_subscription" ". &" "new_var_creator" "Creators on" "old_annivesary"
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I get checkout date and store in variable "current_annivesary" 
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	#And The plan change request should be pending and be effective on the anniversary day 
	#Verify the plan will be changed after running schedule task
	When I run schedule task 
	Given I logged in iroad with user "increaseuser02" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "current_annivesary" 
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And Store the number of creator in variable "cur_var_creator"  
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	And The variable "cur_var_creator" should be equal to variable "new_var_creator" 
	And The variable "cur_var_creator" should be equal variable "old_var_creator" plus "1"
	
	# run the schedule task with the link for Single User http://test.iorad.com/api/actScheduledDowngradePlan?test=manualRun&userIds=1
@smoke @test8
Scenario: Change from Yearly into Monthly & no creator change 
	Given I logged in iroad with user "nodecreaseorincreaseuser01" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "old_annivesary" 
	And Store the status of checkbox yearly in variable "old_var_yearly" 
	And Store the status of checkbox monthly in variable "old_var_monthly" 
	And Store the number of creator in variable "old_var_creator" 
	When I click "checkout.monthly" 
	And Store the number of creator in variable "new_var_creator" 
	Then I should see the "New monthly subscription" info
	And The "Balance due right now" should be $0 
	And The "checkout.checkout_button" should be enabled
	And I should see the info about "Next invoice of xxxx is due on Month dd yyyy"
	When I get checkout date and store in variable "current_annivesary" 
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	When I click "checkout.checkout_button" 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	When I get checkout date and store in variable "current_annivesary" 
	And The variable "current_annivesary" should be equal to variable "old_annivesary" 
	#And The plan change request should be pending and be effective on the anniversary day 
	#Verify the plan will be changed after running schedule task
	When I run schedule task 
	Given I logged in iroad with user "nodecreaseorincreaseuser01" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I get checkout date and store in variable "current_annivesary" 
	And Store the status of checkbox yearly in variable "cur_var_yearly" 
	And Store the status of checkbox monthly in variable "cur_var_monthly" 
	And Store the number of creator in variable "current_var_creator"  
	And The variable "cur_var_yearly" should be equal to variable "old_var_yearly" 
	And The variable "cur_var_monthly" should be equal to variable "old_var_monthly" 
	And The variable "current_var_creator" should be equal to variable "new_var_creator" 
	And The variable "current_var_creator" should be equal to variable "old_var_creator" 
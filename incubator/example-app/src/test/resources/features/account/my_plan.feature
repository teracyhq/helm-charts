@test1
Feature: My Plan

	As a logged-in user,
  I want to see my account summary
  so that I could see all the details of my account.

Scenario: View My Plan tab as a free user 
	Given I am logged-in as a free verified user
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The element "my_account.my_account_link" should be shown 
	Then The element "quota.quota_link" should be shown 
	Then The element "billing_information.billing_information_link" should not be shown 
	Then I should see the message "Free (Includes 1 Premium Tutorial)" 
	When I click "my_plan.change_plan_button" 
	Then I should be redirected to the "/pricing" page
	Then I should see the pricing page content 
	
 #don't see quota links
 @smoke @fail
Scenario: View My Plan tab as a team member 
	Given I am logged-in as a team member 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The element "my_account.my_account_link" should be shown 
	Then The element "quota.quota_link" should be shown 
	Then The element "billing_information.billing_information_link" should not be shown 
	Then I should see the message "Premium Private Plan" 
	And I should see the plan price as $0 
	And I should see the creator number 
	And I should see the info Team member - no charge
    And The element "my_plan.leave_the_team_button" should be shown 
	
#don't see quota links
#https://github.com/iorad/iorad/issues/6145
 @smoke @fail
Scenario: View My Plan tab as a team owner
	Given I am logged-in as a team owner
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The element "my_account.my_account_link" should be shown 
	Then The element "quota.quota_link" should be shown 
	Then The element "billing_information.billing_information_link" should be shown 
	And The "my_plan.live_plan" should be visible
	And The element "my_plan.monthly_checkbox" should be shown 
	And The element "my_plan.yearly_checkbox" should be shown 
	And I should see the creator number 
	When I click "my_plan.more_plan_button"
	And The element "my_plan.current_cost" should be shown 
	And The element "my_plan.change_plan_button" should be shown 
	And The element "my_plan.downgrad_plan_to_iorad_free" should be shown 

 #don't see quota links
 #https://github.com/iorad/iorad/issues/6145
 @smoke @fail
Scenario: View My Plan tab as individual premium user 
	Given I logged in iroad with user "premiumplanyearlyuser1" and password "validpassword"
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	Then The element "my_account.my_account_link" should be shown 
	Then The element "quota.quota_link" should be shown 
	Then The element "billing_information.billing_information_link" should be shown 
	And The "my_plan.premium_annual_plan" should be visible
	And The element "my_plan.monthly_checkbox" should be shown 
	And The element "my_plan.yearly_checkbox" should be shown 
	And I should see the creator number 
	When I click "my_plan.more_plan_button"
	And The element "my_plan.current_cost" should be shown 
	And The element "my_plan.change_plan_button" should be shown 
	And The element "my_plan.downgrad_plan_to_iorad_free" should be shown 
	
	

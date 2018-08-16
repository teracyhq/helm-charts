@wip 
Feature: Admin dashboard 

	As an admin,
    I want to go to Admin dashboard
    so that I can manage plans, users and more.


Background: 
	Given I am a logged-in as an admin 
	And I am at Admin Dashboard 
	
@low_priority
Scenario: Access the New Plan page 
	When I click Admin on the left panel 
	Then I should be redirected to the /admin page 
	When I select the Plans tab 
	And I click New Plan 
	Then I should be redirected to the New Plan page 
	
	# cover all features and all unlimited enabled
Scenario: Create a Public custom plan without trial 
	Given I am at the New Plan page 
	When I fill in the plan Name 
	And I select Plan Type as "Special" 
	Then The VIEW SETTINGS is Public by default 
	And The FREQUENCY is Month by default 
	And The FREE PLAN is No trial by default 
	When I select Frequency as "Yearly" or "Monthly" 
	And I navigate to the Feature tab 
	And I check the "Enable All" checkbox 
	Then All features should be enabled 
	When I check the "All unlimited" checkbox 
	Then All "Unlimited" checkbox should be checked and enabled 
	When I navigate to the Price tab 
	And I input a number for "YEARLY / MONTHLY CREATOR PRICE" corelatively 
	And I check the "Include base price" 
	And I input a number for the base price 
	And I input a number for Min Creators and a greater number for Max Creators 
	And I navigate to the Summary tab 
	When I should see all info I set for the plan 
	And I click Create Plan 
	Then I should move to the page to copy the plan url and invite users 
	And The Share button should be disabled 
	When I click the URL 
	Then I should see the notifiation "Plan link copied to your clipboard" 
	When I input a valid email 
	And I click Share button enabled 
	Then I should see the message "Email invitations were sent" 
	When I click Close / X icon 
	Then I should be redirected to the Plans page 
	And The plan should be listed in the Plans page 
	And The inviatation emails should be sent to the input email addresses 
	When The user subscribes this plan 
	Then They should be able to use the features enabled and unlimited features 
	
	# cover all features enabled, and features limited: Private limit, Premium limit, Live Tutorials limit, Zendesk Tutorials Limit
Scenario: Create a Public custom plan with trial 
	Given I am at the New Plan page 
	When I fill in the plan Name 
	And I select Plan Type as "Special" 
	Then The VIEW SETTINGS is Public by default 
	And The FREQUENCY is Month by default 
	And The FREE PLAN is No trial by default 
	When I select Frequency as "Yearly" or "Monthly" 
	And I select "7 days / 14 days / 1 month / Forever" for "Free Plan" 
	And I check / uncheck the "Credit Card requirement" checkbox 
	Then The selected item should be shown 
	When I navite to the Features tab 
	And I check the "Enable All" checkbox 
	Then All features should be enabled 
	When I input a specifc integer number in the fields Private limit, Premium limit, Live Tutorials limit, Zendesk Tutorials Limit 
	Then This integer number should be inputted 
	When I navigate to the Price tab 
	And I input a number for "YEARLY / MONTHLY CREATOR PRICE" correlatively 
	And I check the "Include base price" 
	And I input a number for the base price 
	And I input a number for Min Creators and a greater number for Max Creators 
	And I navigate to the Summary tab 
	When I should see all info I set for the plan 
	And I click Create Plan 
	Then I should move to the page to copy the plan url and invite users 
	And The Share button should be disabled 
	When I click the URL 
	Then I should see the notifiation "Plan link copied to your clipboard" 
	When I input a valid email 
	And I click Share button enabled 
	Then I should see the message "Email invitations were sent" 
	When I click Close / X icon 
	Then I should be redirected to the Plans page 
	And The plan should be listed in the Plans page 
	And The inviatation emails should be sent to the input email addresses 
	When The user subscribes the plan 
	Then The user should only be able to create limited number of the tutorials as Admin set 
	
	# cover enabling each feature
Scenario: Create a Private custom plan without trial 
	Given I am at the New Plan page 
	When I fill in the plan Name 
	And I select Plan Type as "Special" 
	Then The VIEW SETTINGS is Public by default 
	And The FREQUENCY is Month by default 
	And The FREE PLAN is No trial by default 
	When I select Frequency as "Yearly" or "Monthly" 
	And I select Invite Only for VIEW SETTINGS 
	Then I should see the Enter email placeholder 
	When I input a valid email into the Enter email placeholder 
	And I press Enter 
	Then The email should be listed 
	And Another Enter email placeholder should be shown 
	And I should be add more emails 
	When I navite to the Features tab 
	And I enable Private 
	Then I should see 4 features listed: Private Limit, Unlisted, Private, Shared with email domain 
	And The Unlimited checkbox should be checked for Private Limit by default 
	And I should be able to disable these features of Private 
	When I enable Premium 
	Then I should see 6 features in Premium listed: Premium limit, Audio, Mask Data, Theme, Tool Color and Layout. 
	And  The Unlimited checkbox should be checked for Premium Limit by default 
	And  I should be able to disable these features of Premium 
	When  I enable Live 
	Then  I should see 2 features in Live listed: Connect Website, and Live Tutorials limit 
	And  The Unlimited checkbox should be checked for Live Tutorials Limit by default 
	And  I should be able to disable these features 
	When  I enable Integrations 
	Then  I should see 2 features listed: Zendesk Connect and Zendesk Tutorials limit 
	And  The Unlimited checkbox should be checked for Zendesk Tutorials limit 
	And  I should be able to disable these features 
	When  I enable Download Tutorials 
	Then  I should see 2 features listed: Download SCORM LMS and Download HTML ZIP 
	And  I should be able to disable these features 
	When  I navigate to the Price tab 
	And  I input a number for "YEARLY / MONTHLY CREATOR PRICE" corelatively 
	And  I check the "Include base price" 
	And  I input a number for the base price 
	And  I input a number for Min Creators and a greater number for Max Creators 
	And  I navigate to the Summary tab 
	When  I should see all info I set for the plan 
	And  I click Create Plan 
	Then  I should move to the Inivte page 
	And  I should see the invited emails 
	And  The Share button should be disabled 
	When  I input a valid email 
	And  I click Share button enabled 
	Then  I should see the message "Email invitations were sent" 
	When  I click Close / X icon 
	Then  I should be redirected to the Plans page 
	And  The plan should be listed in the Plans page 
	And  The inviatation emails should be sent to the input email addresses 
	When  A user subscribe the plan 
	Then  The user should be able to use the features as Admin set 
	
	Scenario: Create a Private custom plan with trial 
	Given  I am at the New Plan page 
	When  I fill in the plan Name 
	And  I select Plan Type as "Special" 
	Then  The VIEW SETTINGS is Public by default 
	And  The FREQUENCY is Month by default 
	And  The FREE PLAN is No trial by default 
	When  I select Frequency as "Yearly" or "Monthly" 
	And  I select Invite Only for VIEW SETTINGS 
	Then  I should see the Enter email placeholder 
	When  I input a valid email into the Enter email placeholder 
	And  I press Enter 
	Then  The email should be listed 
	And  Another Enter email placeholder should be shown 
	And  I should be add more emails 
	When  I select "7 days / 14 days / 1 month / Forever" for "Free Plan" 
	And  I check / uncheck the "Credit Card requirement" checkbox 
	Then  The selected item should be shown 
	When  I navite to the Features tab 
	And  I check the "Enable All" checkbox 
	Then  All features should be enabled 
	When  I check the "All unlimited" checkbox 
	Then  All "Unlimited" checkbox should be checked and enabled 
	When  I navigate to the Price tab 
	And  I input a number for "YEARLY / MONTHLY CREATOR PRICE" corelatively 
	And  I check the "Include base price" 
	And  I input a number for the base price 
	And  I input a number for Min Creators and a greater number for Max Creators 
	And  I navigate to the Summary tab 
	When  I should see all info I set for the plan 
	And  I click Create Plan 
	Then  I should move to the Inivte page 
	And  I should see the invited emails 
	And  The Share button should be disabled 
	When  I input a valid email 
	And  I click Share button enabled 
	Then  I should see the message "Email invitations were sent" 
	When  I click Close / X icon 
	Then  I should be redirected to the Plans page 
	And  The plan should be listed in the Plans page 
	And  The inviatation emails should be sent to the input email addresses 
	
	Scenario: All children features disabled make the parent feature disabled 
	Given  I am creating a plan 
	And  I am at the Features plan 
	When  I enable the parent features: Private, Premium, Live, Integrations and Connect Website 
	Then  The children features of these features should be disabled 
	When  I disable all the children features of these features 
	Then  These parent children should be disabled 
	
	Scenario: Input text and specific characters into the *limit* fields 
	Given  I am creating a plan 
	And  I am at the Features plan 
	When  I enable the parent features: Private, Premium, Live, Integrations and Connect Website 
	And  I input text, and special characters for the Limit fields 
	Then  These characters should not be inputted 
	
	Scenario: Create a plan with the Limit fields disabled or empty 
	Given  I am creating a plan 
	And  I am at the Features plan 
	When  I enable the parent features: Private, Premium, Live, Integrations and Connect Website 
	And  I input nothing in the Limit fields or disable the Limit fields 
	And  I click Create Plan 
	Then  The plan should be created 
	When  A user subscribes the plan 
	Then  The user should not be able to create the Private, Premium, Live tutorials. 
	
	@low_priority 
	Scenario: Edit a custom public plan 
	Given  I am at Plan List 
	And  I have a custom public plan created 
	When  I click Edit corresponding to the custom public plan 
	Then  The Edit page should be opened 
	When  I change some values properly 
	And  I click Update Plan 
	Then  I should be redirected to the Invite page 
	When  I click Close / X icon 
	Then  I should be redirected to the Plan list 
	And  The plan changes should be saved 
	And  These changes should be applied for new subscribers, not existing subscribers 
	
	Scenario: Change the frequency of the plan 
	Given  I created a plan 
	When  I open the Edit Plan page 
	And  I change Frequency of the plan 
	And  I click Update Plan 
	Then  I should see the message "Update Plan Failed! Frequency change is not implemented" 
	
	@low_priority 
	Scenario: Create an Invite Only custom plan with invalid email 
	Given  I am creating a private plan 
	And  I am at the Settings tab 
	When  I input an invalid email into the Enter email placeholder 
	And  I press Enter 
	Then  Nothing is input in the Enter email placeholder 
	
	Scenario: Create an Invite Only custom plan with empty email 
	Given  I am creating a private plan 
	And  I am at the Settings tab 
	When  I input nothing into the Enter email placeholder 
	And  I input all valid values 
	And  I click Create Plan 
	Then  I should see the error message "Invite email is required for a private plan." 
	
	
	Scenario: Create a plan with empty name 
	Given  I am creating a plan 
	When  I fill in nothing in the Plan Name field 
	And  I input all valid values and select options 
	And  I click Create Plan 
	Then  I should see the message "Please enter plan name." 
	
	Scenario: Create a plan with duplicated name 
	Given  I am creating a plan 
	When  I fill in an existing plan name in the Plan Name field 
	And  I input all valid values and select options 
	And  I click Create Plan 
	Then  I should see the message "Plan with this name already exists!" 
	
	Scenario: Create Plan with empty Creator Price 
	Given  I am creating a custom plan 
	When  I fill in a valid plan name 
	And  I input all valid values and select options 
	And  I don't input the Creator Price 
	And  I click Create Plan 
	Then  I should see the message "Creator price must be greater than zero" 
	
	Scenario: Create plan with the Creator Price of 0 
	Given  I am creating a custom plan 
	When  I input all valid values and select options 
	And  I fill in 0, letters and special characters into the Creator Price field 
	Then  The Number 0, letters and special characters should not be inputted into the Creator Price field 
	
	Scenario: Create Plan with empty Creator Price 
	Given  I am creating a custom plan 
	When  I fill in a valid plan name 
	And  I input all valid values and select options 
	And  I don't input the Creator Price 
	And  I click Create Plan 
	Then  I should see the message "Creator price must be greater than zero" 
	
	Scenario: Create plan with the Basic Price of 0 
	Given  I am creating a custom plan 
	When  I input all valid values and select options 
	And  I fill in 0, letters and special characters into the Basic Price field 
	Then  The Number 0, letters and special characters should not be inputted into the Basic Price field 
	
	Scenario: Create a custom plan with the minimum users of 0 or empty 
	Given  I am creating a custom plan 
	When  I input all valid values and select options 
	And  I fill in 0 or nothing into the Minimum user field 
	And  I click Create Plan 
	Then  I should see the message "Min creators must be greater than zero!" 
	
	Scenario: Create a custom plan with the Maximum users less than Minimum users 
	Given  I am creating a custom plan 
	When  I input all valid values and select options 
	And  I fill in 10 into Minimum User field 
	And  I fill in 0 into the Maximum User field 
	And  I click Create Plan 
	Then  I should see the message "Max creators must be equal or greater than Min creators" 
	
	Scenario: Input special, space charaters into Min/Max creators 
	Given  I am creating a plan 
	When  I input all valid values and select options 
	And  I fill in special or space characters into Mix/Max creators 
	Then  Nothing is input 
	
	Scenario: Create a custom plan with no features enabled 
	Given  I am creating a custom plan 
	When  I input valid names and price 
	And  I navigate to the Features tab 
	And  I don't enable any features 
	And  I click Create Plan 
	Then  I should be redirected to the Invite screen 
	And  I click Close 
	Then  I should be redirected to the Plan list page 
	And  The plan should be created 
	When  The user subscribes the plan 
	Then  They should not be able to use any features listed in the Features tab 
	
	@wip 
	Scenario: Check if plan of specific user edited can affect on the main plan 
	When  I edit the plan of a specific user 
	Then  The main plan should not be affected 
	
	
	@wip 
	Scenario: Re-subscribe user 
	Given  I am logged in as an admin 
	And  I cancels subscription of a user from stripe 
	When  I go to the Admin 
	And  I edit the price of the plan which the user subscribed 
	And  I revert the price into the original price 
	And  I back to the stripe 
	Then  I should see user to be resubscribed 
	
	@wip 
	Scenario: View the subscriber numbers of a plan 
	Given  I am logged in as an admin 
	And  I created a custom plan 
	And  Some users have already subscribed the plan 
	When  I navigate to the Plan tab in Admin 
	And  I click the number in SUBSCRIBERS corresponding to the plan 
	Then  I should see the subscriber list of the plan
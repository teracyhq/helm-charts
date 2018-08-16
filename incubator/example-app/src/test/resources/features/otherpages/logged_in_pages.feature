@test5
Feature: Navigate between pages when user already logged in 

	As a logged-in user,
    I want to navigate between pages
    so that I can see the content of each page.

Background: 
	Given I logged in iroad with user "decreaseuser3" and password "validpassword" 
	
@smoke 
Scenario: home page 
	Given I am at "/createNewTutorial" 
	Then I should be redirected to the Editor page to create new tutorial 
	
@smoke 
Scenario: sign up page 
	Given I am at "/signup" 
	Then I should see the My tutorials page content 
	
@smoke 
Scenario: login page 
	Given I am at "/login" 
	Then I should see the My tutorials page content 
	
@smoke 
Scenario: "Creators" page 
	Given I am at "/creators/main" 
	Then I should see the Creators page content 
	
@smoke 
Scenario: pricing page 
	Given I am at "/pricing" 
	Then I should see the pricing page content 
	
@smoke 
Scenario: private checkout page 
	Given I am at "/checkout/private" 
	Then I should see the Checkout page content 
	And The Private Plan should be selected 
	
@smoke 
Scenario: premium checkout page 
	Given I am at "/checkout/premium" 
	Then I should see the Checkout page content 
	And The Premium Plan should be selected 
	
@smoke 
Scenario: live checkout page 
	Given I am at "/checkout/live" 
	Then I should see the Checkout page content 
	And The Live Plan should be selected 
	
@smoke 
Scenario: contact us page 
	When I click on the "left_menu.contact_us" on the left panel 
	Then I should see the contact us page content 
	
@smoke 
Scenario: terms and privacy page 
	Given I am at "/termsconditions" 
	Then I should see the Terms of use and Privacy policy page content 
	
@smoke 
Scenario: connect page 
	Given I am at "/connectIntegrations/direct" 
	Then I should see the iorad Connect content 
	
@smoke 
Scenario: "Your Tutorials" page 
	Given I am at "/tutorials" 
	Then I should see the My tutorials page content 
	
@smoke 
Scenario: "Plan" tab 
	Given I am at "/account/myplan"
	Then I should see the Plan page content
	
@smoke
Scenario: "Plan" tab 
	Given I am at "/account"
	Then I should see the Plan page content
	
#don't see quota links
#https://github.com/iorad/iorad/issues/6145
@smoke @fail
Scenario: "Quota" tab 
	Given I am at "/account/quota" 
	Then I should see the Quota page content
	
@smoke
Scenario: "Personal Settings" page 
	Given I am at "/account/personal" 
	Then I should see the Personal Settings page content 
	
@smoke
Scenario: "Billing Information" page 
	Given I am at "/account/billing" 
	Then I should see the Billing Information page content 
	
@smoke
Scenario: "Creators" page 
	Given I am at "/creators/main" 
	Then I should see the Creators page content
	
@smoke
Scenario: log out page 
	Given I am at "/logout" 
	Then I should be logged out and redirected to the home page 
	

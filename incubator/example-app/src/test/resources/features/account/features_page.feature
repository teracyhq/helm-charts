@test1 
Feature: Features page 

	As a logged-in user,
    I want to see the features page
    so that I could know the tutorial features for my current plan
    
@smoke 
Scenario: View Features of a free user 
	Given I logged in iroad with user "freeplanuser1" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	And I navigate to the "features.features_link" 
	Then I should be redirected to the "/account/features" page 
	And The text of element "features.private_limit" should be "2"
	And The text of element "features.mask_limit" should be "2"
	And The text of element "features.audio" should be "2"
	And The text of element "features.live_tutorials_limit" should be "5"
	And The text of element "features.zendesk_tutorials_limit" should be "5"
	And The text of element "features.theme_limit" should be "1"
	Then The element "features.export_link" should be shown 
	
@smoke 
Scenario: View Feature of a Private user 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	And I navigate to the "features.features_link" 
	Then I should be redirected to the "/account/features" page  
	And The text of element "features.private_limit" should be "Unlimited"
	And The text of element "features.mask_limit" should be "Unlimited"
	And The text of element "features.audio" should be "2"
	And The text of element "features.live_tutorials_limit" should be "5"
	And The text of element "features.zendesk_tutorials_limit" should be "5"
	And The text of element "features.theme_limit" should be "1"
	Then The element "features.export_link" should be shown 
	
@smoke 
Scenario: View Feature of a Premium user 
	Given I logged in iroad with user "yearlypremiumplanuser2" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	And I navigate to the "features.features_link" 
	Then I should be redirected to the "/account/features" page 
	And The text of element "features.private_limit" should be "Unlimited"
	And The text of element "features.mask_limit" should be "Unlimited"
	And The text of element "features.audio" should be "Unlimited"
	And The text of element "features.live_tutorials_limit" should be "5"
	And The text of element "features.zendesk_tutorials_limit" should be "5"
	And The text of element "features.theme_limit" should be "1"
	Then The element "features.export_link" should be shown
	
@smoke 
Scenario: View Feature of a Live user 
	Given I logged in iroad with user "yearlyliveplanuser1" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	And I navigate to the "features.features_link" 
	Then I should be redirected to the "/account/features" page 
	And The text of element "features.private_limit" should be "Unlimited"
	And The text of element "features.mask_limit" should be "Unlimited"
	And The text of element "features.audio" should be "Unlimited"
	And The text of element "features.live_tutorials_limit" should be "Unlimited"
	And The text of element "features.zendesk_tutorials_limit" should be "Unlimited"
	And The text of element "features.theme_limit" should be "1"
	Then The element "features.export_link" should be shown 
	
#can not check content of csv file automatically
@wip
Scenario: check the Export Links link 
	Given I am logged-in 
	And I am at the "Features" tab 
	When I click the "Export tutorial links (CSV)" link 
	Then I should be able to save a .scv file 
	When I view the .scv file 
	Then The file should contain the info of 7 columns: Name, Direct Link, Embed Code, Steps, Tags,  Categories, and Cover link
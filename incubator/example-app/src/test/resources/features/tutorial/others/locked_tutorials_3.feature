@test2
Feature: tutorials are locked after user downgraded the plan into free 

	As a locked user
    I want to manage tutorials
    so that I can unlock, delete or change the settings for my tutorials
    
@function
Scenario: cancel deleting locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button"
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url"
	And I click "tutorials.tab_share_tutorial_tab_close"
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click by javascript "tutorials.delete"
	And I click "tutorials.confirm_no" 
	When I navigate to url with url is value of variable "url"
	Then I should see the message "The first step is to open"
	And I should be able to play the tutorial to the last step 
	
@function
Scenario: delete locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button"
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url"
	And I click "tutorials.tab_share_tutorial_tab_close"
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click by javascript "tutorials.delete"
	And I click "tutorials.confirm_yes" 
	When I navigate to url with url is value of variable "url"
	Then I should see the message "Tutorial does not exist."
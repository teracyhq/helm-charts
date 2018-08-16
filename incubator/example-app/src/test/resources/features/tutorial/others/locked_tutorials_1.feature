@test1
Feature: tutorials are locked after user downgraded the plan into free 

	As a locked user
    I want to manage tutorials
    so that I can unlock, delete or change the settings for my tutorials
    
@function
Scenario: play my locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.play" 
	Then I should be redirected to the player page of the tutorial 
	When I click "tutorials.try_icon" 
	When I click "tutorials.view_all_steps" 
	When I click "tutorials.play_next_step" 
	When I click "tutorials.play_previous_step" 
	When I click "tutorials.play_back_totutorial_cover" 
	Then The element "tutorials.try_icon" should be shown 
	Then The element "tutorials.view_icon" should be shown 
	When I click "tutorials.try_icon" 
	And I should be able to play the tutorial to the last step 
	
@function
Scenario: user plays private locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button"
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url"
	And I click "tutorials.tab_share_tutorial_tab_close"
	When I click on the "left_menu.logout" button from the slide out menu
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I navigate to url with url is value of variable "url"
	Then I should see the message "Access denied: no read rights."
	
@function
Scenario: user plays public locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.public_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button"
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url"
	And I click "tutorials.tab_share_tutorial_tab_close"
	When I click on the "left_menu.logout" button from the slide out menu
	Given I am an anonymous user 
	When I navigate to url with url is value of variable "url"
	And I should be able to play the tutorial to the last step
	
@function
Scenario: edit locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.edit_icon" 
	Then I should see the message "Locked Tutorial"
	And I should see the message "Upgrade to a premium plan or make tutorial public (custom theme & privacy will be lost)." 
	And The element "tutorials.make_public_button" should be shown
	And The element "tutorials.upgrade_button" should be shown
	When I click "tutorials.close_form_button"
	And The element "tutorials.make_public_button" should not be shown
	And The element "tutorials.upgrade_button" should not be shown
	
@function
Scenario: duplicate locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click by javascript "tutorials.duplicate"  
	Then I should see the message "You can't copy the locked tutorial!" 
	
@function
Scenario: do settings on locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I should see the message "Upgrade to a premium plan or make tutorial public (custom theme & privacy will be lost)." 
	And The element "tutorials.make_public_button" should be shown
	And The element "tutorials.upgrade_button" should be shown
	When I click "tutorials.close_form_button"
	And The element "tutorials.make_public_button" should not be shown
	And The element "tutorials.upgrade_button" should not be shown
	
@function
Scenario: cancel making locked tutorial public 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button"
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url"
	And I click "tutorials.tab_share_tutorial_tab_close"
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_no" 
	When I click on the "left_menu.logout" button from the slide out menu
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I navigate to url with url is value of variable "url"
	Then I should see the message "Access denied: no read rights."
	
@function
Scenario: make locked tutorial public 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button"
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url"
	And I click "tutorials.tab_share_tutorial_tab_close"
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.make_public_button" 
	And I click "tutorials.confirm_yes" 
	When I click on the "left_menu.logout" button from the slide out menu
	When I navigate to url with url is value of variable "url"
	And I should be able to play the tutorial to the last step
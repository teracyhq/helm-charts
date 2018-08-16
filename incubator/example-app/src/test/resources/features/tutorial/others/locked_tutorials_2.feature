@test1
Feature: tutorials are locked after user downgraded the plan into free 

	As a locked user
    I want to manage tutorials
    so that I can unlock, delete or change the settings for my tutorials
	
@function
Scenario: invitee plays the locked tutorial 
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
Scenario: check tags kept for locked tutorials 
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
Scenario: Add label for locked tutorials 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.add_label_button" 
	When I fill value "tutorialslabel1" to "tutorials.private_lock_tutorial.add_label_textbox" textbox
	And I press Enter 
	Then I should see the message "tutorialslabel1"
	
@function
Scenario: Add labels to multiple locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.checkbox" 
	When I click "tutorials.public_lock_tutorial.checkbox" 
	When I click "tutorials.add_category_or_tag_btn" 
	When I click "tutorials.add_category_tag_modal.tag_tab"
	When I click "tutorials.add_category_tag_modal.tag_input"
	When I fill value "multipletutorialslabel1" to "tutorials.add_category_tag_modal.tag_input" textbox
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.tag_apply_button"
	Then I should see the message "multipletutorialslabel1"
	
@function
Scenario: upgrade plan from the "Tutorial is locked" page 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.public_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button"
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url"
	And I click "tutorials.tab_share_tutorial_tab_close"
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.setting"
	Then I should see the message "Locked Tutorial"
	And I click "tutorials.upgrade_button" 
	When I click "pricing.go_live_button" 
	Then I should be redirected to the "/checkout/live" page
	When wait for 5 seconds
	When I click "checkout.checkout_button" 
	When wait for 5 seconds
	When I click on the "left_menu.logout" button from the slide out menu
	Given I logged in iroad with user "freeverifieduser" and password "validpassword" 
	When I navigate to url with url is value of variable "url"
	And I should be able to play the tutorial to the last step "
	
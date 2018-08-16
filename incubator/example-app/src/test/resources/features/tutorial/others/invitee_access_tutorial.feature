@test7
Feature: Invitee accepts the invitation to access the shared tutorials 

	As an invitee to access a shared tutorial,
    I want to access the tutorial shared with me
    so that I can view or edit the tutorial.

@function
Scenario Outline: check the Shared Tutorial email template 
### Using team owner to add a tag then invite an user
	Given I logged in iroad with user "<team_owner>" and password "<owner_password>" 
	# Go to Share tutorial popup
	When I click on the "left_menu.tutorials" button from the slide out menu 
	And I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	When I search for "<tutorials>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Invite an user
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.share_button" 
	And I click "tutorials.tab_share_tutorial_tab_invite" 
	Then The "tutorials.tab_share_tutorial_pane_invite" should be visible 
	When I fill value "<shared_user>" to "tutorials.tab_share_tutorial_pane_invite_input_email_txt" textbox 
	And I press Enter 
	And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn" 
	When Open gmail with user "<shared_user>" and password "<owner_password>"
    Then The element "servermail.checkout_link" should be shown in gmail
    When I click by javascript "servermail.checkout_link"
    When I switch to "<tutorials>" window
    And I should be able to play the tutorial to the last step
	
Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials									|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2	|	validpassword		|Live 6 - Premium - Public	|

@function
Scenario Outline: Access a shared public tutorial 
### Using team owner to add a tag then invite an user
	Given I logged in iroad with user "<team_owner>" and password "<owner_password>" 
	# Go to Share tutorial popup
	When I click on the "left_menu.tutorials" button from the slide out menu 
	And I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	When I search for "<tutorials>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Invite an user
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.share_button" 
	And I click "tutorials.tab_share_tutorial_tab_invite" 
	Then The "tutorials.tab_share_tutorial_pane_invite" should be visible 
	When I fill value "<shared_user>" to "tutorials.tab_share_tutorial_pane_invite_input_email_txt" textbox 
	And I press Enter 
	And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn" 
	When Open gmail with user "<shared_user>" and password "<owner_password>"
    Then The element "servermail.checkout_link" should be shown in gmail
    When I click by javascript "servermail.checkout_link"
    When I switch to "<tutorials>" window
    And I should be able to play the tutorial to the last step
	
Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials									|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2	|	validpassword		|Live 6 - Premium - Public	|

@function
Scenario Outline: Anonymous users accept accessing a private tutorial 
	### Using team owner to add a tag then invite an user
	Given I logged in iroad with user "<team_owner>" and password "<owner_password>" 
	# Go to Share tutorial popup
	When I click on the "left_menu.tutorials" button from the slide out menu 
	And I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	When I search for "<tutorials>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Invite an user
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.share_button" 
	And I click "tutorials.tab_share_tutorial_tab_invite" 
	Then The "tutorials.tab_share_tutorial_pane_invite" should be visible 
	When I fill value "<shared_user>" to "tutorials.tab_share_tutorial_pane_invite_input_email_txt" textbox 
	And I press Enter 
	And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn" 
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	When Open gmail with user "<shared_user>" and password "<owner_password>"
    Then The element "servermail.checkout_link" should be shown in gmail
    When I click by javascript "servermail.checkout_link"
    When I switch to "<tutorials>" window
    Given I logged in iroad with user "<shared_user>" and password "validpassword"
    Then I should be redirected to My tutorials tab 
	
Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials									|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2	|	validpassword		|- Premium - Private	|

@function
Scenario Outline: Logged-in users access a shared private tutorial 
### Using team owner to add a tag then invite an user
	Given I logged in iroad with user "<team_owner>" and password "<owner_password>" 
	# Go to Share tutorial popup
	When I click on the "left_menu.tutorials" button from the slide out menu 
	And I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	When I search for "<tutorials>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Invite an user
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.share_button" 
	And I click "tutorials.tab_share_tutorial_tab_invite" 
	Then The "tutorials.tab_share_tutorial_pane_invite" should be visible 
	When I fill value "<shared_user>" to "tutorials.tab_share_tutorial_pane_invite_input_email_txt" textbox 
	And I press Enter 
	And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn" 
	When Open gmail with user "<shared_user>" and password "<owner_password>"
    Then The element "servermail.checkout_link" should be shown in gmail
    When I click by javascript "servermail.checkout_link"
    When I switch to "<tutorials>" window
    And I should be able to play the tutorial to the last step
	
Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials									|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2	|	validpassword		|- Premium - Private	|

@function
Scenario Outline: unregistered users accept accessing a private tutorial 
### Using team owner to add a tag then invite an user
	Given I logged in iroad with user "<team_owner>" and password "<owner_password>" 
	# Go to Share tutorial popup
	When I click on the "left_menu.tutorials" button from the slide out menu 
	And I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	When I search for "<tutorials>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Invite an user
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.share_button" 
	And I click "tutorials.tab_share_tutorial_tab_invite" 
	Then The "tutorials.tab_share_tutorial_pane_invite" should be visible 
	When I fill value "<shared_user>" to "tutorials.tab_share_tutorial_pane_invite_input_email_txt" textbox 
	And I press Enter 
	And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn" 
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	When Open gmail with user "<shared_user>" and password "<owner_password>"
    Then The element "servermail.checkout_link" should be shown in gmail
    When I click by javascript "servermail.checkout_link"
    When I switch to "<tutorials>" window
    When I click "signup.signup_tab"
    When I fill value "validpublicname" to "signup.public_name" textbox
    When I fill value "<shared_user>" to "signup.email" textbox
    When I fill value "validpassword" to "signup.password" textbox
    When I click "signup.terms"
    Then The "signup.signup_button" should be enabled
    When I click "signup.signup_button"
    And I should be able to play the tutorial to the last step
	
Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials									|
    	|	teamowneruser1	|	validpassword		|	inviteunregisteredusers1@gmail.com	|	validpassword		|- Premium - Private	|

@function
Scenario Outline: Anonymous users accept co-editing a tutorial 
	Given I logged in iroad with user "<user>" and password "<password>"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # Switch to the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    # Set Edit right
    When I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "<shared_user>" should be invisible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>" should be enabled
    When I click on "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>"
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>" should be visible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_view_link" of "<shared_user>" should be visible
    When I click on "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>"
    Then I should see the message "Access updated."
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When Open gmail with user "<shared_user>" and password "validpassword"
    Then The element "servermail.checkout_link" should be shown in gmail
    When I click by javascript "servermail.checkout_link"
    When I switch to the second tab
    When I logged in iroad with user "<shared_user>" and password "<password>"
    And I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.share_edit_tab"
    Then I should be redirected to Shared Edit tab
    When I search for "<tutorial>" tutorial
    Then I should not see the message "No Results Found"
	Examples:
    |	user														|	password	|	tutorial					|	shared_user												|
    | iorad.teamowneruser1@gmail.com	|	validpassword		|	Live 1 - Premium	|	iorad.teammember1+demo@gmail.com	|
	
	
@function
Scenario Outline: Logged-in users accept co-editing a tutorial
	Given I logged in iroad with user "<user>" and password "<password>"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # Switch to the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    # Set Edit right
    When I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "<shared_user>" should be invisible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>" should be enabled
    When I click on "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>"
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>" should be visible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_view_link" of "<shared_user>" should be visible
    When I click on "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>"
    Then I should see the message "Access updated."
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When I logged in iroad with user "<shared_user>" and password "<password>"
    And I click on the "left_menu.tutorials" button from the slide out menu
    When Open gmail with user "<shared_user>" and password "validpassword"
    Then The element "servermail.checkout_link" should be shown in gmail
    When I click by javascript "servermail.checkout_link"
    When I switch to "Edit Tutorial" window
    Then I should be redirected to the Editor page to edit that tutorial
	Examples:
    |	user														|	password	|	tutorial					|	shared_user												|
     | iorad.teammember1@gmail.com			|	123456		| member tutorial 1	|	iorad.teammember1+demo@gmail.com	|
	
	
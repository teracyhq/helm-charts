Feature: The Shared page consists of tutorials shared with you.

    As a logged-in user,
    I want to access the Shared page
    so that I can see and play all tutorials shared with me.

		@smoke
    Scenario Outline: access the Shared page
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
	    Then I should see the message "Permission granted to"
	    When I click on the "left_menu.logout" button from the slide out menu 	
		Then I should be logged out and redirected to the home page
    	### Using the shared user to check the shared tutorials
		Given I logged in iroad with user "<shared_user>" and password "<user_password>"
			# Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    And The "tutorials.shared_tab.tutorial_name" should be visible
	    And The "tutorials.shared_tab.tutorial_shared_by" should be visible
	    And The "tutorials.shared_tab.tutorial_status" should be visible
	    And The "tutorials.shared_tab.tutorial_last_visit" should be visible
	    And The "tutorials.shared_tab.tutorial_action_btn" should be visible
	    When I search for "<tutorials>" tutorial
	    And I click "tutorials.shared_tab.tutorial_action_btn"
	    Then I should be redirected to the "<tutorial_builder>" page in new tab
   
    Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials									|	tutorial_builder					|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2	|	validpassword		|Live 6 - Premium - Public	|	Live-6---Premium---Public	|
    	
    Scenario Outline: play a shared tutorial
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
	    Then I should see the message "Permission granted to"
	    When I click on the "left_menu.logout" button from the slide out menu 	
			Then I should be logged out and redirected to the home page
    	### Using the shared user to check the shared tutorials
			Given I logged in iroad with user "<shared_user>" and password "<user_password>"
			# Go to Shared tab and play the shared tutorial
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    When I search for "<tutorials>" tutorial
	    Then The "tutorials.shared_tab.tutorial_name" should be visible
	    When I click "tutorials.shared_tab.tutorial_action_btn"
	    Then I switch to "iorad - the tutorial builder" window
	    And Switch to "tutorials.play_tutorial.tutorial_iframe" frame
	    When I click "tutorials.player.collapse_button"
	    And I play tutorial completedly
	    And Switch back to main frame
	    And I close the browser
	    # Switch to the iorad site
	    When I switch to "iorad" window
	    And I reload page
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    When I search for "<tutorials>" tutorial
	    Then The text of element "tutorials.shared_tab.tutorial_status" should contain "Completed"
   
    Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials										|	tutorial_builder												|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2	|	validpassword		|Live 5 - Premium - Unlisted	|	/player/416/Live-5---Premium---Unlisted	|
    	
    Scenario Outline: search all shared tutorials using Tutorial Name
    	### Using the shared user to check the shared tutorials
			Given I logged in iroad with user "<shared_user>" and password "<user_password>"
			# Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    When I search for "<tutorials>" tutorial
	    Then The text of elements "tutorials.shared_tab.tutorial_name" should contain "<tutorials>"
    
    Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials												|	
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 5 - Premium - Unlisted			|	
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 3 - Premium - Embed OnlOnly	|	
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 6 - Premium - Public				|	
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|tutorial created by the owner 1		  |	
    	
    Scenario Outline: search all shared tutorials using tags
    	### Using team owner to add a tag then invite an user
      Given I logged in iroad with user "<team_owner>" and password "<owner_password>"
	    # Go to Share tutorial popup
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I search for "<tutorials>" tutorial
	    Then The element "tutorials.name_tutorial_label" should be shown
	    # Add tag
	   	When I click "tutorials.add_tag_button"
			And I fill value "<tag>" to "tutorials.tag_textbox" textbox
			And I press Enter 
	    When I click on the "left_menu.logout" button from the slide out menu 	
			Then I should be logged out and redirected to the home page
    	### Using the shared user to check the shared tutorials
			Given I logged in iroad with user "<shared_user>" and password "<user_password>"
			# Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    When I search for "<tag>" tutorial
	    Then The text of elements "tutorials.shared_tab.tutorial_name" should be "<tutorials>"
    
    Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials														|	tag								|
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 5 - Premium - Unlisted					|	auto unlisted tag	|
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 3 - Premium - Embed OnlOnly			|	auto embed tag		|
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 6 - Premium - Public						|	auto public tag		|
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|tutorial created by the owner 1	  	|	auto private tag	|
    	
    Scenario Outline: search all shared tutorials using tutorial's description
    	### Using team owner to add a tag then invite an user
      Given I logged in iroad with user "<team_owner>" and password "<owner_password>"
	    # Go to Share tutorial popup
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I search for "<tutorials>" tutorial
	    Then The element "tutorials.name_tutorial_label" should be shown
	    # Add description
	   	When I click "tutorials.select_tutorial_chk"
	   	And I click "tutorials.add_category_or_tag_btn"
	   	And I click "tutorials.add_category_tag_modal.description_tab"
			And I fill value "<description>" to "tutorials.add_category_tag_modal.description_tab.description_textbox" textbox
			And I click "tutorials.add_category_tag_modal.apply_button" 
			Then I should see the message "Categories/Labels updated"
	    When I click on the "left_menu.logout" button from the slide out menu 	
			Then I should be logged out and redirected to the home page
    	### Using the shared user to check the shared tutorials
			Given I logged in iroad with user "<shared_user>" and password "<user_password>"
			# Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    When I search for "<description>" tutorial
	    Then The text of elements "tutorials.shared_tab.tutorial_name" should be "<tutorials>"
    
    Examples:
    	|	team_owner			| owner_password	|	shared_user			|	user_password	  |tutorials												|	description								|
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 5 - Premium - Unlisted			|	auto unlisted description	|
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 3 - Premium - Embed OnlOnly	|	auto embed description		|
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|Live 6 - Premium - Public				|	auto public description		|
    	|	teamowneruser1	|	validpassword		|	teammemberuser	|	validpassword		|tutorial created by the owner 1	|	auto private description	|
    	
    	
    Scenario Outline: search unlisted tutorials not shared with you
    	### Using team owner to remove shared permission for an user first
    	Given I logged in iroad with user "<team_owner>" and password "<owner_password>"
	    # Go to Share tutorial popup
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I search for "<unlisted_tutorial>" tutorial
	    And I click "tutorials.three_dot_icon"
	    And I click "tutorials.share_button"
	    # At the Assign tab, Remove shared permission if any
    	When I click "tutorials.tab_share_tutorial_tab_assign"
    	Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
			And I delete the email "<unshared_user>" from the Assign tab
			When I click on the "left_menu.logout" button from the slide out menu 	
			Then I should be logged out and redirected to the home page
			### Using the unshared user to check the unshared tutorials
			Given I logged in iroad with user "<unshared_user>" and password "<user_password>"
			# Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    When I search for "<unlisted_tutorial>" tutorial
	    Then I should see the message "No Results Found"
         
    Examples:
    	|	team_owner			| owner_password	|	unshared_user			  	|	user_password	  |	unlisted_tutorial						|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2				|	validpassword		|Live 5 - Premium - Unlisted	|	
         
    Scenario Outline: search embed only tutorials not shared with you
    	### Using team owner to remove shared permission for an user first
    	Given I logged in iroad with user "<team_owner>" and password "<owner_password>"
	    # Go to Share tutorial popup
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I search for "<embed_tutorial>" tutorial
	    And I click "tutorials.three_dot_icon"
	    And I click "tutorials.share_button"
	    # At the Assign tab, Remove shared permission if any
    	When I click "tutorials.tab_share_tutorial_tab_assign"
    	Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
			And I delete the email "<unshared_user>" from the Assign tab
			When I click on the "left_menu.logout" button from the slide out menu 	
			Then I should be logged out and redirected to the home page
			### Using the unshared user to check the unshared tutorials
			Given I logged in iroad with user "<unshared_user>" and password "<user_password>"
			# Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    When I search for "<embed_tutorial>" tutorial
	    Then I should see the message "No Results Found"
         
    Examples:
    	|	team_owner			| owner_password	|	unshared_user			  	|	user_password	  |	embed_tutorial										|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2				|	validpassword		| Live 3 - Premium - Embed OnlOnly	|	
    	
 
    Scenario Outline: search private tutorials not shared with you
    	### Using team owner to remove shared permission for an user first
    	Given I logged in iroad with user "<team_owner>" and password "<owner_password>"
	    # Go to Share tutorial popup
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I search for "<private_tutorial>" tutorial
	    And I click "tutorials.three_dot_icon"
	    And I click "tutorials.share_button"
	    # At the Assign tab, Remove shared permission if any
    	When I click "tutorials.tab_share_tutorial_tab_assign"
    	Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
			And I delete the email "<unshared_user>" from the Assign tab
			When I click on the "left_menu.logout" button from the slide out menu 	
			Then I should be logged out and redirected to the home page
			### Using the unshared user to check the unshared tutorials
			Given I logged in iroad with user "<unshared_user>" and password "<user_password>"
			# Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    When I search for "<private_tutorial>" tutorial
	    Then I should see the message "No Results Found"
         
    Examples:
    	|	team_owner			| owner_password	|	unshared_user			  	|	user_password	  |	private_tutorial						|
    	|	teamowneruser1	|	validpassword		|	teammemberuser2				|	validpassword		| Live 4  - Premium - Private	|	
    	
    
    Scenario Outline: sort tutorial list by NAME
	    Given I logged in iroad with user "<shared_user>" and password "<user_password>"
	    # Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    # Sort by 'NAME'
	    When I click "tutorials.shared_tab.name_header"
	    Then The tutorials should be sorted by "shared_tab.tutorial_name" in the "ascending" order
	    When I click "tutorials.shared_tab.name_header"
	    Then The tutorials should be sorted by "shared_tab.tutorial_name" in the "descending" order    

			Examples:
	    |	shared_user						|	user_password	|
	    |	googleteammemberuser	|	validpassword	|
	    
	    Scenario Outline: sort tutorial list by SHARED BY
	    Given I logged in iroad with user "<shared_user>" and password "<user_password>"
	    # Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    # Sort by 'SHARED BY'
	   	When I click "tutorials.shared_tab.shared_by_header"
	    Then The tutorials should be sorted by "shared_tab.shared_by" in the "ascending" order
	    When I click "tutorials.shared_tab.shared_by_header"
	    Then The tutorials should be sorted by "shared_tab.shared_by" in the "descending" order
	    
	    Examples:
	    |	shared_user						|	user_password	|
	    |	googleteammemberuser	|	validpassword	|
	    
    Scenario Outline: sort tutorial list by STATUS
	    Given I logged in iroad with user "<shared_user>" and password "<user_password>"
	    # Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    # Sort by 'STATUS'
	   	When I click "tutorials.shared_tab.status_header"
	    Then The tutorials should be sorted by "shared_tab.status" in the "ascending" order
	    When I click "tutorials.shared_tab.status_header"
	    Then The tutorials should be sorted by "shared_tab.status" in the "descending" order
	    
	    Examples:
	    |	shared_user						|	user_password	|
	    |	googleteammemberuser	|	validpassword	|
	    
    Scenario Outline: sort tutorial list by LAST VISIT
	    Given I logged in iroad with user "<shared_user>" and password "<user_password>"
	    # Go to Shared tab
	    When I click on the "left_menu.tutorials" button from the slide out menu
	    And I click "tutorials.my_tutorial_tab"
	    Then I should be redirected to My tutorials tab
	    When I click "tutorials.shared_tab"
	    Then I should be redirected to the Shared page
	    # Sort by 'LAST VISIT'
	   	When I click "tutorials.shared_tab.last_visit_header"
	    Then The tutorials should be sorted by "shared_tab.last_visit" in the "ascending" order
	    When I click "tutorials.shared_tab.last_visit_header"
	    Then The tutorials should be sorted by "shared_tab.last_visit" in the "descending" order
	    
	    Examples:
	    |	shared_user						|	user_password	|
	    |	googleteammemberuser	|	validpassword	|
	    
    # the category / label on the left not available  
    @wip
    Scenario: search tutorials with the category / label on the left
        Given I am at the Shared tab
         When I click any category / label on the left
         Then The tutorials which has the selected category / label should be shown
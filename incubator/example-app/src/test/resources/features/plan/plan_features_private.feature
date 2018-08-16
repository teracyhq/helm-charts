 @test1
Feature: The features on each plan 

	As a logged-in user, I subscribe any plan
	so that I can use the features supported for the plan

############ PRIVATE PLAN ##############
Scenario: Private Plan - change the creators (1) 
	Given I logged in iroad with user "privateplanyearlyuser1" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	And Store the number of creator in variable "var_creator" 
	And The variable "var_creator" should be equal "1"
	And The element "checkout.more_creator_button_hide" should be shown
	And The element "checkout.less_creator_button_hide" should be shown
	
#bug: https://github.com/iorad/iorad/issues/6102
Scenario: Private Plan - share tutorial privately (2) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	When I am at "/tutorials" 
	When I click "tutorials.my_tutorial_tab"
    When I should see the My tutorials page content
    And I search for "share private special domain" tutorial
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.share_button"
	Then I should be redirected to the Shared Editor page
	And I click "tutorials.tab_share_tutorial_tab_invite"
	Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
	When I click "tutorials.tab_share_tutorail_pane_invite_domain_checkbox"
	Then The text of element "tutorials.notification_message" should be "Domain 'iorad.com' successfully allowed."
	
	#veify share tutorial successfully
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser2" and password "validpassword" 
	When I am at "/tutorials" 
	When I click on the "left_menu.tutorials" button from the slide out menu
	When I click "tutorials.shared_tab"
	Then I should be redirected to the Shared page
	When I search for "share private special domain" tutorial
	Then The text of elements "tutorials.shared_tab.tutorial_name" should contain "share private special domain"
	
#can not mask featrue
#Private plan: upgrade to apply the mask
@fail
Scenario: Private Plan - use the mask data feature (3) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	Given I am at "/tutorials" 
	When I click "tutorials.my_tutorial_tab"
    When I should see the My tutorials page content
    And I search for "share private special domain" tutorial
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.mask_step"
	Then I should see the message "Drag your mouse over the area you want to mask." 
	When I click on "tutorials.editor_canvas" and drag my mouse over by offset 5 and 5
	Then I should see the message "This is permanent. Are you sure?"
	When I click "tutorials.edit_tutorial.mask.iam_sure_button" 
	#Then The data should be masked 
	
Scenario: Private Plan - change the privacy of the tutorial (4) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	# Access the Finish page and set to Private
	When I am at "/tutorials" 
	When I click "tutorials.my_tutorial_tab"
    When I should see the My tutorials page content
    And I search for "share private special domain" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.access_permission.selectize_control"
    And I select "Private" from the selection list "tutorials.settings.access_permission.selectize_options"
    And I click "tutorials.finish_button"
    Then I should see the My tutorials page content
    
	# Access the Finish page and set to Public
	When I am at "/tutorials" 
	When I click "tutorials.my_tutorial_tab"
    When I should see the My tutorials page content
    And I search for "share private special domain" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    Then The text of element "tutorials.settings.access_permission.selectize_control" should be "Private"
    When I click "tutorials.settings.access_permission.selectize_control"
    And I select "Public" from the selection list "tutorials.settings.access_permission.selectize_options"
    Then I should see the message "Saved"
    And I click "tutorials.finish_button"
    Then I should see the My tutorials page content
    
    # Access the Finish page and set to Unlisted
    And I search for "share private special domain" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
	 # Set to Unlisted
	Then The text of element "tutorials.settings.access_permission.selectize_control" should be "Public"
    When I click "tutorials.settings.access_permission.selectize_control"
    And I select "Unlisted" from the selection list "tutorials.settings.access_permission.selectize_options"
    Then I should see the message "Saved"
    And I click "tutorials.finish_button"
    Then I should see the My tutorials page content
    
    # Access the Finish page and set to Embed Only
    And I search for "share private special domain" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
	 # Set to Embed Only
	Then The text of element "tutorials.settings.access_permission.selectize_control" should be "Unlisted"
    When I click "tutorials.settings.access_permission.selectize_control"
    And I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options"
    When I fill value "iorad.net" to "tutorials.settings.embed_tab.allow_domain_textbox" textbox
    And I press Enter
    Then I should see the message "Saved"
    And I click "tutorials.finish_button"
    And wait for 5 seconds
    Then I should see the My tutorials page content
    
    # Verify that the current pricary is Embed Only
    And I search for "share private special domain" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
	 # Set to Embed Only
	Then The text of element "tutorials.settings.access_permission.selectize_control" should be "Embed Only"
	
Scenario: Private Plan - export PDF file (5) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	When I am at "/tutorials" 
	When I click "tutorials.my_tutorial_tab"
	When I should see the My tutorials page content
    And I search for "share private special domain" tutorial
    And Store the text of element "tutorials.my_tutorials.tutorial_name" in variable "tutorial_name_var"
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.play" 
	Then I should be redirected to the player page of the tutorial 
	And I click "tutorials.play_pdf_link"
	And I click "tutorials.play_pdf_portrait"
	And wait for 5 seconds
	Then File PDF "tutorial_name_var" should exists
	And I click "tutorials.play_pdf_landscape"
	And wait for 5 seconds
	Then File PDF "tutorial_name_var" should exists
	
#Private plan: upgrade to apply the mask
@fail
Scenario: Private Plan - Check if mask feature is supported or not (6) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.mask_step"
	Then I should see the message "Drag your mouse over the area you want to mask." 
	When I click on "tutorials.editor_canvas" and drag my mouse over by offset 5 and 5
	Then I should see the message "Your plan does not include the Mask Data feature" 
	And The element "tutorials.edit_tutorial.contact_us_msg" should be shown
	
#still use audio feature
@fail
Scenario: Private Plan - Check if audio feature is supported or not (6) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	When I should see the My tutorials page content
    And I search for "share private special domain" tutorial
    And I click "tutorials.three_dot_icon"
	And I click "tutorials.audio" 
	Then I should see the message "Your plan does not include this feature" 
	And The element "tutorials.edit_tutorial.contact_us_msg" should be shown
	
Scenario: Private Plan - check if the logo supported is supported or not (7) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	When I click on the "left_menu.tutorials" button from the slide out menu
    Then I should see the My tutorials page content
   	And I search for "share private special domain" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    # At the Custom Theme page
    When I click "tutorials.settings.customize_theme"
	Then I should see the message "Your plan does not include this feature" 
	And The element "tutorials.edit_tutorial.contact_us_msg" should be shown
	
#can not install extension automaticly
@wip
Scenario: Private Plan - create more live tutorial than the limit (8) 
	Given I am logged-in 
	And I already subscribed the PRIVATE plan 
	And I already have 5 live tutorials 
	When I duplicate a live tutorial 
	Then I should see the notification "You are over your live tutorial limit." 
	When I create a tutorial with iorad extension 
	And I check the Live mode in the Settings page 
	Then I should see the notification "Your Live tutorial limit is reached. Please contact us to add more.Contact Us" 
	
Scenario: Private plan - view the analytics of a tutorial (9) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	When I click on the "left_menu.tutorials" button from the slide out menu
    Then I should see the My tutorials page content
   	And I search for "share private special domain" tutorial
    And I click "tutorials.three_dot_icon"
	And I click "tutorials.statistics" 
	Then I should be redirected to the Statistics page 
	And I should see the notification "Sample data. Your plan does not include this feature." 
	And The element "tutorials.edit_tutorial.contact_us_msg" should be shown
	
# currently, free users alllow using Connect with Zendesk / Slack
#still connect zendesk, website and slack binh thuong
@fail
Scenario: Private Plan - publish tutorials to your help center using intergration (10) 
	Given I logged in iroad with user "privateplanyearlyspecialdomainuser1" and password "validpassword" 
	When I click on the "left_menu.connect" button from the slide out menu 
	Then I should be redirected to the Integrations page 
	Then The element "iorad_connect.connect_zendesk_button" should not be shown
	Then The element "iorad_connect.connect_your_website_button" should not be shown
	Then The element "iorad_connect.connect_slack_button" should not be shown
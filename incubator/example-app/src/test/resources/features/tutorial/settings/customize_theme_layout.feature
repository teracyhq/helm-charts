Feature: Customize theme, tool color and layout
  
    As a logged-in user
    I want to customize theme, tool color and layout
    so I can use my own theme, tool color and layout

  Scenario Outline: Select a theme
    Given I logged in iroad with user "<user>" and password "<password>"
    When I click on the "left_menu.tutorials" button from the slide out menu
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    # At the Custom Theme page
    When I click "tutorials.settings.customize_theme"
	Then The "tutorials.settings.customize_theme.theme_control" should be visible
	# See 4 themes
	When I click "tutorials.settings.customize_theme.theme_control"
	Then The "tutorials.settings.customize_theme.theme_options" of "<theme_1>" should be visible
	And The "tutorials.settings.customize_theme.theme_options" of "<theme_2>" should be visible
	And The "tutorials.settings.customize_theme.theme_options" of "<theme_3>" should be visible
	And The "tutorials.settings.customize_theme.theme_options" of "<theme_4>" should be visible
	And I click "tutorials.settings.customize_theme.theme_control"
	# Try to select a theme
	When I click "tutorials.settings.customize_theme.theme_control"
	And I click on "tutorials.settings.customize_theme.theme_options" of "<theme_1>"
	Then The text of element "tutorials.settings.customize_theme.selected_theme" should contain "<theme_1>"
	When I click "tutorials.settings.customize_theme.theme_control"
	And I click on "tutorials.settings.customize_theme.theme_options" of "<theme_2>"
	Then The text of element "tutorials.settings.customize_theme.selected_theme" should contain "<theme_2>"
	When I click "tutorials.settings.customize_theme.theme_control"
	And I click on "tutorials.settings.customize_theme.theme_options" of "<theme_3>"
	Then The text of element "tutorials.settings.customize_theme.selected_theme" should contain "<theme_3>"
	When I click "tutorials.settings.customize_theme.theme_control"
	And I click on "tutorials.settings.customize_theme.theme_options" of "<theme_4>"
	Then The text of element "tutorials.settings.customize_theme.selected_theme" should contain "<theme_4>"

    Examples:
    |	user									|	password			| tutorial				| theme_1			|	theme_2			|	theme_3		|	theme_4		|
    |	premiumindividualuser	|	validpassword	|	Public tutorial	|	Light Theme	|	Dark Theme	|	Space Theme	|	Custom 1	|

  Scenario Outline: Free user uses the custom theme for the premium tutorial
  	When I logged in iroad with user "googlefreeverifieduseruser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    And The element "tutorials.settings.customize_theme.upgrade_notification" should not be shown
    # Try to switch to Layout tab
    When I click "tutorials.settings.customize_theme.layout_tab"
    Then The element "tutorials.settings.customize_theme.upgrade_notification" should not be shown
    # Upload a valid file
    When I click "tutorials.settings.customize_theme.player_tab"
    And Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		# The customized theme (contains new logo) applied for preview
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should contain "custom-logo"
		When Switch back to parent frame
		And I click "tutorials.settings.customize_theme.close_theme_btn"
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should contain "custom-logo"
		# Check the player should be applied new logo as well
		When Switch back to parent frame
		And I click "tutorials.finish_button"
		And Switch back to parent frame
		When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.play" and switch to the second tab
    And Switch to "tutorials.iorad_app_iframe" frame
    Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should contain "custom-logo"
    
    Examples:
    | tutorial 	 |	valid_logo_file												|
    | tutorial 1 | \src\test\resources\testdata\pic1.jpeg	|

  Scenario Outline: Free user uses the custom theme for the non-premium tutorial
  	When I logged in iroad with user "googlefreeverifieduseruser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    And The element "tutorials.settings.customize_theme.upgrade_notification" should be shown
    # Upload a valid file
    When I click "tutorials.settings.customize_theme.player_tab"
    And Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		# Try to switch to Layout tab and edit the Visibility options
    When I click "tutorials.settings.customize_theme.layout_tab"
    Then The element "tutorials.settings.customize_theme.upgrade_notification" should be shown
    When I click "tutorials.settings.customize_theme.all_selected_control"
    And I check "tutorials.settings.customize_theme.all_selected_control.share"
    And I check "tutorials.settings.customize_theme.all_selected_control.live"
    And I check "tutorials.settings.customize_theme.all_selected_control.pdf"
    And I check "tutorials.settings.customize_theme.all_selected_control.language"
    And I check "tutorials.settings.customize_theme.all_selected_control.logo"
    And I check "tutorials.settings.customize_theme.all_selected_control.info"
    And I check "tutorials.settings.customize_theme.all_selected_control.fullscreen"
    Then The "tutorials.settings.customize_theme.all_selected_control.select_all" checkbox should be checked
    When I uncheck "tutorials.settings.customize_theme.all_selected_control.share"
    Then The "tutorials.settings.customize_theme.all_selected_control.select_all" checkbox should be unchecked
		# The customized theme (contains new logo) not applied for preview
		When  I click "tutorials.settings.customize_theme.close_theme_btn"
		And Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should be "logo"
		# Check the player should not be applied new logo as well
		When Switch back to parent frame
		And I click "tutorials.finish_button"
		And Switch back to parent frame
		When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.play" and switch to the second tab
    And Switch to "tutorials.iorad_app_iframe" frame
		Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should be "logo"
		And The element "tutorials.play_tutorial.default_logo_img" should be shown
    
    Examples:
    | tutorial 			 								|	valid_logo_file													|
    | Live tutorial for free user 1 | \src\test\resources\testdata\pic1.jpeg	|

  Scenario Outline: check if customized theme applied after user upgrades the plan
  	When I logged in iroad with user "googlefreeverifieduseruser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    And The element "tutorials.settings.customize_theme.upgrade_notification" should be shown
    # Upload a valid file
    When I click "tutorials.settings.customize_theme.player_tab"
    And Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		# Upgrade a premium plan
		When I click "tutorials.settings.customize_theme.upgrade_link"
		And Switch back to parent frame
		Then I should be redirected to the "/upgrade" page 
		When I click "pricing.go_live_button" 
		Then I should be redirected to the "/checkout/live" page 
		And The "checkout.checkout_button" should be disabled 
		And The "checkout.monthly" checkbox should be checked 
		When I fill value "checkout.card_number_value" to "checkout.card_number" textbox 
		When I fill value "checkout.expdate_value" to "checkout.expdate" textbox 
		When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
		Then The "checkout.checkout_button" should be enabled 
		When I click "checkout.checkout_button" 
		Then I should be redirected to Thank You page 
		# Check the customize theme of tutorial
		When I click on the "left_menu.tutorials" button from the slide out menu
	  And I click "tutorials.my_tutorial_tab"
	  Then I should be redirected to My tutorials tab
		When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.play" and switch to the second tab
    And Switch to "tutorials.iorad_app_iframe" frame
    Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should contain "custom-logo"
		
    
    Examples:
    | tutorial 	   |	valid_logo_file												|
    | tutorial 3	 | \src\test\resources\testdata\pic1.jpeg	|
   
  Scenario Outline: Premium user customize the theme
  	When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    And The element "tutorials.settings.customize_theme.upgrade_notification" should not be shown
    # Try to switch to Layout tab
    When I click "tutorials.settings.customize_theme.layout_tab"
    Then The element "tutorials.settings.customize_theme.upgrade_notification" should not be shown
    # Upload a valid file
    When I click "tutorials.settings.customize_theme.player_tab"
    And Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		# The customized theme (contains new logo) applied for preview
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should contain "custom-logo"
		When Switch back to parent frame
		And I click "tutorials.settings.customize_theme.close_theme_btn"
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should contain "custom-logo"
		# Check the player should be applied new logo as well
		When Switch back to parent frame
		And I click "tutorials.finish_button"
		And Switch back to parent frame
		When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.play" and switch to the second tab
    And Switch to "tutorials.iorad_app_iframe" frame
    Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should contain "custom-logo"
    
    Examples:
    | tutorial 			 	|	valid_logo_file													|
    | Public tutorial | \src\test\resources\testdata\pic1.jpeg	|


  Scenario Outline: Upload logo
  	When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a valid file
    When Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should contain "custom-logo"
		
    Examples:
    | tutorial 			 	|	valid_logo_file													|
    | Public tutorial | \src\test\resources\testdata\pic1.jpeg	|
    
  Scenario Outline: remove the logo
  	When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a valid file
    When Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		# Remove the logo
		When I click "tutorials.settings.customize_theme.remove_logo_btn"
		Then The element "tutorials.settings.customize_theme.added_logo" should not be shown
		And The element "tutorials.settings.customize_theme.logo_link" should not be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should not be shown
   	When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The attribute "class" of element "tutorials.play_tutorial.logo_image" should be "logo"
		And The element "tutorials.play_tutorial.default_logo_img" should be shown
    Examples:
    | tutorial 			 	|	valid_logo_file													|
    | Public tutorial | \src\test\resources\testdata\pic1.jpeg	|

  Scenario Outline: Add logo link with valid link
    When I logged in iroad with user "premiumindividualuser1" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a valid file
    When Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
    # Add logo link
    When I fill value "<valid_logo_link>" to "tutorials.settings.customize_theme.logo_link" textbox
    And I press Enter
    Then The attribute "value" of element "tutorials.settings.customize_theme.logo_link" should be "<valid_logo_link>"
    # Save
    When I click "tutorials.settings.customize_theme.close_theme_btn"
    And I click "tutorials.finish_button"
    And Switch back to parent frame
    Then I should see the My tutorials page content
    # Play the tutorial 
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.play"
    Then I switch to "<tutorial>" window
    And I close other tabs
    # Check the logo link
    When Switch to "tutorials.iorad_app_iframe" frame
    Then The attribute "href" of element "tutorials.play_tutorial.logo_image" should be "<valid_logo_link>"
    When I click "tutorials.play_tutorial.logo_image" and switch to the second tab
    Then The url should be "<valid_logo_link>"
    Examples:
    | tutorial 																		|	valid_logo_file													|	valid_logo_link			|
    | Public tutorial having mask data at Step 12	| \src\test\resources\testdata\pic1.jpeg	|	https://commons.wikimedia.org/wiki/File:JPEG_example_JPG_RIP_100.jpg	|
    

  Scenario Outline: Add logo link with invalid link
    When I logged in iroad with user "premiumindividualuser1" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a valid file
    When Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
    # Add logo link
    When I fill value "<invalid_logo_link>" to "tutorials.settings.customize_theme.logo_link" textbox
    And I press Enter
    Then The attribute "value" of element "tutorials.settings.customize_theme.logo_link" should be ""
    Examples:
    | tutorial 																		|	valid_logo_file													|	invalid_logo_link	|
    | Public tutorial having mask data at Step 12	| \src\test\resources\testdata\pic1.jpeg	|	auto test					|
    
  # Change background color
  Scenario Outline: Change the background color from the logo
  	When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a valid file
    When Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		# Change background color by clicking on logo
		When I click "tutorials.settings.customize_theme.added_logo"
		And Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal "#000000"
		
    Examples:
    | tutorial 			 	|	valid_logo_file																				|
    | Public tutorial | \src\test\resources\testdata\black_image_#000000.png	|
    
  Scenario Outline: Select background color from the color picker
    When I logged in iroad with user "premiumindividualuser2" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Open color picker
    When Store the value of element "tutorials.settings.customize_theme.background_color_textbox" in variable "previous_color"
    And I click "tutorials.settings.customize_theme.background_color_textbox"
    Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be visible
    And The "tutorials.settings.customize_theme.background_color_picker.cancel_btn" should be visible
    # Use picker
    When I click "tutorials.settings.customize_theme.background_color_picker.color_panel" by random offset
    And I click "tutorials.settings.customize_theme.background_color_picker.submit_btn"
    Then I should see the message "Saved"
    And The "tutorials.settings.customize_theme.background_color_picker.color_panel" should be invisible
    When Store the value of element "tutorials.settings.customize_theme.background_color_textbox" in variable "current_color"
    Then The variable "previous_color" should not be equal to variable "current_color"
   	When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal variable "current_color"
		
		Examples:
    | tutorial 		 |		
    | Premium tutorial | 	 

  Scenario Outline: Cancel selecting background color from the color picker
    When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Open color picker
    When Store the value of element "tutorials.settings.customize_theme.background_color_textbox" in variable "previous_color"
    And I click "tutorials.settings.customize_theme.background_color_textbox"
    Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be visible
    And The "tutorials.settings.customize_theme.background_color_picker.cancel_btn" should be visible
    # Use picker
    When I click "tutorials.settings.customize_theme.background_color_picker.color_panel" by random offset
    And I click "tutorials.settings.customize_theme.background_color_picker.cancel_btn"
    Then The "tutorials.settings.customize_theme.background_color_picker.color_panel" should be invisible
    When Store the value of element "tutorials.settings.customize_theme.background_color_textbox" in variable "current_color"
    Then The variable "previous_color" should be equal to variable "current_color"
   	When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal variable "previous_color"
		Examples:
    | tutorial 		 |		
    | Premium user | 	 

  Scenario Outline: Change the background color from logo without the color picker
  	When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a valid file
    When Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		# Check the background color after uploading
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal "#ffffff"
		# Change background color by clicking on logo
		When Switch back to parent frame
		And I click "tutorials.settings.customize_theme.added_logo"
		Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should be "#000000"
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal "#000000"
		
    Examples:
    | tutorial 			 	|	valid_logo_file																				|
    | Public tutorial | \src\test\resources\testdata\black_image_#000000.png	|
    
  Scenario Outline: Change the background color from logo with the color picker
    When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a valid file
    When Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		And The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should be "#ffffff"
		# Open the picker
		When I click "tutorials.settings.customize_theme.background_color_textbox"
		Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be visible
    And The "tutorials.settings.customize_theme.background_color_picker.cancel_btn" should be visible
    # Change background color by clicking on logo
		When I click "tutorials.settings.customize_theme.added_logo" by random offset
		Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should be "#000000"
		# Before Select, The background color of the theme should not be changed
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal "#ffffff"
		# After Select, The selected color should be applied for the theme
		When Switch back to parent frame
		And I click "tutorials.settings.customize_theme.background_color_picker.submit_btn"
		And Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal "#000000"
		
    Examples:
    | tutorial 			 	|	valid_logo_file																				|
    | Public tutorial | \src\test\resources\testdata\black_image_#000000.png	|

  Scenario Outline: Cancel changing the background color from logo with the color picker
 	  When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a valid file
    When Upload file "<valid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Saved"
    And The element "tutorials.settings.customize_theme.logo_link" should be shown
    And The element "tutorials.settings.customize_theme.remove_logo_btn" should be shown
		And The "tutorials.settings.customize_theme.added_logo" should be visible
		And The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should be "#ffffff"
		# Open the picker
		When I click "tutorials.settings.customize_theme.background_color_textbox"
		Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be visible
    And The "tutorials.settings.customize_theme.background_color_picker.cancel_btn" should be visible
    # Change background color by clicking on logo
		When I click "tutorials.settings.customize_theme.added_logo" by random offset
		Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should be "#000000"
		# Before Select, The background color of the theme should not be changed
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal "#ffffff"
		# After Select, The selected color should be applied for the theme
		When Switch back to parent frame
		And I click "tutorials.settings.customize_theme.background_color_picker.cancel_btn"
		And Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal "#ffffff"
		
		Examples:
    | tutorial 			 	|	valid_logo_file																				|
    | Public tutorial | \src\test\resources\testdata\black_image_#000000.png	|
	
	@wip @manual
  Scenario Outline: Change the background color from screenshot without color picker
 	  When I logged in iroad with user "premiumindividualuser2" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
		# I click on the screenshot at a specific point (100, 100)
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		And I click "tutorials.settings.view_desktop_mode.collapse_btn"
		And I click on canvas "tutorials.settings.view_desktop_mode.screenshot_canvas" by offset 100 and 100
		And I store the color of canvas screenshot at offset 100 and 100 into variable "saved_canvas_color"
		Then The background color of player should equal variable "saved_canvas_color"
		When Switch back to parent frame
		Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should equal variable "saved_canvas_color"
		# I click on the screenshot at a specific point (200, 200)
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		And I click "tutorials.settings.view_desktop_mode.collapse_btn"
		And I click on canvas "tutorials.settings.view_desktop_mode.screenshot_canvas" by offset 200 and 200
		And I store the color of canvas screenshot at offset 200 and 200 into variable "saved_canvas_color"
		Then The background color of player should equal variable "saved_canvas_color"
		When Switch back to parent frame
		Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should equal variable "saved_canvas_color"
		# I click on the screenshot at a specific point (300, 300)
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		And I click "tutorials.settings.view_desktop_mode.collapse_btn"
		And I click on canvas "tutorials.settings.view_desktop_mode.screenshot_canvas" by offset 300 and 300
		And I store the color of canvas screenshot at offset 300 and 300 into variable "saved_canvas_color"
		Then The background color of player should equal variable "saved_canvas_color"
		When Switch back to parent frame
		Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should equal variable "saved_canvas_color"
    
    Examples:
    | tutorial 	|	
    | Premium 4 | 
    
   @wip @manual
  Scenario Outline: Change theme color from screenshot with color picker
  	When I logged in iroad with user "premiumindividualuser2" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Open the picker
		When I click "tutorials.settings.customize_theme.background_color_textbox"
		Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be visible
    And The "tutorials.settings.customize_theme.background_color_picker.cancel_btn" should be visible
    When Store the value of element "tutorials.settings.customize_theme.background_color_textbox" in variable "previous_color"
		# I click on the screenshot at a specific point (10, 10)
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		And I click "tutorials.settings.view_desktop_mode.collapse_btn"
		And I click on canvas "tutorials.settings.view_desktop_mode.screenshot_canvas" by offset 40 and 40
		And I store the color of canvas screenshot at offset 40 and 40 into variable "saved_canvas_color"
		Then The background color of player should equal variable "previous_color"
		When Switch back to parent frame
		Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should equal variable "saved_canvas_color"
		When I click "tutorials.settings.customize_theme.background_color_picker.submit_btn"
		Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be invisible
		When  Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal variable "saved_canvas_color"
    
    Examples:
    | tutorial 	|	
    | Premium 2 |

	@wip @manual
  Scenario Outline: Cancel changing theme color from screenshot with color picker
  	When I logged in iroad with user "premiumindividualuser2" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Open the picker
		When I click "tutorials.settings.customize_theme.background_color_textbox"
		Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be visible
    And The "tutorials.settings.customize_theme.background_color_picker.cancel_btn" should be visible
    When Store the value of element "tutorials.settings.customize_theme.background_color_textbox" in variable "previous_color"
		# I click on the screenshot at a specific point (10, 10)
		When Switch to "tutorials.settings.preview_tutorial_frame" frame
		And I click "tutorials.settings.view_desktop_mode.collapse_btn"
		And I click on canvas "tutorials.settings.view_desktop_mode.screenshot_canvas" by offset 40 and 40
		And I store the color of canvas screenshot at offset 40 and 40 into variable "saved_canvas_color"
		Then The background color of player should equal variable "previous_color"
		When Switch back to parent frame
		Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should equal variable "saved_canvas_color"
		When I click "tutorials.settings.customize_theme.background_color_picker.submit_btn"
		Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be invisible
		When  Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal variable "previous_color"
    
    Examples:
    | tutorial 	|	
    | Premium 2 |

	# Issue: https://github.com/iorad/iorad/issues/6078
	@fail
  Scenario Outline: Set theme color by typing into the color box
  	When I logged in iroad with user "premiumindividualuser2" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Open color picker
    When I click "tutorials.settings.customize_theme.background_color_textbox"
    Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be visible
    And The "tutorials.settings.customize_theme.background_color_picker.cancel_btn" should be visible
    # I type invalid color in the color box
    When Store the value of element "tutorials.settings.customize_theme.background_color_textbox" in variable "previous_color"
    And I fill value "<invalid_color>" to "tutorials.settings.customize_theme.background_color_textbox" textbox
    And I click "tutorials.settings.customize_theme.background_color_picker.submit_btn"
    Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should equal variable "previous_color"
    # I type valid color
    When I click "tutorials.settings.customize_theme.close_theme_btn"
    And I click "tutorials.settings.customize_theme"
    And I fill value "<valid_color>" to "tutorials.settings.customize_theme.background_color_textbox" textbox
    And I click "tutorials.settings.customize_theme.background_color_picker.submit_btn"
    Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should be "<valid_color>"
   	When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal "<valid_color>"
		
    Examples:
    | tutorial 		 |	invalid_color	|	valid_color	|
    | Premium 3    |  wwwwwwww			| #2bd6d6			|
    
  Scenario Outline: Check the Cancel button on the color picker box
    When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Open color picker
    When I click "tutorials.settings.customize_theme.background_color_textbox"
    Then The "tutorials.settings.customize_theme.background_color_picker.submit_btn" should be visible
    And The "tutorials.settings.customize_theme.background_color_picker.cancel_btn" should be visible
    # I type invalid color in the color box
    When Store the value of element "tutorials.settings.customize_theme.background_color_textbox" in variable "previous_color"
    And I fill value "<invalid_color>" to "tutorials.settings.customize_theme.background_color_textbox" textbox
    And I click "tutorials.settings.customize_theme.background_color_picker.cancel_btn"
    Then The attribute "value" of element "tutorials.settings.customize_theme.background_color_textbox" should equal variable "previous_color"
   	When Switch to "tutorials.settings.preview_tutorial_frame" frame
		Then The background color of player should equal variable "previous_color"
		
    Examples:
    | tutorial 		 |		valid_color	|
    | Premium user | 	 #2bd6d6			|

  Scenario Outline: Upload an invalid logo /background file type
    When I logged in iroad with user "premiumindividualuser1" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a file
    When Upload file "<invalid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Upload failed. Invalid extension, supported types are png, jpeg, jpg, gif, svg."
    When Upload file "<invalid_background_file>" at the element "tutorials.settings.customize_theme.background_file"
    Then I should see the message "Upload failed. Invalid extension, supported types are png, jpeg, jpg, gif, svg."
    Examples:
    | tutorial 												|	invalid_logo_file														|	invalid_background_file											|
    | Public Plan having custom theme	| \src\test\resources\testdata\doc_file.docx	| \src\test\resources\testdata\doc_file.docx	|

  Scenario Outline: Upload an invalid logo /background file changed the extension into valid type
      When I logged in iroad with user "premiumindividualuser1" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Upload a file
    When Upload file "<invalid_logo_file>" at the element "tutorials.settings.customize_theme.logo_file"
    Then I should see the message "Upload failed. The image file is broken or corrupt"
    When Upload file "<invalid_background_file>" at the element "tutorials.settings.customize_theme.background_file"
    Then I should see the message "Upload failed. The image file is broken or corrupt"
    Examples:
    | tutorial 												|	invalid_logo_file																		|	invalid_background_file															|
    | Public Plan having custom theme	| \src\test\resources\testdata\invalid_file_type.jpg	| \src\test\resources\testdata\invalid_file_type.jpg	|

  @manual
  Scenario: Change the highlight color with color picker
    Given I am a free or premium user
    And I am the Theme tab
    When I click the Highlight field
    Then The color picker should be shown
    When I select any color from the color picker
    And I click Select
    Then The highlight color should be applied for the preview / editor and player
    And The highlight color should be applied for the live tutorial playback

  @manual
  Scenario: Change tool color by typing valid color into the box
    Given I am at the Theme tab
    And I am a premium user
    When I navigate to the Tool Color
    And I click a color box of a tool
    Then The color picker should be shown
    When I type a valid color, for example, "red"
    And I click Select
    Then The color should be applied on the color box
    And The tool color should be applied for the tutorial on the Preview, Player, Editor and Extension Panel
    And The tool color should be applied for new tutorials

  @manual
  Scenario: Change tool color by typing invalid color into the box
    Given I am at the Theme tab
    And I am a premium user
    When I navigate to the Tool Color
    And I click a color box of a tool
    Then The color picker should be shown
    When I type an invalid color, for example, "redred"
    And I move the mouse to another place
    Then I should see the error message "Invalid color: could be "green", "rgb(0, 255, 0)" or "#00FF00""
    And The tool color should not be changed

  @manual
  Scenario: Premium user customizes Layout for Private/Public/Unlisted tutorial
    Given I am a premium user
    And I am at the Theme tab of the Private or Public or Unlisted tutorial
    When I navigate to the Layout tab
    Then The "Player" should be selected in "Options for" by default
    And The "All selected" should be selected in "Visibility" by default
    And The header bar, and the PDF icon should be shown on the layout
    And The "Step by step" should be selected for "Default mode" by default
    When I click the Visibility field
    Then I should see 8 options: [Select all], Share, Live, PDF, Language, Logo, Info, Fullscreen
    When I uncheck "[Select all]"
    Then All checkboxes should be unchecked
    And The default selected functions should not be shown on the layout anymore
    When I click the "Default mode"
    Then I should see the drop-down list "Step by step" and "All steps"
    And I select one option from the dropdown
    Then The selected option should be applied on the preview mode
    When I click Close Theme
    And I Finish
    Then I should be redirected to the My tutorials page
    When I open the tutorial
    Then The customized player layout should be applied on the player

  @manual
  Scenario: Premium user customizes Layout for Embed Only tutorial
    Given I am a premium user
    And I am at the Theme tab of the Embed Only tutorial
    When I navigate to the Layout tab
    Then The "Embed" should be selected in "Options for" by default
    And The drop-down of "Options for" field should be frozen
    When I click the Visibility field
    Then I should see 7 options: [Select all], Live, PDF, Language, Logo, Info, Fullscreen
    When I check/uncheck any option
    Then The layout should be changed properly
    When I click the "Default mode"
    Then I should see the drop-down list "Step by step" and "All steps"
    And I select one option from the dropdown
    Then The selected option should be applied on the preview mode
    When I click Close Theme
    And I Finish
    Then I should be redirected to the My tutorials page
    When I open the tutorial
    Then The customized player layout should be applied on the player

  Scenario Outline: check "All selected" checked when all options are checked
    When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # At the Layout tab
    When I click "tutorials.settings.customize_theme.layout_tab"
    Then The "tutorials.settings.customize_theme.all_selected_control" should be visible
    # All options checked
    When I click "tutorials.settings.customize_theme.all_selected_control"
    And I check "tutorials.settings.customize_theme.all_selected_control.share"
    And I check "tutorials.settings.customize_theme.all_selected_control.live"
    And I check "tutorials.settings.customize_theme.all_selected_control.pdf"
    And I check "tutorials.settings.customize_theme.all_selected_control.language"
    And I check "tutorials.settings.customize_theme.all_selected_control.logo"
    And I check "tutorials.settings.customize_theme.all_selected_control.info"
    And I check "tutorials.settings.customize_theme.all_selected_control.fullscreen"
    Then The "tutorials.settings.customize_theme.all_selected_control.select_all" checkbox should be checked
    # One option unchecked
    When I uncheck "tutorials.settings.customize_theme.all_selected_control.share"
    Then The "tutorials.settings.customize_theme.all_selected_control.select_all" checkbox should be unchecked
    
    Examples:
    | tutorial 		 |	
    | Premium user | 	 

  Scenario Outline: Back to the Finish page
    When I logged in iroad with user "googlepremiumindividualuser" and password "validpassword"
    Then I should see the My tutorials page content
    # At the Custom Theme page
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then The element "tutorials.settings.customize_theme.logo_file" should be shown
    And The element "tutorials.settings.customize_theme.background_file" should be shown
    # Close theme
    When I click "tutorials.settings.customize_theme.close_theme_btn"
    And Switch back to parent frame
    Then I should be redirected to the Finish page of the tutorial
    
    Examples:
    | tutorial 		 |	
    | Premium user | 	 

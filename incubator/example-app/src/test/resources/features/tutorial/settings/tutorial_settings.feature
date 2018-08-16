@desktop @test7 
Feature: The Finish page of a tutorial 

	As a logged-in user,
    I want to access the Finish page of a tutorial
    so that I could do some settings on my tutorial, such as renaming the tutorial, customizing theme, making tutorial public or private, or doing some options...

@smoke 
Scenario: Access the Finish page 
	Given I am a logged in user 
	Then I should see the My tutorials page content 
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	And The element "tutorials.preview_desktop_mode_active" should be shown 
	
Scenario Outline: change tutorial title with valid length 
	Given I logged in iroad with user "validuser" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	# Set new name
	And The element "tutorials.preview_desktop_mode_active" should be shown 
	When I click "tutorials.tutorial_name_textbox" 
	And I fill value "<new_tutorial_name>" to "tutorials.tutorial_name_textbox" textbox 
	Then I should see the message "Saved" 
	When I click "tutorials.settings.link_tab" 
	And The attribute "value" of element "tutorials.settings.link_tab.tutorial_url_textbox" should contain "<partial_link>" 
	
	Examples: 
		| new_tutorial_name | partial_link   |
		| auto test name    | auto-test-name |
		
Scenario Outline: change tutorial title with invalid length 
	Given I logged in iroad with user "validuser" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	# Set new name
	And The element "tutorials.preview_desktop_mode_active" should be shown 
	When I click "tutorials.tutorial_name_textbox" 
	# I type a new name with more than 150 characters
	And I fill value "<too_long_tutorial_name>" to "tutorials.tutorial_name_textbox" textbox 
	Then I should see the message "Saved" 
	# The title should keep the 150 first characters
	And The attribute "value" of element "tutorials.tutorial_name_textbox" should be "<expected_name>" 
	
	Examples: 
		| too_long_tutorial_name                                                                                                                                           | expected_name                                                                                                                                          |
		| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
		
Scenario: Change the tutorial title with the empty length 
	Given I logged in iroad with user "validuser" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	# Set new name
	And The element "tutorials.preview_desktop_mode_active" should be shown 
	When I click "tutorials.tutorial_name_textbox" 
	And Store the value of element "tutorials.tutorial_name_textbox" in variable "previous_tutorial_name" 
	And I fill value "    " to "tutorials.tutorial_name_textbox" textbox 
	And Wait for 5 seconds 
	When Store the value of element "tutorials.tutorial_name_textbox" in variable "next_tutorial_name" 
	Then The variable "previous_tutorial_name" should be equal to variable "next_tutorial_name" 
	
Scenario Outline: Open the tutorial when the tutorial is saved 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I search for "<tutorial>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	# Open the tutorial
	Then The element "tutorials.settings.link_tab" should be shown 
	When I click "tutorials.settings.link_tab" 
	Then The element "tutorials.settings.link_tab.open_btn" should be shown 
	When I click "tutorials.settings.link_tab.open_btn" and switch to the second tab 
	Then The url should contain "dev.iorad.local/player/" 
	And The page title should be "<tutorial>" 
	
	Examples: 
		| tutorial                    |
		| Live 5 - Premium - Unlisted |
		| Live 6 - Premium - Public   |
		| Live 1 - Premium            |
		
# This test uses the iorad extension, so it can't be automated
@wip 
Scenario: Open the live tutorial when the tutorial is saved 
	Given I am at the Finish page of a Public / Unlisted / Private tutorial 
	And The tutorial is saved 
	And I am at the Live tab 
	When I click Open 
	Then The website where I captured the tutorial should be opened in a new tab 
	When I click iorad extension icon on the browser 
	Then I should be able to play back the tutorial on the website 
	
# Should be tested manually because the saving time is very short.
@fail @wip 
Scenario Outline: Open the tutorial when the tutorial is in the saving status 
	Given I logged in iroad with user "googlefreeverifieduseruser" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I search for "<tutorial>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	When I click "tutorials.tutorial_name_textbox" 
	And Store the value of element "tutorials.tutorial_name_textbox" in variable "saved_tutorial_name" 
	And I fill value "aaa" to "tutorials.tutorial_name_textbox" textbox 
	Then I should see the message "Saved" 
	When I fill variable "saved_tutorial_name" to "tutorials.tutorial_name_textbox" textbox 
	#Then I should see the message "Saving"
	When I click "tutorials.settings.link_tab.open_btn" 
	Then I should see the message "Still saving. Will be available shortly" 
	
	Examples: 
		| tutorial             |
		| Live 2 for free user |
		
	#Given I am at the Finish page of a public / unlisted / private tutorial
	#And The tutorial is saving and optimized
	#And I am at the Link tab / Live tab
	#When I click Open
	#Then I should see the notification "Still saving. Will be available shortly"
		
# The button tutorials.settings.link_tab.tutorial_url_copy_btn not work
Scenario Outline: copy the link 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I search for "<tutorial>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	# Copy the link
	Then The element "tutorials.settings.link_tab" should be shown 
	When I click "tutorials.settings.link_tab" 
	Then The element "tutorials.settings.link_tab.tutorial_url_textbox" should be shown 
	When I click "tutorials.settings.link_tab.tutorial_url_copy_btn" 
	Then I should see the message "Direct link copied to clipboard." 
	When Store the value of element "tutorials.settings.link_tab.tutorial_url_textbox" in variable "tutorial_link" 
	Then The copied text of clipboard should be equal to variable "tutorial_link" 
	
	Examples: 
		| tutorial                    |
		| Live 5 - Premium - Unlisted |
		| Live 6 - Premium - Public   |
		| Live 4  - Premium - Private |
	
# The button tutorials.settings.link_tab.tutorial_short_url_copy_btn not work
Scenario Outline: copy the short link 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I search for "<tutorial>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	# Copy the short link
	#When switch to "tutorials.iorad_app_iframe" frame
	Then The element "tutorials.settings.link_tab" should be shown 
	When I click "tutorials.settings.link_tab" 
	Then The element "tutorials.settings.link_tab.tutorial_short_url_textbox" should be shown 
	When I click "tutorials.settings.link_tab.tutorial_short_url_copy_btn" 
	Then I should see the message "Short link copied to clipboard." 
	When Store the value of element "tutorials.settings.link_tab.tutorial_short_url_textbox" in variable "tutorial_short_link" 
	Then The copied text of clipboard should be equal to variable "tutorial_short_link" 
	
	Examples: 
		| tutorial                    |
		| Live 5 - Premium - Unlisted |
		| Live 6 - Premium - Public   |
		| Live 4  - Premium - Private |
						
# The button tutorials.settings.embed_tab.embed_url_copy_btn not work
Scenario Outline: copy embedded link 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I search for "<tutorial>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	# Copy the short link
	#When switch to "tutorials.iorad_app_iframe" frame
	Then The element "tutorials.settings.embed_tab" should be shown 
	When I click "tutorials.settings.embed_tab" 
	Then The element "tutorials.settings.embed_tab.embed_url_textbox" should be shown 
	When I click "tutorials.settings.embed_tab.embed_url_copy_btn" 
	Then I should see the message "Embed code copied to clipboard." 
	#When Store the value of element "tutorials.settings.embed_tab.embed_url_textbox" in variable "embed_link"
	#Then The copied text of clipboard should be equal to variable "embed_link"
	
	Examples: 
		| tutorial                    |
		| Live 5 - Premium - Unlisted |
		| Live 6 - Premium - Public   |
		| Live 4  - Premium - Private |
								
Scenario Outline: Premium users set the tutorial privacy 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When I should see the My tutorials page content 
	And I search for "<tutorial>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	# Set to Public
	When I click "tutorials.settings.access_permission.selectize_control" 
	And I select "Public" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then I should see the message "Saved" 
	And I click "tutorials.finish_button" 
	And switch back to parent frame 
	Then I should see the My tutorials page content 
	# freeverifieduser not see the public tutorial
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "freeverifieduser" and password "validpassword" 
	And I click on the "left_menu.tutorials" button from the slide out menu 
	Then I should see the My tutorials page content 
	When I click "tutorials.shared_tab" 
	And I search for "<tutorial>" tutorial 
	Then I should see the message "No Results Found" 
	# Login with a team member to see the shared tutorial
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "teammemberuser" and password "validpassword" 
	And I click on the "left_menu.tutorials" button from the slide out menu 
	Then I should see the My tutorials page content 
	When I click "tutorials.shared_tab" 
	And I search for "<tutorial>" tutorial 
	Then The text of element "tutorials.name_tutorial_label" should be "<tutorial>" 
	Examples: 
	| tutorial                    		|
	| tutorial created by the owner 2 |
									
Scenario Outline: Free users set the tutorial privacy into Private / Unlisted / Embed Only when the 2 premium tutorial limit reaches 
	Given I logged in iroad with user "googlefreeverifieduseruser" and password "validpassword" 
	# Access the Finish page
	When     I should see the My tutorials page content 
	And     I search for "<tutorial>" tutorial 
	And     I click "tutorials.three_dot_icon" 
	And     I click "tutorials.setting" 
	Then     I should be redirected to the Finish page of the tutorial 
	# Embed Only
	When     I click "tutorials.settings.access_permission.selectize_control" 
	And     I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then     I should see the message "Upgrade your plan to continue using this" 
	And     The element "tutorials.settings.noty.upgrade_btn" should be shown 
	When     I click "tutorials.settings.noty.close_btn" 
	Then     The element "tutorials.settings.noty.close_btn" should not be shown 
	Then     I should not see the message "Upgrade your plan to continue using this" 
	# Unlisted
	When     I click "tutorials.settings.access_permission.selectize_control" 
	And     I select "Unlisted" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then     I should see the message "Upgrade your plan to continue using this" 
	And     The element "tutorials.settings.noty.upgrade_btn" should be shown 
	When     I click "tutorials.settings.noty.close_btn" 
	Then     The element "tutorials.settings.noty.close_btn" should not be shown 
	Then     I should not see the message "Upgrade your plan to continue using this" 
	# Private
	When     I click  "tutorials.settings.access_permission.selectize_control" 
	And     I select "Private" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then     I should see the message "Upgrade your plan to continue using this" 
	And     The element "tutorials.settings.noty.upgrade_btn" should be shown 
	When     I click "tutorials.settings.noty.upgrade_btn" 
	Then     I should be redirected to the "/upgradeplan" page 
	
	Examples: 
		| tutorial             |
		| Live 5 for free user |
									
Scenario Outline: premium user selects Embed Only with valid domains 
	Given    I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set Embed Only
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be visible 
	When    I fill value "<domain>" to "tutorials.settings.embed_tab.allow_domain_textbox" textbox 
	And    I click "tutorials.finish_button" 
	And    switch back to parent frame 
	Then    I should see the My tutorials page content 
	When    I search for "<tutorial>" tutorial 
	Then    The text of element "tutorials.tutorial_privacy" should be "Embed Only" 
	# Set back to private for the next running time
	When    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Private" from the selection list "tutorials.settings.access_permission.selectize_options" 
	And    I click "tutorials.finish_button" 
	And    switch back to parent frame 
	Then    I should see the My tutorials page content 
	When    I search for "<tutorial>" tutorial 
	Then    The text of element "tutorials.tutorial_privacy" should be "Private" 
	
	Examples: 
		| tutorial     				| domain    |
		| Embed Only tutorial | iorad.com |
									
Scenario Outline: premium user selects Embed Only without domain 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set Embed Only
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be visible 
	And    I click "tutorials.finish_button" 
	Then    I should see the message "Embed only requires a valid domain to be specified. Please enter a valid domain before navigating away from this page." 
	#And The domain field should be highlighted - not automated
	# Back to the Tutorials page
	When    switch back to parent frame 
	And    I click on the "left_menu.tutorials" on the left panel 
	Then    I should see the My tutorials page content 
	When    I search for "<tutorial>" tutorial 
	Then    The text of element "tutorials.tutorial_privacy" should be "Private" 
	
	Examples: 
		| tutorial                    |
		| Live 5 - Premium - Unlisted |
		| Live 6 - Premium - Public   |

Scenario Outline: premium user selects Embed Only with invalid domains 
	Given    I logged in iroad with user "premiumindividualuser2" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set Embed Only with invalid domain
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be visible 
	And    I click "tutorials.finish_button" 
	Then    I should see the message "Embed only requires a valid domain to be specified. Please enter a valid domain before navigating away from this page." 
	When    I fill value "<invalid_domain>" to "tutorials.settings.embed_tab.allow_domain_textbox" textbox 
	And    I press Enter 
	Then    I should see the message "A valid domain is required." 
	When    I click "tutorials.finish_button" 
	Then    I should see the message "Embed only requires a valid domain to be specified. Please enter a valid domain before navigating away from this page." 
	And    The "tutorials.finish_button" should be visible 
	
	Examples: 
		| tutorial  | invalid_domain |
		| Premium 4 | iorad          |
		
Scenario Outline: Check the input domain is restored when setting back Embed Only 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set to Embed Only
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	# Store the domain to verify later
	When    I click "tutorials.settings.embed_tab" 
	Then    The element "tutorials.settings.embed_tab.allow_domain_textbox" should be shown 
	And    Store the value of element "tutorials.settings.embed_tab.allow_domain_textbox" in variable "saved_domain" 
	# Set Private
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Private" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be invisible 
	# Set Public
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Public" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be invisible 
	# Set Unlisted
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Unlisted" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be invisible 
	# Set back to Embed Only
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be visible 
	When    Store the value of element "tutorials.settings.embed_tab.allow_domain_textbox" in variable "current_domain" 
	Then    The variable "saved_domain" should be equal to variable "current_domain" 
	
	Examples: 
		| tutorial                         |
		| Live 3 - Premium - Embed OnlOnly |
		
Scenario Outline: anonymous user plays the Embed Only tutorial on any 
	browsers 
	### Using team owner to copy the direct link
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Go to Share tutorial popup
	When    I click on the "left_menu.tutorials" button from the slide out menu 
	And    I click "tutorials.my_tutorial_tab" 
	Then    I should be redirected to My tutorials tab 
	When    I search for "<tutorial>" tutorial 
	Then    The element "tutorials.name_tutorial_label" should be shown 
	# Copy the direct link
	When    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.share_button" 
	And    I click "tutorials.tab_share_tutorial_tab_link" 
	And    Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "direct_link" 
	### Using an anonymous user to access the url
	When    I click on the "left_menu.logout" button from the slide out menu 
	Then    I should be logged out and redirected to the home page 
	When    I navigate to the url stored in variable "direct_link" 
	Then    I should see the Log in tab content 
	
	Examples: 
		| tutorial                         |
		| Live 3 - Premium - Embed OnlOnly |
		
Scenario Outline: play the Embed Only tutorial on the input domains 
### Using team owner to copy the direct link
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Go to Share tutorial popup
	When    I click on the "left_menu.tutorials" button from the slide out menu 
	And    I click "tutorials.my_tutorial_tab" 
	Then    I should be redirected to My tutorials tab 
	When    I search for "<tutorial>" tutorial 
	Then    The element "tutorials.name_tutorial_label" should be shown 
	# Copy the direct link
	When    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.share_button" 
	And    I click "tutorials.tab_share_tutorial_tab_link" 
	And    Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "direct_link" 
	# Access the Finish page
	When    I click "tutorials.tab_share_tutorial_tab_close" 
	Then    I should see the My tutorials page content 
	When    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set to Embed Only
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be visible 
	When    I fill value "<embed_domain>" to "tutorials.settings.embed_tab.allow_domain_textbox" textbox 
	And    I click "tutorials.finish_button" 
	And    Switch back to main frame 
	Then    I should see the My tutorials page content 
	# I copy and paste the Embed Only tutorial URL into the domain in logged case
	When    I open a new tab 
	And    I switch to the second tab 
	And    I navigate to url "<embed_domain_url>" 
	When    I fill variable "direct_link" to "tutorials.settings.phuonglm.net.url_textbox" textbox 
	And    I click "tutorials.settings.phuonglm.net.view_url_btn" 
	And    Switch to "tutorials.settings.phuonglm.net.embed_iframe" frame 
	Then    I should see the message "<tutorial>" 
	# I copy and paste the Embed Only tutorial URL into the domain in anonymous case
	When    I switch to the first tab 
	And    I click on the "left_menu.logout" button from the slide out menu 
	Then    I should be logged out and redirected to the home page 
	When    I switch to the second tab 
	And    I navigate to url "<embed_domain_url>" 
	When    I fill variable "direct_link" to "tutorials.settings.phuonglm.net.url_textbox" textbox 
	And    I click "tutorials.settings.phuonglm.net.view_url_btn" 
	And    Switch to "tutorials.settings.phuonglm.net.embed_iframe" frame 
	Then    I should see the message "<tutorial>" 
	
	Examples: 
		| tutorial                         |	embed_domain	|	embed_domain_url										|
		| Live 3 - Premium - Embed OnlOnly |	phuonglm.net	|	http://phuonglm.net/cciIFrame.php?	|
		
# The embed frame is navigated to the log in page, not the Denied page
Scenario Outline: play the Embed Only tutorial on incorrect domains 
### Using team owner to copy the direct link
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Go to Share tutorial popup
	When    I click on the "left_menu.tutorials" button from the slide out menu 
	And    I click "tutorials.my_tutorial_tab" 
	Then    I should be redirected to My tutorials tab 
	When    I search for "<tutorial>" tutorial 
	Then    The element "tutorials.name_tutorial_label" should be shown 
	# Copy the direct link
	When    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.share_button" 
	And    I click "tutorials.tab_share_tutorial_tab_link" 
	And    Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "direct_link" 
	# Access the Finish page
	When    I click "tutorials.tab_share_tutorial_tab_close" 
	Then    I should see the My tutorials page content 
	When    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set to Embed Only
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be  visible 
	When    I fill value "<embed_domain>" to  "tutorials.settings.embed_tab.allow_domain_textbox" textbox 
	And    I click "tutorials.finish_button" 
	And    Switch back to main frame 
	Then    I should see the My tutorials page content 
	# Log out and check embed link
	When    I click on the "left_menu.logout" button from the slide out menu 
	Then    I should be logged out and redirected to the home page 
	When    I open a new tab 
	And    I switch to the second tab 
	And    I navigate to url "<embed_domain_url>" 
	When    I fill variable "direct_link" to  "tutorials.settings.phuonglm.net.url_textbox" textbox 
	And    I click "tutorials.settings.phuonglm.net.view_url_btn" 
	And    Switch to "tutorials.settings.phuonglm.net.embed_iframe" frame 
	Then    I should see the message "Oops" 
	And    I should see the message "Something went wrong" 
	And    I should see the message "Access denied" 
	
	Examples: 
		| tutorial                         |	embed_domain	|	embed_domain_url										|
		| Live 3 - Premium - Embed OnlOnly |	24h.com.vn		|	http://phuonglm.net/cciIFrame.php?	|
		
Scenario Outline: convert Embed Only tutorial into  Private/Unlisted/Public 
	Given    I logged in iroad with user "teamowneruser1" and password  "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set to Embed Only
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list  "tutorials.settings.access_permission.selectize_options" 
	Then    The "tutorials.settings.embed_tab" should be visible 
	# Set Private
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Private" from the selection list  "tutorials.settings.access_permission.selectize_options" 
	Then    The text of element  "tutorials.settings.access_permission.selectize_control" should be  "Private" 
	# Set Public
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Public" from the selection list  "tutorials.settings.access_permission.selectize_options" 
	Then    The text of element "tutorials.settings.access_permission.selectize_control" should be  "Public" 
	# Set Unlisted
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Unlisted" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The text of element "tutorials.settings.access_permission.selectize_control" should be "Unlisted" 
	# Set back to Embed Only
	When    I click "tutorials.settings.access_permission.selectize_control" 
	And    I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options" 
	Then    The text of element "tutorials.settings.access_permission.selectize_control" should be "Embed Only" 
	And    The "tutorials.settings.embed_tab" should be visible 
	And    The "tutorials.settings.embed_tab.allow_domain_textbox" should be visible 
	When I fill value "<embed_domain>" to "tutorials.settings.embed_tab.allow_domain_textbox" textbox 
	And    I press Enter 
	Then    I should see the message "Saved" 
	When    I click "tutorials.finish_button" 
	And    Switch back to main frame 
	Then    I should see the My tutorials page content 
	
	Examples: 
		| tutorial                         | embed_domain |
		| Live 3 - Premium - Embed OnlOnly | google.com   |
			
Scenario Outline: invite user to Embed Only tutorial 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Access the Share popup
	When    I click "tutorials.settings.share_button" 
	Then    I should be redirected to the Share & Access tab 
	And    I should see the message "Embed only tutorials cannot be shared" 
	And    The "tutorials.tab_share_tutorial_tab_invite" should be invisible 
	
	#And I should not see the Invite People placeholdder
	#And I should be able to share tutorial with users having the same specific email domain (.iorad) as me -> don't see this feature
	Examples: 
		| tutorial                         |
		| Live 3 - Premium - Embed OnlOnly |
				
Scenario: check Back button 
	Given    I logged in iroad with user "validuser" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set new name
	#When switch to "tutorials.iorad_app_iframe" frame
	And    The element "tutorials.preview_desktop_mode_active" should be shown 
	When    I click "tutorials.back_button" 
	And    Switch back to main frame 
	Then    I should see the My tutorials page content 

Scenario: check Finish button 
	Given    I logged in iroad with user "validuser" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Set new name
	#When switch to "tutorials.iorad_app_iframe" frame
	And    The element "tutorials.preview_desktop_mode_active" should be shown 
	When    I click "tutorials.finish_button" 
	And    Switch back to main frame 
	Then    I should see the My tutorials page content 

Scenario Outline: Add description/ label and category 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Add description/label
	When    I click "tutorials.add_category_btn" 
	And    I remove category from the tutorial settings page 
	And    I remove tags from the tutorial settings page 
	# I'm at the Description and Label pop-up
	Then    I should see the message "Category and Tags" 
	And    The element "tutorials.settings.category_tag_popup.category_textbox" should be shown 
	And    The element "tutorials.settings.category_tag_popup.tag_textbox" should be shown 
	And    The element "tutorials.settings.category_tag_popup.description_textbox" should be shown 
	# Able to fill only one Category
	When    I fill value "<category>" to "tutorials.settings.category_tag_popup.category_textbox" textbox 
	And    I press Enter 
	Then    The text of element "tutorials.settings.category_tag_popup.inputted_category" should contain "<category>" 
	And    The element "tutorials.settings.category_tag_popup.category_textbox" should not be shown 
	# Able to fill only 5 labels
	When    I fill value "<tags>" to "tutorials.settings.category_tag_popup.tag_textbox" textbox 
	Then    I should see the message "You can only add 5 tags to a tutorial. Sorry." 
	And    The "tutorials.settings.category_tag_popup.tag_textbox" should be invisible 
	# Set the description
	When    I fill value "<description>" to "tutorials.settings.category_tag_popup.description_textbox" textbox 
	Then    The attribute "value" of element "tutorials.settings.category_tag_popup.description_textbox" should be "<description>" 
	# Save
	When    I click "tutorials.settings.category_tag_popup.save_button" 
	Then    I should see the message "Tutorial properties updated." 
	# Finish
	When    I click "tutorials.finish_button" 
	And    switch back to parent frame 
	Then    I should see the My tutorials page content 
	
	#And I should see the labels added to the tutorial
	#And The Labels list should be shown on the left
	#And I should see the category listed in the Category list on the left
	#When I hover my mouse on the tutorial title on Player cover
	#Then The description and title should be shown
	Examples: 
		| tutorial                      | category      	| tags                      | description      |
		| tutorial created by the owner | auto category 1 | tag1;tag2;tag3;tag4;tag5; | auto description |
					
Scenario Outline: Check the existing category auto-suggestion 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# At description/label pop-up
	When    I click "tutorials.add_category_btn" 
	And    I remove category from the tutorial settings page 
	# Check the category suggestion
	When    I click "tutorials.settings.category_tag_popup.category_textbox" 
	And    I fill value "<category>" to "tutorials.settings.category_tag_popup.category_textbox" textbox 
	Then    The "tutorials.settings.category_tag_popup.category_suggestion" should be visible 
	And    The text of element "tutorials.settings.category_tag_popup.category_suggestion" should contain "<category>" 
	When    I click "tutorials.settings.category_tag_popup.category_suggestion" 
	Then    The text of element "tutorials.settings.category_tag_popup.inputted_category" should contain "<category>" 
	When    I click "tutorials.settings.category_tag_popup.save_button" 
	Then    I should see the message "Tutorial properties updated." 
	
	Examples: 
		| tutorial                      | category |
		| tutorial created by the owner | Premium  |
						
Scenario Outline: Check the Category on the extension panel 
	Given    I logged in iroad with user "freeverifieduser" and password "validpassword" 
	#### Set a category
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Add category
	When    I click "tutorials.add_category_btn" 
	And    I remove category from the tutorial settings page 
	When    I click "tutorials.settings.category_tag_popup.category_textbox" 
	And    I fill value "<category>" to "tutorials.settings.category_tag_popup.category_textbox" textbox 
	And    I press Enter 
	When    I click "tutorials.settings.category_tag_popup.save_button" 
	Then    I should see the message "Tutorial properties updated." 
	When    I click "tutorials.finish_button" 
	And    switch back to parent frame 
	Then    I should see the My tutorials page content 
	And    The text of element "tutorials.left_side.category_list" should contain "<category>" 
	When    I click on "tutorials.left_side.category" of "<category>" 
	Then    The text of element "tutorials.name_tutorial_label" should be "<tutorial>" 
	
	Examples: 
		| tutorial   | category 				|
		| tutorial 3 | auto category 4  |
	
Scenario Outline: Remove category of a tutorial 
	Given    I logged in iroad with user "freeverifieduser" and password "validpassword" 
	#### Set a category
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Add category
	When    I click "tutorials.add_category_btn" 
	And    I remove category from the tutorial settings page 
	When    I click "tutorials.settings.category_tag_popup.category_textbox" 
	And    I fill value "<category>" to "tutorials.settings.category_tag_popup.category_textbox" textbox 
	And    I press Enter 
	When    I click "tutorials.settings.category_tag_popup.save_button" 
	Then    I should see the message "Tutorial properties updated." 
	When    I click "tutorials.finish_button" 
	And    switch back to parent frame 
	Then    I should see the My tutorials page content 
	And    The text of element "tutorials.left_side.category_list" should contain "<category>" 
	#### Remove category
	When    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# At category
	When    I click "tutorials.add_category_btn" 
	And    I remove category from the tutorial settings page 
	Then    The "tutorials.settings.category_tag_popup.category_textbox" should be visible 
	When    I click "tutorials.settings.category_tag_popup.save_button" 
	Then    I should see the message "Tutorial properties updated." 
	When    I click "tutorials.finish_button" 
	And    switch back to parent frame 
	Then    I should see the My tutorials page content 
	And    The text of element "tutorials.left_side.category_list" should not contain "<category>" 
	
	Examples: 
		| tutorial                      | category 				|
		| Live tutorial for free user 1 | auto category 2 |
		
Scenario Outline: Edit the description and label 
	Given    I logged in iroad with user "freeverifieduser" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Remove category/label
	When    I click "tutorials.add_category_btn" 
	And    I remove category from the tutorial settings page 
	And    I remove tags from the tutorial settings page 
	# Add description/label
	When    I fill value "<tags>" to "tutorials.settings.category_tag_popup.tag_textbox" textbox 
	And    I press Enter 
	And    I fill value "<description>" to "tutorials.settings.category_tag_popup.description_textbox" textbox 
	And    I click "tutorials.settings.category_tag_popup.save_button" 
	Then    I should see the message "Tutorial properties updated." 
	# Finish
	When    I click "tutorials.finish_button" 
	And    switch back to parent frame 
	Then    I should see the My tutorials page content 
	And    The text of element "tutorials.left_side.tags_list" should contain "<tags>" 
	#When I hover my mouse on the tutorial on Player
	#Then I should see the new description
	
	Examples: 
		| tutorial             | category      		| tags        | description      |
		| Live 2 for free user | auto category 3	| auto tag 3  | auto description |
			
			
Scenario Outline: Add the description with more than 600 characters 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# At description/label popup
	When    I click "tutorials.add_category_btn" 
	Then    The element "tutorials.settings.category_tag_popup.description_textbox" should be shown 
	# Set a long description
	When    I fill value "<description>" to "tutorials.settings.category_tag_popup.description_textbox" textbox 
	And    I click "tutorials.settings.category_tag_popup.save_button" 
	Then    I should see the message "The description is too long" 
	And    The attribute "class" of element "tutorials.settings.category_tag_popup.description_char_number" should contain "goneover" 
	
	Examples: 
		| tutorial                     | description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
		| tutorial created by member 2 | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	
Scenario Outline: Check the existing tag auto-suggestion 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# At description/label pop-up
	When    I click "tutorials.add_category_btn" 
	And    I remove tags from the tutorial settings page 
	# Check the category suggestion
	When    I click "tutorials.settings.category_tag_popup.tag_textbox" 
	Then    The "tutorials.settings.category_tag_popup.tag_suggestion" should be visible 
	When    Store the text of element "tutorials.settings.category_tag_popup.tag_suggestion" in variable "var_tag_suggestion" 
	And    I click "tutorials.settings.category_tag_popup.tag_suggestion" 
	Then    The text of element "tutorials.settings.category_tag_popup.inputted_tags" should contain variable "var_tag_suggestion" 
	When    I click "tutorials.settings.category_tag_popup.save_button" 
	Then    I should see the message "Tutorial properties updated." 
	
	Examples: 
		| tutorial                        |
		| tutorial created by the owner 2 |
		
Scenario Outline: Cancel updating the description and label pop up 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# At description/label popup
	When    I click "tutorials.add_category_btn" 
	And    I remove tags from the tutorial settings page 
	And    I should see the message "Category and Tags" 
	# Cancel
	When    I fill value "<tags>" to "tutorials.settings.category_tag_popup.tag_textbox" textbox 
	And    I fill value "<description>" to "tutorials.settings.category_tag_popup.description_textbox" textbox 
	And    I click "tutorials.settings.category_tag_popup.cancel_button" 
	Then    I should not see the message "Tutorial properties updated." 
	And    I should see the message "Category and Tags" 
	
	Examples: 
		| tutorial                        | tags  | description      |
		| tutorial created by the owner 3 | tag1; | auto description |
	
Scenario Outline: check the Live tab not shown for tutorials captured by iorad app 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# I should not see the Live tab
	And    The "tutorials.settings.live_tab" should be invisible 
	
	Examples: 
		| tutorial                        |
		| tutorial created by the owner 3 |
				
Scenario Outline: check the Live tab shown for tutorials captured by iorad chrome extension 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Live tab
	And    The "tutorials.settings.live_tab" should be visible 
	When    I click "tutorials.settings.live_tab" 
	And    I select by value "domain" from the dropdown list "tutorials.settings.live_tab.domain_dropdown" 
	Then    The "tutorials.settings.live_tab.live_mode_chk" checkbox should be checked 
	And    The "tutorials.settings.live_tab.domain_dropdown" should be visible 
	And    The "tutorials.settings.live_tab.domain_textbox" should be visible 
	# And The "Shared with" counting should be shown -> not see
	And    The "tutorials.settings.live_tab.copy_domain_btn" should be visible 
	And    The "tutorials.settings.live_tab.open_btn" should be visible 
	# Change domain options
	When    I select by value "subdomain" from the dropdown list "tutorials.settings.live_tab.domain_dropdown" 
	Then    The attribute "value" of element "tutorials.settings.live_tab.subdomain_textbox" should be "<subdomain>" 
	When    I select by value "all-subdomains" from the dropdown list "tutorials.settings.live_tab.domain_dropdown" 
	Then    The attribute "value" of element "tutorials.settings.live_tab.all_subdomains_textbox" should be "<all_subdomains>" 
	When    I select by value "domain" from the dropdown list "tutorials.settings.live_tab.domain_dropdown" 
	Then    The attribute "value" of element "tutorials.settings.live_tab.domain_textbox" should be "<domain>" 
	
	Examples: 
		| tutorial         | domain     | subdomain  | all_subdomains |
		| Live 2 - Premium | inlims.com | inlims.com | ***.inlims.com |
					
Scenario: Free / Private / Premium account check the Live Mode when the live tutorial limit reaches 
	Given      I am logged-in as a free / private / premium account 
	And      I already have 5 live tutorials 
	When      I create a tutorial with iorad extension 
	And      I navigate to the Settings page 
	And      I check the Live Mode checkbox 
	Then      I should see the notification "You are over your live tutorial limit. Upgrade" 
	And      The Upgrade link refers to the "/upgradeplan" page 

Scenario Outline: Open a live tutorial 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Live tab
	And    The "tutorials.settings.live_tab" should be visible 
	When    I click "tutorials.settings.live_tab" 
	And    I check "tutorials.settings.live_tab.live_mode_chk" 
	And    I select by value "domain" from the dropdown list "tutorials.settings.live_tab.domain_dropdown" 
	And    I click "tutorials.settings.live_tab.open_btn" and switch to the second tab 
	Then    The url should contain "<live_url>" 

	# When running automation, the url is "http://dev.iorad.local/player/420/Live-1---Premium?isViewLive=true#trysteps-1"
	# But when execute manually, the url is "http://inlims.com/?ioradLiveId=420"
	Examples: 
		| tutorial         | live_url                                                             |
		| Live 1 - Premium | dev.iorad.local/player/420/Live-1---Premium?isViewLive=true#live |
	
# The copied text doesn't equal the domain
@fail 
Scenario Outline: Copy the link of a live tutorial 
	Given    I logged in iroad with user "teamowneruser1" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Live tab
	And    The "tutorials.settings.live_tab" should be visible 
	When    I click "tutorials.settings.live_tab" 
	And    I select by value "domain" from the dropdown list "tutorials.settings.live_tab.domain_dropdown" 
	And    I click "tutorials.settings.live_tab.copy_domain_btn" 
	Then    I should see the message "Live link copied to clipboard." 
	#When Store the value of element "tutorials.settings.live_tab.domain_textbox" in variable "current_domain"
	#Then The copied text of clipboard should be equal to variable "current_domain"
	
	Examples: 
		| tutorial         |
		| Live 1 - Premium |
		
# Issue: https://github.com/iorad/iorad/issues/6077
@fail 
Scenario Outline: Input valid URL where to play tutorial from chrome extension 
	Given    I logged in iroad with user "premiumindividualuser2" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Live tab
	And    The "tutorials.settings.live_tab" should be visible 
	When    I click "tutorials.settings.live_tab" 
	And    I check "tutorials.settings.live_tab.live_mode_chk" 
	And    I select by value "domain" from the dropdown list "tutorials.settings.live_tab.domain_dropdown" 
	And    I select by value "URL_IS" from the dropdown list "tutorials.settings.live_tab.url_filter_dropdown" 
	And    I fill value "<valid_url>" to "tutorials.settings.live_tab.url_textbox" textbox 
	And    I press Enter 
	Then    The attribute "value" of element "tutorials.settings.live_tab.domain_textbox" should be "<valid_domain>" 
	Examples: 
		| tutorial 	|	valid_url	  |	valid_domain	|
		| premium 2 |	github.com	| github.com		|
	
								
# Issue: https://github.com/iorad/iorad/issues/6077
@fail 
Scenario Outline: Input invalid URL where to play tutorial from chrome extension 
	Given    I logged in iroad with user "teamowneruser1" and password  "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Live tab
	And    The "tutorials.settings.live_tab" should be visible 
	When    I click "tutorials.settings.live_tab" 
	And    I check "tutorials.settings.live_tab.live_mode_chk" 
	And    I select by value "domain" from the dropdown list "tutorials.settings.live_tab.domain_dropdown" 
	And    I select by value "URL_IS" from the dropdown list "tutorials.settings.live_tab.url_filter_dropdown" 
	And    I fill value "<invalid_url>" to "tutorials.settings.live_tab.url_textbox" textbox 
	And    I press Enter 
	Then    I should see the message "Invalid url" 
	Examples: 
		| tutorial   								|	invalid_url	|
		| Live 6 - Premium - Public |	gmailcom	|
		
	#Given I am at the Finish page of a tutorial captured by iorad chrome extension
	#And The Live mode checkbox should be checked
	#When I click the domain option field below the Live mode checkbox
	#And I select the option "Available on this URL"
	#And I edit the domain into the invalid URL
	#And I press Enter
	#Then I should see the error message
									
Scenario Outline: check the Live tutorial on the extension panel 
	Given    I logged in iroad with user "premiumindividualuser2" and  password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Live tab
	And    The "tutorials.settings.live_tab" should be visible 
	When    I click "tutorials.settings.live_tab" 
	And    I check "tutorials.settings.live_tab.live_mode_chk" 
	# Play tutorial
	When    I click "tutorials.settings.view_desktop_mode_btn" 
	And    Switch to "tutorials.settings.preview_tutorial_frame" frame 
	And    I click "tutorials.settings.view_desktop_mode.collapse_btn" 
	#And I click "tutorials.settings.view_desktop_mode.step_by_step_tab"
	And    I play tutorial in the desktop mode from Tutorial Settings page 
	
	Examples: 
		| tutorial  |
		| premium 2 |
										
Scenario Outline: Uncheck the Live check 
	Given    I logged in iroad with user "premiumindividualuser2" and  password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Live tab
	And    The "tutorials.settings.live_tab" should be visible 
	When    I click "tutorials.settings.live_tab" 
	And    I uncheck "tutorials.settings.live_tab.live_mode_chk" 
	Then    The "tutorials.settings.live_tab.domain_dropdown" should be invisible 
	And    The "tutorials.settings.live_tab.domain_textbox" should be invisible 
	And    The "tutorials.settings.live_tab.custom_url_dropdown" should be invisible 
	And    The "tutorials.settings.live_tab.copy_domain_btn" should be invisible 
	And    The "tutorials.settings.live_tab.open_btn" should be invisible 
	When    Switch to "tutorials.settings.preview_tutorial_frame" frame 
	Then    The "tutorials.settings.go_live_link" should be invisible 
	
	Examples: 
		| tutorial  |
		| premium 2 |
											
# This test uses the iorad extension, so it can't be automated
@wip 
Scenario: check if free user can create more than 5 live tutorials 
	Given    I am a free user 
	And    I created 5 Live tutorials 
	When    I capture a tutorial with the extension 
	Then    The "Live mode" checkbox should be disabled by default 
	And    The tutorial should not be found on the extension panel 

Scenario: check if free user can duplicate more 5 live tutorials 
	Given    I am a free user 
	And    I created 5 Live tutorials 
	When    I duplicate a live tutorial 
	Then    The "Live mode" of the tutorial should be disabled by default 
	And    The tutorial should not be found on the extension panel 

Scenario Outline: Preview tutorial in the desktop mode 
	Given    I logged in iroad with user "premiumindividualuser2" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Play tutorial
	When    I click "tutorials.settings.view_desktop_mode_btn" 
	And    Switch to "tutorials.settings.preview_tutorial_frame" frame 
	And    I click "tutorials.settings.view_desktop_mode.collapse_btn" 
	#And I click "tutorials.settings.view_desktop_mode.step_by_step_tab"
	And    I play tutorial in the desktop mode from Tutorial Settings page 
	
	Examples: 
		| tutorial  |
		| premium 2 |
		
Scenario Outline: Preview tutorial in the Mobile Portrait mode 
	Given    I logged in iroad with user "premiumindividualuser2" and password "validpassword" 
	# Access the Finish page
	When    I should see the My tutorials page content 
	And    I search for "<tutorial>" tutorial 
	And    I click "tutorials.three_dot_icon" 
	And    I click "tutorials.setting" 
	Then    I should be redirected to the Finish page of the tutorial 
	# Play tutorial
	When    I click "tutorials.settings.view_mobile_mode_btn" 
	And    Switch to "tutorials.settings.preview_tutorial_frame" frame 
	And    I click "tutorials.settings.view_mobile_mode.collapse_btn" 
	Then    I should see the message "The first step" 
	When    I play tutorial in the mobile mode from Tutorial Settings page 
	Then    The "tutorials.settings.view_mobile_mode.replay_btn" should be visible 
	When    I click "tutorials.settings.view_mobile_mode.replay_btn" 
	Then    I should see the message "The first step" 
	
	Examples: 
		| tutorial  |
		| premium 2 |
		
Scenario: Preview tutorial in the Mobile Landscape mode 
	Given     I am at the Finish page of a tutorial 
	Then     The desktop preview mode should be shown by default 
	When     I click Mobile landscape icon 
	Then     The mobile preview mode should be displayed 
	When     I click the Start button 
	Then     The first step should be shown 
	And     I should be able to use the Back / Next icon 
	When     I have previewed to the final step 
	Then     I should be able to Replay the tutorial 

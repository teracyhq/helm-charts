@test6 
Feature: tutorial player 

	As a user,
    I want to play a tutorial
    so that I could follow it.

@smoke @big_screen
Scenario: play a tutorial having no hyperlink in the last step 
	Given I am a logged in user 
	And I am at "/tutorials" 
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.play" 
	Then I should be redirected to the player page of the tutorial 
	When I click "tutorials.play_tutorial.icon_fullcover" 
	When I click "tutorials.try_icon" 
	When I click "tutorials.play_next_step" 
	When I click "tutorials.play_previous_step" 
	Then The element "tutorials.try_icon" should be shown 
	Then The element "tutorials.view_icon" should be shown 
	When I click "tutorials.try_icon" 
	And I should be able to play the tutorial to the last step 
	
Scenario Outline: Logged-in user without access plays a tutorial 
	Given I log in as a premium user
	And wait for 3 seconds
	When I go to "<tutorial>"
	Then The url should contain "siteError?errormsg=Access" 
	And I should see the message "Access denied: no read rights" 
	When I click "tutorials.errorpage.back" 
	Then I should be redirected to My tutorials tab 
	Examples:
	|type_tutorial|tutorial|
	|private|/player/642/Tutorial-4|
	|embed only|/player/643/Tutorial-5|
	
Scenario: Play locked tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	And I am at "/tutorials" 
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.play"
	Then I should be redirected to the player page of the tutorial 
	When I click "tutorials.play_tutorial.icon_fullcover" 
	And I should be able to play the tutorial to the last step 
	
Scenario Outline: Anonymous user plays a public/unlisted tutorial 
	When I go to "<tutorial>" 
	Then I should be redirected to the player page of the tutorial 
	When I click "tutorials.play_tutorial.icon_fullcover" 
	When I click "tutorials.try_icon" 
	When I click "tutorials.play_next_step" 
	When I click "tutorials.play_previous_step" 
	Then The element "tutorials.try_icon" should be shown 
	Then The element "tutorials.view_icon" should be shown 
	When I click "tutorials.try_icon" 
	And I should be able to play the tutorial to the last step  
	Examples:
	|type_tutorial|tutorial|
	|public|/player/640/Tutorial-2|
	|unlisted|/player/641/Tutorial-3|
	
Scenario Outline: Anonymous user plays a private/ embed only tutorial 
	When I go to "<tutorial>"  
	Then I should be redirected the Log In page 
	Examples:
	|type_tutorial|tutorial|
	|private|/player/642/Tutorial-4|
	|embed only|/player/643/Tutorial-5|
	
Scenario: Check the theme of a tutorial 
	Given I logged in iroad with user "yearlyprivateplanuser3" and password "validpassword"
	When I go to "/player/640/Tutorial-2" 
	Then I should be redirected to the player page of the tutorial
	When I click "tutorials.play_tutorial.icon_fullcover"
	When I click "tutorials.play.expand"
	Then The element "tutorials.play.logo_image" should be shown
	Then The text of element "tutorials.play.tutorial_title" should contain "Tutorial 2"
	Then The text of element "tutorials.play.length" should contain "2 STEPS (1 MINUTE)"
	When I click "tutorials.play_tutorial.icon_fullcover"
	Then The element "tutorials.play_pdf_link" should be shown 
	Then The element "tutorials.play.language" should be shown
	When I click "tutorials.play.full_screen" 
	And wait for 2 seconds
	When I click "tutorials.play.exit_full_screen" 
	
Scenario Outline: Replay the tutorial 
	When I go to "<tutorial>" 
	Then I should be redirected to the player page of the tutorial 
	When I click "tutorials.play_tutorial.icon_fullcover"
	And I should be able to play the tutorial to the last step
	When I click "tutorials.play.replay"  
	When I click "tutorials.play_next_step" 
	When I click "tutorials.play_previous_step" 
	Then The element "tutorials.try_icon" should be shown 
	Then The element "tutorials.view_icon" should be shown 
	When I click "tutorials.try_icon" 
	And I should be able to play the tutorial to the last step
	Examples:
	|type_tutorial|tutorial|
	|public|/player/640/Tutorial-2|
	|unlisted|/player/641/Tutorial-3| 
	
Scenario Outline: Copy tutorials on the player 
	Given I logged in iroad with user "yearlyprivateplanuser3" and password "validpassword"
	When I go to "<tutorial>" 
	Then I should be redirected to the player page of the tutorial 
	When I click "tutorials.play_tutorial.icon_fullcover"
	And I should be able to play the tutorial to the last step 
	When I click "tutorials.play.copy_link"
	Then I should see the message "Copied"
	When I click "tutorials.play.copy_embed" 
	Then I should see the message "Copied"
	Examples:
	|type_tutorial|tutorial|
	|public|/player/640/Tutorial-2|
	|unlisted|/player/641/Tutorial-3|
	
#can not install iorad extension automatically
@Chrome @Firefox @Edge @wip
Scenario: Check the Go Live link when iorad extension is installed 
	Given  I am at the last step of the player of a live tutorial or expand the theme 
	And  The Live checkbox should be checked in the Settings 
	Then  I should see the Go Live link on the theme 
	When  I click Go Live 
	Then  I should see the message "Are you ready to try this for real on the live application?" 
	When  I click Go Live in the messae 
	Then  I should be redirected to the website where the tutorial is captured in a new tab 

#can not install iorad extension automatically	
@Chrome @firefox @edge @wip
Scenario: Check the Go Live link when iorad extension is not installed yet 
	Given  I am at the last step of the player or expand the theme 
	And  The Live checkbox should be checked in the Settings 
	When  I click Go Live 
	Then  I should see the message "You need the iorad extension to go Live." 
	When  I click "Install extension" button in the message 
	Then  The extension installation guide should be shown 
	And  I should install the iorad extension by following the guide 
	
@safari @IE11 
Scenario: Check Go Live link 
	Given I logged in iroad with user "yearlyprivateplanuser3" and password "validpassword" 
	And I am at "/tutorials" 
	And  I click on "tutorials.three_dot_icon_specific_tutorial" of "Tutorial 6" 
	And I click "tutorials.setting" 
	When I click "tutorials.settings.live_tab"
	Then  I click "tutorials.settings.go_live_link" 
	Then  I should see the message "You need to switch to either chrome, firefox or edge to use this feature." 
	When  I click "tutorials.play.golive.installchrome" and switch to the second tab
	Then  The url should contain "google.com/chrome/" 
	
Scenario: play the public tutorial created by free user 
	When I go to "/player/646/Tutorial-1"
	Then I should be redirected to the player page of the tutorial
	Then The element "tutorials.play.create_by_free_account" should be shown
	When I click "tutorials.play.upgrade_link" and switch to the second tab
	Then I should see the pricing page content
	
Scenario: play the public tutorial created by premium user 
	When I go to "/player/648/Tutorial-1"
	Then The element "tutorials.play.create_by_free_account" should not be shown 
	Then The element "tutorials.play.upgrade_link" should not be shown
	
Scenario: select a language 
	When I go to "/player/640/Tutorial-2" 
	Then I should be redirected to the player page of the tutorial  
	When I click "tutorials.play.language"
	When Switch to "tutorials.play.language_frame" frame
	When I click "tutorials.play.language.afrikaans" 
	When Switch back to main frame
	When Switch to "tutorials.iorad_app_iframe" frame
	Then I should see the message "handleiding"
	When I click "tutorials.play.language"
	When Switch to "tutorials.play.language_frame" frame
	When I click by javascript "tutorials.play.language.english"
	When Switch back to main frame
	When Switch to "tutorials.iorad_app_iframe" frame
	Then I should see the message "Tutorial"
	
Scenario: view fullscreen 
	When I go to "/player/640/Tutorial-2" 
	Then I should be redirected to the player page of the tutorial
	When I click "tutorials.play.full_screen" 
	And wait for 2 seconds
	When I click "tutorials.play.exit_full_screen" 
	
#can not checkout content of pdf file 
@wip
Scenario: Free user saves tutorial as PDF 
	Given I am on the player page 
	And The Print option should be checked in the settings 
	When I click PDF 
	Then I should see the PDF menu with two options: Portrait PDF and Landscape PDF 
	When I select any option 
	Then The Generating your PDF file message should be shown 
	And I should be able to save it 
	When I open the PDF file 
	Then I just see 1 first papge without custom logo and background 
	
#can not checkout content of pdf file 
@wip
Scenario: Private user saves tutorial as PDF 
	Given I am on the player page 
	And The Print option should be checked in the settings 
	When I click PDF 
	Then I should see the PDF menu with two options: Portrait PDF and Landscape PDF 
	When I select any option 
	Then The Generating your PDF file message should be shown 
	And I should be able to save it 
	When I open the PDF file 
	Then I just see the full tutorial without custom logo and background 
	
#can not checkout content of pdf file 
@wip
Scenario: Premium / Live user saves tutorial as PDF 
	Given I am on the player page 
	And The Print option should be checked in the settings 
	When I click PDF 
	Then I should see the PDF menu with two options: Portrait PDF and Landscape PDF 
	When I select any option 
	Then The Generating your PDF file message should be shown 
	And I should be able to save it 
	When I open the PDF file 
	Then I just see the full tutorial with custom logo and background 
	
Scenario Outline: Check the Close button on the message when saving tutorial as PDF 
	When I go to "<tutorial>" 
	Then I should be redirected to the player page of the tutorial 
	And Store the text of element "tutorials.play.tutorial_title" in variable "tutorial_name_var"
	And I click "tutorials.play_pdf_link"
	And I click "tutorials.play_pdf_portrait"
	And wait for 5 seconds
	Then File PDF "tutorial_name_var" should exists
	And I click "tutorials.play_pdf_landscape"
	And wait for 5 seconds
	Then File PDF "tutorial_name_var" should exists
	Examples:
	|type_tutorial|tutorial|
	|public|/player/640/Tutorial-2|
	|unlisted|/player/641/Tutorial-3| 
	

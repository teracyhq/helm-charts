@test6 
Feature: Users can edit tutorials which they are shared the Edit permission by team members 

	As a team owner or member,
   I want to access the Shared Edit tab
   so that I could edit tutorials which I have the Edit permission
	
@smoke
Scenario Outline: Access the Shared Edit tab 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel 
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser1 | validpassword |
      
@function 
Scenario: Edit a tutorial 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.setting" 
	Then I should be redirected to the Editor page 
	When I fill value "{!auto,S5}" to "tutorials.tutorial_name_textbox" textbox and store value into variable "varExpectName"
	When I click "tutorials.finish_button" 
	When switch back to main frame
	When I click "tutorials.share_edit_tab"
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.setting" 
	Then I should be redirected to the Editor page 
	And Store the value of element "tutorials.tutorial_name_textbox" in variable "varActualName"
	And The variable "varExpectName" should be equal to variable "varActualName"
	
@function
Scenario Outline: check the tutorial menu's order as a normal user 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	Then The element "tutorials.play" should be shown
	Then The element "tutorials.setting" should be shown
	Then The element "tutorials.revisions" should be shown
	Then The element "tutorials.duplicate" should be shown
	When I click "tutorials.play"
	Then The element "tutorials.setting" should not be shown
	Then The element "tutorials.revisions" should not be shown
	Then The element "tutorials.duplicate" should not be shown
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
#need to create data
@function @wip
Scenario: check the tutorial menu's order as an admin user 
	Given I logged in iroad with user "adminuser" and password "validpassword"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	Then The element "tutorials.play" should be shown
	Then The element "tutorials.setting" should be shown
	Then The element "tutorials.revisions" should be shown
	Then The element "tutorials.translate" should be shown
	Then The element "tutorials.download" should be shown
	When I click "tutorials.play"
	Then The element "tutorials.setting" should not be shown
	Then The element "tutorials.revisions" should not be shown
	Then The element "tutorials.duplicate" should not be shown
	Then The element "tutorials.translate" should not be shown
	Then The element "tutorials.download" should not be shown
	
# UI change, don't see edit icon on player page
#https://github.com/iorad/iorad/issues/5351
@function @wip
Scenario Outline: play a Shared Edit tutorial 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	When I click "tutorials.play"
	Then I should be redirected to the player page of the tutorial
	Then The element "tutorials.try_icon" should be shown
    Then The element "tutorials.view_icon" should be shown
	When I click Edit icon 
	Then I should be redirected to the Editor page 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: Duplicate a shared edit tutorial 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	When I click "tutorials.duplicate"
	And I should see the message "Successfully copied!" 
	Then I should be redirected to Shared Edit tab 
	And The text of element "tutorials.name_tutorial_label" should contain "-- Copy"
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab
	When I reload page
	And The text of element "tutorials.name_tutorial_label" should contain "-- Copy"
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	And The text of element "tutorials.name_tutorial_label" should not contain "-- Copy"
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: check revisions of a tutorial 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	And I click "tutorials.revisions"
	Then I should be redirected to the Revisions page of the tutorial 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: close the Revision history page 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	And I click "tutorials.revisions"
	Then I should be redirected to the Revisions page of the tutorial 
	When I click "tutorials.revision_page_close"
	Then I should be redirected to Shared Edit tab 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
#can not write script to record/capture steps
@function @wip
Scenario Outline: check if a revision is created after adding more steps 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	And I click "tutorials.revisions"
	Then I should be redirected to the Revisions page of the tutorial 
	Then A new revision should be created 
	And The label "Current" should be the latest revision 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: check if a revision is created after changing settings 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	And I click "tutorials.revisions"
	Then I should be redirected to the Revisions page of the tutorial 
	Then Store the number of element "tutorials.revision_page_number_of_revision" in variable "oldValue"
	And I click "tutorials.revision_page_close"
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.setting" 
	Then I should be redirected to the Editor page 
	When I fill value "{!auto,S5}" to "tutorials.tutorial_name_textbox" textbox and store value into variable "varExpectName"
	When I click "tutorials.finish_button" 
	When switch back to main frame
	When I click "tutorials.share_edit_tab"
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	And I click "tutorials.revisions"
	Then I should be redirected to the Revisions page of the tutorial 
	Then Store the number of element "tutorials.revision_page_number_of_revision" in variable "newValue"
	Then The variable "oldValue" should be equal to variable "newValue"
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
#can not write script to record/capture steps
@function @wip
Scenario Outline: Just 10 latest revisions should be kept 
	Given I add more steps for a tutorial more than 10 times 
	When I go to the Revisions page of the tutorial 
	Then Just 10 latest revisions should be listed on the Revisions page 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
#can not write script to record/capture steps
@function @wip
Scenario Outline: revert to a specific revision 
	Given The tutorial has at least two revisions 
	And I am at the Revisions page of a tutorial 
	When I click Revert link corresponding to a revision 
	Then The tutorial should be reverted to the selected revision 
	And The Revert link should be changed into the Current label 
	When I play the tutorial 
	Then The reverted revision should be applied 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: Do settings for a shared edit tutorial 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	And I click "tutorials.setting"
	Then I should be redirected to the Editor page 
	When I fill value "{!auto,S5}" to "tutorials.tutorial_name_textbox" textbox and store value into variable "varExpectName"
	When I click "tutorials.finish_button" 
	When switch back to main frame
	When I click "tutorials.share_edit_tab"
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.setting" 
	Then I should be redirected to the Editor page 
	And Store the value of element "tutorials.tutorial_name_textbox" in variable "varActualName"
	And The variable "varExpectName" should be equal to variable "varActualName"
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: Delete a shared edit tutorial 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	And Store the text of element "tutorials.name_tutorial_label" in variable "varBefore"
	When I click "tutorials.three_dot_icon"
	When I click "tutorials.delete_tutorial_button"
	When I click "tutorials.confirm_yes"
	Then I should see the message "Tutorial is successfully deleted." 
	And Store the text of element "tutorials.name_tutorial_label" in variable "varAfter"
	And The variable "varAfter" should not be equal to variable "varBefore"
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab
	And Store the text of element "tutorials.name_tutorial_label" in variable "varAfter"
	And The variable "varAfter" should be equal to variable "varBefore"
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: search tutorials by tags / description / title 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab"
	Then I should be redirected to Shared Edit tab 
	And Store the text of element "tutorials.name_tutorial_label" in variable "varBefore"
	When I fill variable "varBefore" to "tutorials.search_tutorials" textbox
	And I press Enter 
	And Store the text of element "tutorials.name_tutorial_label" in variable "varAfter"
	And The variable "varAfter" should be equal to variable "varBefore"
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: no search results found 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	Then The element "tutorials.name_tutorial_label" should be shown
	When I search for "auto test search keyword" tutorial 
	And I press Enter 
	Then I should see the message "No Results Found" 
	Then The element "tutorials.name_tutorial_label" should not be shown
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
      
@function
Scenario Outline: remove search keywords 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab"
	Then I should be redirected to Shared Edit tab 
	Then The element "tutorials.name_tutorial_label" should be shown
	When I search for "auto test search keyword" tutorial 
	And I press Enter 
	Then I should see the message "No Results Found" 
	Then The element "tutorials.name_tutorial_label" should not be shown
	And I click "tutorials.search_tutorials_remove_key"
	Then The element "tutorials.name_tutorial_label" should be shown
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: add labels to the tutorial 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.add_tag_button"
	When I fill value "{!auto,S5}" to "tutorials.tag_textbox" textbox
	And I press Enter 
	When I click "tutorials.add_tag_button"
	When I fill value "{!auto,S5}" to "tutorials.tag_textbox" textbox
	And I press Enter 
	When I click "tutorials.add_tag_button"
	When I fill value "{!auto,S5}" to "tutorials.tag_textbox" textbox
	And I press Enter 
	When I click "tutorials.add_tag_button"
	When I fill value "{!auto,S5}" to "tutorials.tag_textbox" textbox
	And I press Enter 
	When I click "tutorials.add_tag_button"
	When I fill value "{!auto,S5}" to "tutorials.tag_textbox" textbox
	And I press Enter 
	Then The element "tutorials.add_tag_button" should not be shown 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@function
Scenario Outline: remove label of a tutorial 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	When I click "tutorials.remove_tag_button"
	When I click "tutorials.remove_tag_button"
	When I click "tutorials.remove_tag_button"
	When I click "tutorials.remove_tag_button"
	When I click "tutorials.remove_tag_button"
	Then The element "tutorials.remove_tag_button" should not be shown 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
#can not control datatest
@function @wip
Scenario Outline: sort tutorial list by Name/Shared By/Steps/Privacy/Last Edited 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	When I click "tutorials.three_dot_icon"
	When I click "tutorials.header_name" 
	Then The tutorials should be sorted by name in the descending or ascending order 
	When I click "tutorials.header_shared_by"
	Then The tutorials should be sorted by Shared By in the descending or ascending order 
	When I click "tutorials.header_privacy" 
	Then The tutorials should be sorted by Privacy in the descending or ascending order 
	When I click "tutorials.header_last_edit"
	Then The tutorials should be sorted by Last Edited Date in the descending or ascending order 
	When I click "tutorials.header_steps" 
	Then The tutorials should be sorted by the descending or ascending number of steps 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
#don't see tag in left panel
@function @fail	
Scenario Outline: search tutorials with the category / label on the left 
	Given I logged in iroad with user "<username>" and password "<password>"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab 
	Then Store the number of element "tutorials.name_tutorial_label" in variable "oldValue"
	When I click "tutorials.three_dot_icon"
	When I click "tutorials.add_tag_button"
	When I fill value "tag1" to "tutorials.tag_textbox" textbox
	And I press Enter 
	When I click "tutorial.tag_link"
	Then Store the number of element "tutorials.name_tutorial_label" in variable "newValue"
	And The variable "newValue" should be equal to variable "oldValue"
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser2 | validpassword |
	
@wip 
Scenario Outline: new owner edits the tutorial when the previous owner is at Editor page 
	Given The owner permission of a team's tutorial was transferred to me 
	And The previous owner of the tutorial is editing it 
	When I go to Your Tutorials page 
	And I hover the mouse on the tutorial 
	And I click the Edit icon 
	Then I should see the message "Some [email] is editing the tutorial please wait for him to unlock or should we allow him to go to the editor" 
	Examples: 
      | username       | password      |
      | teamowneruser1  | validpassword |
      | teammemberuser1 | validpassword |

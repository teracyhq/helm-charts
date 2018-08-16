@desktop @test6
Feature: tutorial editor 

	As a logged-in user,
    I want to access the Editor page
    so that I could change my tutorial as I expect.

@smoke
Scenario: Access the Editor page of a tutorial 
	Given I am a logged in user 
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 

@function
Scenario: update the valid tutorial title 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.title"
	And I fill value "{s150}" to "tutorials.edit_tutorial.title" textbox and store value into variable "newtitlevar" 
	And I press Enter 
	Then The text of element "tutorials.edit_tutorial.title" should be equal value of variable "newtitlevar" 
	
@function
Scenario: update the tutorial title having more 150 characters 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When Store the text of element "tutorials.edit_tutorial.title" in variable "oldtitlevar" 
	When I click "tutorials.edit_tutorial.title"
	And I fill value "{s151}" to "tutorials.edit_tutorial.title" textbox 
	And I press Enter 
	Then I should see the error message "Tutorial title can only be 150 total characters." 
	Then The text of element "tutorials.edit_tutorial.title" should be equal value of variable "oldtitlevar" 
	
@function
Scenario: update the empty/space-key tutorial title having
	Given I am a logged in user 
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When Store the text of element "tutorials.edit_tutorial.title" in variable "oldtitlevar" 
	When I click "tutorials.edit_tutorial.title"
	And I fill value " " to "tutorials.edit_tutorial.title" textbox 
	And I press Enter 
	Then The text of element "tutorials.edit_tutorial.title" should be equal value of variable "oldtitlevar" 

@function
Scenario: change step type of a tutorial captured by iorad app 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword"
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then I should not see the "tutorials.edit_tutorial.step_style.type_text_area" item
	When I click "tutorials.edit_tutorial.step_style"
	And I click "tutorials.edit_tutorial.step_style.type_text"
	Then I should see the "tutorials.edit_tutorial.step_style.type_text_area" item
	
@function
Scenario: Cancel changing step type of a tutorial captured by iorad extension 
	Given I am a logged in user 
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then I should not see the "tutorials.edit_tutorial.step_style.type_text_area" item
	When I click "tutorials.edit_tutorial.step_style"
	And I click "tutorials.edit_tutorial.step_style.type_text"
	Then I should see the message "If you change the step type it will no longer work in live mode." 
	When I click "tutorials.edit_tutorial.cancel_change_step_type_button" 
	Then I should not see the "tutorials.edit_tutorial.step_style.type_text_area" item
	
@function
Scenario: change step type of a tutorial captured by iorad extension 
	Given I am a logged in user 
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then I should not see the "tutorials.edit_tutorial.step_style.type_text_area" item
	When I click "tutorials.edit_tutorial.step_style"
	And I click "tutorials.edit_tutorial.step_style.type_text"
	Then I should see the message "If you change the step type it will no longer work in live mode." 
	When I click "tutorials.edit_tutorial.change_step_type_button" 
	Then I should see the "tutorials.edit_tutorial.step_style.type_text_area" item

#do not install iorad app automaticly
@function @wip
Scenario: add steps for tutorial captured by iorad app 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword"
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.add_step"
	Then The capture framework should be opened 
	
#do not install iorad app automaticly
@chrome @function @wip
Scenario: add steps for tutorial captured by iorad extension 
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.add_step"
	Then The capture guide of the extension should be shown 
	
#do not install iorad app automaticly
@firefox @safari @function @wip
Scenario: add steps for tutorial captured by iorad extension 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword"
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.add_step"
	Then The warning message "You captured the original steps using the chrome extension, so switch to chrome to keep it uniform." should be shown 

#do not install iorad app automaticly
 @function @wip
Scenario: cancel adding more steps when capturing is not started 
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I add more steps 
	And I cancel capturing 
	Then I should be back to the Editor 
	
#do not install iorad app automaticly
 @function @wip
Scenario: cancel adding more steps when capturing is started 
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	And I am capturing new steps 
	When I cancel capturing 
	Then I should be back to the Capture Canceled page 
	And I should see Restart Capture button to restart capturing 
	And I should see the Back to Edit to return the Editor page 
	
@function
Scenario: copy a step 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then Store the text of element "tutorials.edit_tutorial.number_of_steps" in variable "beforevar"
	When I click "tutorials.edit_tutorial.copy_step"
	Then I should see an informative message "You are now on the copied slide" 
	Then Store the text of element "tutorials.edit_tutorial.number_of_steps" in variable "aftervar"
	Then The variable "aftervar" should be equal to variable "beforevar" plus "1"

#can not drag drop	
 @function @wip
Scenario: premium user masks a slide 
    Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.mask_step"
	When I drag my mouse over any area 
	Then I should see the message "Drag your mouse over the area you want to mask." 
	When I drag my mouse over any area 
	Then I should see the message "This is permanent. Are you sure?"
	When I click "tutorials.edit_tutorial.mask.iam_sure_button" 
	
#can not drag drop	
 @function @wip
Scenario: premium user cancel masking a slide 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.mask_step"
	When I drag my mouse over any area 
	Then I should see the message "Drag your mouse over the area you want to mask." 
	When I drag my mouse over any area 
	Then I should see the message "This is permanent. Are you sure?"
	When I click "tutorials.edit_tutorial.cancel_mask_button" 
	
#can not drag drop	
 @function @wip
Scenario: free user masks a slide 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.mask_step"
	Then I should see the message "Drag your mouse over the area you want to mask." 
	When I drag my mouse over any area 
	And I should see an error message "That is sensitive information. Upgrade to permanently hide it." 
	When I click the mouse on another location 
	Then The area masked should be unmasked 
	When I click "Upgrade" in the error message 
	Then I should be redirected to the "/upgradeplan" page 
	
@function
Scenario: delete a step 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then Store the text of element "tutorials.edit_tutorial.number_of_steps" in variable "beforevar"
	When I click "tutorials.edit_tutorial.delete_step" 
	Then I should see the message "Slide deleted. Right click to undo delete" 
	Then Store the text of element "tutorials.edit_tutorial.number_of_steps" in variable "aftervar"
	Then The variable "beforevar" should be equal to variable "aftervar" plus "1"
	
@function
Scenario: delete all steps of a tutorial 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I continue to delete the final step of tutorial 
	When I click "tutorials.edit_tutorial.delete_step"
	Then I should see the message "You need at least 1 step. To delete the whole tutorial:" 
	
@function
Scenario: edit a step instruction with less than 250 characters 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then switch to "tutorials.edit_tutorial.step_title_iframe" frame
	And I fill value "{s250}" to "tutorials.edit_tutorial.step_editor" textbox 
	
@function
Scenario: edit a step instruction with more 250 characters 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then switch to "tutorials.edit_tutorial.step_title_iframe" frame
	And I fill value "{s251}" to "tutorials.edit_tutorial.step_editor" textbox 
	Then switch back to main frame
	Then switch to "tutorials.iorad_app_iframe" frame
	Then I should see the error message "That's alot of text" 
	
@function
Scenario: navigate steps 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.copy_step"
	When I click "tutorials.edit_tutorial.copy_step"
	When I click "tutorials.edit_tutorial.prev_step"
	When I click "tutorials.edit_tutorial.next_step" 
	
@function
Scenario: zoom in/ zoom out 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.zoom_in"
	Then I click "tutorials.edit_tutorial.zoom_out"
	
@function
Scenario: view in fullscreen 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.full_screen_button"
	Then I click "tutorials.edit_tutorial.exit_full_screen_button"
	
@function
Scenario: Check the context menu 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click by javascript "tutorials.edit_tutorial.context_menu.next" 
	When I click by javascript "tutorials.edit_tutorial.context_menu.back" 
	When I click by javascript "tutorials.edit_tutorial.context_menu.copy" 
	
@function
Scenario: Check the Move Step Back item disabled on the first step 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	And I am at the first step 
	When I reload page
	Then The "tutorials.edit_tutorial.prev_step" should be disabled
	Then The "tutorials.edit_tutorial.context_menu.back" should be disabled
	Then The "tutorials.edit_tutorial.context_menu.moveLeft" should be disabled
	
@function
Scenario: Check the Move Step Ahead item disabled on the last step 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	And I am at the last step 
	Then The "tutorials.edit_tutorial.next_step" should be disabled
	Then The "tutorials.edit_tutorial.context_menu.moveRight" should be disabled
	
@function
Scenario: Check the Undo Highlight Resize item disabled on the next step 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_tutorial.copy_step"
	When I click "tutorials.edit_tutorial.context_menu.undo" 
	When I click "tutorials.edit_tutorial.context_menu.redo" 
	
@function
Scenario: check the Preview & Finish button 
	Given I am a logged in user
	Given I am at "/tutorials" 
	When I click "tutorials.tutorial_edit_action_btn" 
	Then I should be redirected to the Editor page to edit that tutorial 
	When I click "tutorials.edit_preview_and_finish_button"
	Then I should be redirected to the Finish page 
	When I click "tutorials.back_button"
	Then I should be redirected to the Editor page to edit that tutorial 

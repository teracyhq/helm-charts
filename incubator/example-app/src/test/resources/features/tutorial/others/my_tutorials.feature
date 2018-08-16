@test6 
Feature: Manage my tutorials 

	As a user,
    I want to have a tutorial management page
    so that I could manage theme effectively.

@smoke 
Scenario: view "My tutorials" page 
	Given I am a logged in user 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	
Scenario Outline: sort tutorial list by Name/Steps/Live Mode/ Privacy/Last Edited 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Sort by Name
	When I click "tutorials.header_name" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_name" in the "ascending" order 
	When I click "tutorials.header_name" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_name" in the "descending" order 
	# Sort by Steps
	When I click "tutorials.header_steps" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_steps" in the "ascending" order 
	When I click "tutorials.header_steps" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_steps" in the "descending" order 
	# Sort by Live mode
	When I click "tutorials.header_live_mode" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_live_mode" in the "ascending" order 
	When I click "tutorials.header_live_mode" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_live_mode" in the "descending" order 
	# Sort by Last Edit
	When I click "tutorials.header_last_edit" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_last_edited_date" in the "ascending" order 
	When I click "tutorials.header_last_edit" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_last_edited_date" in the "descending" order 
	# Sort by Privacy
	When I click "tutorials.header_privacy" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_privacy" in the "ascending" order 
	When I click "tutorials.header_privacy" 
	Then My tutorials should be sorted by "tutorials.my_tutorials.tutorial_privacy" in the "descending" order 
	Examples: 
		|	user						| password			|	
		| teamowneruser1	|	validpassword	|	
		
Scenario Outline: search tutorials by tags / description / title 
# login
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Search by title
	When I search for "<tutorial_title>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	And The text of element "tutorials.name_tutorial_label" should be "<tutorial_title>" 
	# Search by description - Add a descriptio first
	When I click "tutorials.select_tutorial_chk" 
	And I click "tutorials.add_category_or_tag_btn" 
	And I click "tutorials.add_category_tag_modal.description_tab" 
	And I fill value "<tutorial_description>" to "tutorials.add_category_tag_modal.description_tab.description_textbox" textbox 
	And I click "tutorials.add_category_tag_modal.apply_button" 
	Then I should see the message "Categories/Labels updated" 
	When I search for "<tutorial_description>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	And The text of element "tutorials.name_tutorial_label" should be "<tutorial_title>" 
	# Search by tags
	When I search for "<tutorial_tags>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	And The text of element "tutorials.inputted_tags" should contain "<tutorial_tags>" 
	
	Examples: 
		| tutorial_title    								|	tutorial_description	|	tutorial_tags		|
		| tutorial created by the owner 3 	|	auto description			|	member					|
		
Scenario Outline: no search results found 
# Login
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Search for a tutorial
	When I search for "<tutorial>" tutorial 
	Then I should see the message "No Results Found" 
	And The element "tutorials.name_tutorial_label" should not be shown 
	
	Examples: 
		| tutorial    |
		| no tutorial |
		
Scenario Outline: remove search keywords 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	And Store the number of element "tutorials.select_tutorial_chk" in variable "tutorial_quantity_before" 
	# Search for a tutorial
	When I search for "<tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Close Search
	When I click "tutorials.search_tutorials_remove_key" 
	Then The attribute "value" of element "tutorials.search_tutorials" should not be "<tutorial>" 
	When Store the number of element "tutorials.select_tutorial_chk" in variable "tutorial_quantity_after" 
	Then The variable "tutorial_quantity_before" should be equal to variable "tutorial_quantity_after" 
	Examples: 
		|	user						| password			|	tutorial    				|	
		| teammemberuser	|	validpassword	|	member tutorial 3		|	
		
Scenario Outline: rename tutorial with 150 characters 
# Login
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Search for a tutorial
	When I search for "<tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Edit name
	When I click "tutorials.name_tutorial_label" 
	Then The element "tutorials.add_tutorial_name_txt" should be shown 
	When I fill value "<new_tutorial_name>" to "tutorials.add_tutorial_name_txt" textbox 
	And I press Enter 
	Then I should see the message "Tutorial renamed." 
	And The text of element "tutorials.name_tutorial_label" should be "<new_tutorial_name>" 
	# Set back to the original name
	When I search for "<new_tutorial_name>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	When I click "tutorials.name_tutorial_label" 
	Then The element "tutorials.add_tutorial_name_txt" should be shown 
	When I fill value "<tutorial>" to "tutorials.add_tutorial_name_txt" textbox 
	And I press Enter 
	Then I should see the message "Tutorial renamed." 
	And The text of element "tutorials.name_tutorial_label" should be "<tutorial>" 
	
	Examples: 
		| tutorial    										|	new_tutorial_name	|
		| Public Plan having custom theme |	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	|
		
Scenario Outline: rename tutorial with more 150 characters 
# Login
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Search for a tutorial
	When I search for "<tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Edit name
	When I click "tutorials.name_tutorial_label" 
	Then The element "tutorials.add_tutorial_name_txt" should be shown 
	When I fill value "<new_tutorial_name>" to "tutorials.add_tutorial_name_txt" textbox 
	And I press Enter 
	Then I should see the error message "Tutorial title can only be 150 total characters." 
	And The text of element "tutorials.name_tutorial_label" should be "<tutorial>" 
	
	Examples: 
		| tutorial    										|	new_tutorial_name	|
		| Embed Only tutorial						  |	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	|
		
Scenario Outline: rename tutorial with empty or space-key characters 
# Login
	Given I logged in iroad with user "premiumindividualuser1" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Search for a tutorial
	When I search for "<tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Edit name
	When I click "tutorials.name_tutorial_label" 
	Then The element "tutorials.add_tutorial_name_txt" should be shown 
	When I fill value "<new_tutorial_name>" to "tutorials.add_tutorial_name_txt" textbox 
	And I press Enter 
	Then I should see the error message "The tutorial title is required" 
	And The text of element "tutorials.name_tutorial_label" should be "<tutorial>" 
	
	Examples: 
		| tutorial    										|	new_tutorial_name	|
		| Embed Only tutorial						  |										|
		
Scenario Outline: check the tutorial menu's order as a normal user 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Check the list of options
	When I click "tutorials.three_dot_icon" 
	Then The "tutorials.play" should be visible 
	And The "tutorials.setting" should be visible 
	And The "tutorials.share_button" should be visible 
	And The "tutorials.revisions" should be visible 
	And The "tutorials.duplicate" should be visible 
	And The "tutorials.delete" should be visible 
	# Close
	When I click "tutorials.search_tutorials" 
	Then The "tutorials.play" should be invisible 
	
	Examples: 
		|	user						| password			|	
		| teammemberuser	|	validpassword	|	
		
Scenario: check the tutorial menu's order as an admin user 
	Given I am a logged-in as an admin 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Check the list of options
	When I click "tutorials.three_dot_icon" 
	Then The "tutorials.play" should be visible 
	And The "tutorials.setting" should be visible 
	And The "tutorials.share" should be visible
	And The "tutorials.audio" should be visible
	And The "tutorials.revisions" should be visible
	And The "tutorials.translate" should be visible
	And The "tutorials.download" should be visible
	And The "tutorials.duplicate" should be visible 
	And The "tutorials.statistics" should be visible 
	And The "tutorials.delete" should be visible 
	
	# Close
	When I click "tutorials.search_tutorials" 
	Then The "tutorials.play" should be invisible 
	
	
Scenario Outline: Play tutorial 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Search for a tutorial
	When I search for "<tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Play the tutorial
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.play" 
	Then I should be redirected to the "<tutorial_player>" page in new tab 
	
	Examples: 
		|	user						| password			|	tutorial    				|	tutorial_player		|
		| teammemberuser	|	validpassword	|	member tutorial 3		|	/player/370/member-tutorial-3										|
		
Scenario Outline: duplicate (copy) a tutorial 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Search for a tutorial
	When I search for "<tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	And The text of element "tutorials.inputted_tags" should contain "<tags>" 
	# Duplicate the tutorial
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.duplicate" 
	Then I should see the message "Successfully copied!" 
	When I search for "<duplicate_tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	Then The text of element "tutorials.name_tutorial_label" should be "<duplicate_tutorial>" 
	And The text of element "tutorials.inputted_tags" should contain "<tags>" 
	# Delete the duplicate tutorial
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.delete" 
	And I click "tutorials.confirm_yes" 
	Then I should see the message "Tutorial is successfully deleted." 
	
	Examples: 
		|	user						| password			|	tutorial    																	|	duplicate_tutorial																		|		tags	|
		| teamowneruser1	|	validpassword	|	this tutorial is shared Edit rights to others	|	this tutorial is shared Edit rights to others -- Copy	|	member	|
		
Scenario Outline: check revisions of a tutorial 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Check the revisions page
	When I search for "<tutorial>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.revisions" 
	Then I should be redirected to the Revisions page of the tutorial 
	And The text of element "tutorials.revision_page_current_label" should be "Current" 
	
	Examples: 
		|	user						| password			|	tutorial					|
		| teammemberuser	|	validpassword	|	member tutorial 1	|
		
Scenario Outline: close the Revision history page 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Check the Revisions page
	When I search for "<tutorial>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.revisions" 
	Then I should be redirected to the Revisions page of the tutorial 
	And The text of element "tutorials.revision_page_current_label" should be "Current" 
	# Close the Revisions
	When I click "tutorials.revision_page_close" 
	Then I should be redirected to My tutorials tab 
	And The "tutorials.revision_page_label" should be invisible 
	
	Examples: 
		|	user						| password			|	tutorial					|
		| teammemberuser	|	validpassword	|	member tutorial 1	|
		
#can not write script to record/capture steps
@function @wip 
Scenario: check if a revision is created after adding more steps 
	Given I edit the tutorial and add more steps 
	When I go to the Revisions page of a tutorial 
	Then A new revision should be created 
	And The label "Current" should be the latest revision 
	
Scenario Outline: check if a revision is created after changing settings 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Save the revisions number
	When I search for "<tutorial_name>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.revisions" 
	Then I should be redirected to the Revisions page of the tutorial 
	And Store the number of element "tutorials.revision_page_number_of_revision" in variable "previous_revisions_quantity" 
	When I click "tutorials.revision_page_close" 
	Then I should be redirected to My tutorials tab 
	# Change the tutorial's settings
	When I click "tutorials.select_tutorial_chk" 
	And I click "tutorials.add_category_or_tag_btn" 
	# Description
	And I click "tutorials.add_category_tag_modal.description_tab" 
	And I fill value "<tutorial_description>" to "tutorials.add_category_tag_modal.description_tab.description_textbox" textbox 
	# Tags
	And I click "tutorials.add_category_tag_modal.tag_tab" 
	And I fill value "<tutorial_tags>" to "tutorials.add_category_tag_modal.tag_tab.tags_textbox" textbox 
	And I press Enter 
	# Category
	And I click "tutorials.add_category_tag_modal.categories_tab" 
	And I fill value "<tutorial_category>" to "tutorials.add_category_tag_modal.categories_tab.categories_textbox" textbox 
	And I press Enter 
	And I click "tutorials.add_category_tag_modal.apply_button" 
	Then I should see the message "Categories/Labels updated" 
	# Check the revisions
	When I search for "<tutorial_name>" tutorial 
	And I click "tutorials.three_dot_icon" 
	And I click "tutorials.revisions" 
	Then I should be redirected to the Revisions page of the tutorial 
	And Store the number of element "tutorials.revision_page_number_of_revision" in variable "current_revisions_quantity" 
	And The variable "previous_revisions_quantity" should be equal to variable "current_revisions_quantity" 
	
	Examples: 
		|	user						| password			|	tutorial_name			|	new_tutorial_name		|	tutorial_description	|	tutorial_tags	|	tutorial_category	|
		| teammemberuser	|	validpassword	|	member tutorial 2	|	member tutorial 2a	|	auto description			|	auto;					|	auto							|
		
		
#can not write script to record/capture steps
@function @wip 
Scenario: Just 10 latest revisions should be kept 
	Given I add more steps for a tutorial more than 10 times 
	When I go to the Revisions page of the tutorial 
	Then Just 10 latest revisions should be listed on the Revisions page 
	
Scenario: revert to a specific revision 
	Given I am a logged-in as an admin 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	Then The text of element "tutorials.first_tutorial.step" should be "6"
	# Check the list of options
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.revisions" 
	And I click "tutorials.revisionbtn"
	Then I should see the message "Tutorial has been reverted"
	And I click "tutorials.revision_page_close"
	And I reload page
	Then The text of element "tutorials.first_tutorial.step" should be "2"
	
Scenario: change settings of a tutorial 
	Given I am a logged in user 
	Then I should see the My tutorials page content 
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.setting" 
	Then I should be redirected to the Finish page of the tutorial 
	And The element "tutorials.preview_desktop_mode_active" should be shown 
	
Scenario Outline: delete a tutorial 
# Login
	Given I logged in iroad with user "<user>" and password "<password>" 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	# Search for a tutorial
	When I search for "<tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	# Duplicate the tutorial
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.duplicate" 
	Then I should see the message "Successfully copied!" 
	When I search for "<duplicate_tutorial>" tutorial 
	Then The element "tutorials.name_tutorial_label" should be shown 
	Then The text of element "tutorials.name_tutorial_label" should be "<duplicate_tutorial>" 
	# Delete the duplicate tutorial
	When I click "tutorials.three_dot_icon" 
	And I click "tutorials.delete" 
	And I click "tutorials.confirm_yes" 
	Then I should see the message "Tutorial is successfully deleted." 
	When I reload page 
	When I search for "<duplicate_tutorial>" tutorial 
	Then I should see the message "No Results Found" 
	
	Examples: 
		|	user						| password			|	tutorial    																	|	duplicate_tutorial																		|
		| teamowneruser1	|	validpassword	|	this tutorial is shared Edit rights to others	|	this tutorial is shared Edit rights to others -- Copy	|
		
@function 
Scenario: cancel deleting a tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button" 
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url" 
	And I click "tutorials.tab_share_tutorial_tab_close" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click by javascript "tutorials.delete" 
	And I click "tutorials.confirm_no" 
	When I navigate to url with url is value of variable "url" 
	And I should be able to play the tutorial to the last step 
	
@function 
Scenario: cancel deleting many selected tutorials 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button" 
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url1" 
	And I click "tutorials.tab_share_tutorial_tab_close" 
	When I click "tutorials.public_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button" 
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url2" 
	And I click "tutorials.tab_share_tutorial_tab_close" 
	When I click "tutorials.private_lock_tutorial.checkbox" 
	When I click "tutorials.public_lock_tutorial.checkbox" 
	When I click "tutorials.delete" 
	And I click "tutorials.confirm_no" 
	When I navigate to url with url is value of variable "url1" 
	And I should be able to play the tutorial to the last step 
	When I navigate to url with url is value of variable "url2" 
	And I should be able to play the tutorial to the last step 
	
@function 
Scenario: delete many tutorials (including locked tutorials) at the same time 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.private_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button" 
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url1" 
	And I click "tutorials.tab_share_tutorial_tab_close" 
	When I click "tutorials.public_lock_tutorial.three_dot_icon" 
	And I click "tutorials.share_button" 
	When Store the value of element "tutorials.tab_share_tutorial_direct_link" in variable "url2" 
	And I click "tutorials.tab_share_tutorial_tab_close" 
	When I click "tutorials.private_lock_tutorial.checkbox" 
	When I click "tutorials.public_lock_tutorial.checkbox" 
	When I click "tutorials.delete" 
	And I click "tutorials.confirm_yes" 
	When I navigate to url with url is value of variable "url1" 
	Then I should see the message "Tutorial does not exist." 
	When I navigate to url with url is value of variable "url2" 
	Then I should see the message "Tutorial does not exist." 
	
@function
Scenario: Add labels for a tutorials 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"  
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	Then I should see the message "tu1" 
	
@function
Scenario: Add 5 labels for a tutorials 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn" 
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter 
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu2" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter 
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu3" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter 
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu4" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter 
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu5" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter 
	Then I should see the message "tu1" 
	Then I should see the message "tu2" 
	Then I should see the message "tu3" 
	Then I should see the message "tu4" 
	Then I should see the message "tu5" 
	Then The element "tutorials.first_tutorial.add_tag_btn" should not be shown 
	
@function
Scenario: Remove label of a tutorial 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn" 
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "labeltu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter 
	Then I should see the message "labeltu1"
	When I click "tutorials.first_tutorial.delete_tag_btn" 
	Then I should not see the message "labeltu1" 
	
@function
Scenario: Add a category for a tutorial 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter 
	Then The element "tutorials.add_category_list" should be shown 
	Then I should see the message "cat1" 
	Then The element "tutorials.private_lock_tutorial.add_category_button" should not be shown
	
@function
Scenario: Remove a category of a tutorial 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When I click "tutorials.add_category_button" 
	When I fill value "cat1" to "tutorials.add_category_textbox" textbox 
	And I press Enter 
	And I click "tutorials.delete_category_btn" 
	Then The element "tutorials.add_category_button" should be shown 
	
@function 
Scenario: Add a very long category/label for a tutorial 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.add_category_button" 
	When I fill value "{s150}" to "tutorials.add_category_textbox" textbox 
	And I press Enter 
	When I click "tutorials.add_tag_button" 
	When I fill value "{s150}" to "tutorials.tag_textbox" textbox 
	And I press Enter 
	
@function
Scenario: Cancel adding category/ labels/ description to multiple tutorials 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn"
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn" 
	When I click "tutorials.select_all_chk" 
	When I click "tutorials.add_category_or_tag_btn"  
	When I click "tutorials.add_category_tag_modal.categories_tab" 
	When I click "tutorials.add_category_tag_modal.categories_tab.categories_textbox" 
	When I fill value "cat1" to "tutorials.add_category_tag_modal.categories_tab.categories_textbox" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.description_tab" 
	When I fill value "tutorialdescription" to "tutorials.add_category_tag_modal.description_tab.description_textbox" textbox 
	When I click "tutorials.add_category_tag_modal.tag_tab" 
	When I click "tutorials.add_category_tag_modal.tag_input" 
	When I fill value "multipletutorials1" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.close_button" 
	Then The element "tutorials.add_category_list" should not be shown 
	Then I should not see the message "multipletutorials1" 
	
@function
Scenario: add category, description & labels for one or some tutorials 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When I click "tutorials.select_all_chk" 
	When I click "tutorials.add_category_or_tag_btn"  
	When I click "tutorials.add_category_tag_modal.categories_tab" 
	When I click "tutorials.add_category_tag_modal.categories_tab.categories_textbox" 
	When I fill value "cat1" to "tutorials.add_category_tag_modal.categories_tab.categories_textbox" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.description_tab" 
	When I fill value "tutorialdescription" to "tutorials.add_category_tag_modal.description_tab.description_textbox" textbox 
	When I click "tutorials.add_category_tag_modal.tag_tab" 
	When I click "tutorials.add_category_tag_modal.tag_input" 
	When I fill value "multipletutorials1" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.tag_apply_button" 
	Then The element "tutorials.add_category_list" should be shown 
	Then I should see the message "multipletutorials1" 
	
@function
Scenario: remove input tags in the Category, Description & Labels page 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When I click "tutorials.select_all_chk" 
	When I click "tutorials.add_category_or_tag_btn" 
	When I click "tutorials.add_category_tag_modal.tag_tab"
	When I fill value "removetag" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	Then I should see the message "removetag" 
	When I hover the mouse on the "tutorials.add_category_tag_modal.tag_first_item"
	When I click "tutorials.add_category_tag_modal.tag_tab.delete"
	Then I should not see the message "removetag" 
	When I click "tutorials.add_category_tag_modal.tag_apply_button"
	Then I should not see the message "Categories/Labels updated"
	
Scenario: add more than 5 labels to the selected tutorials 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"  
	When I click "tutorials.select_all_chk"
	When I click "tutorials.add_category_or_tag_btn" 
	When I click "tutorials.add_category_tag_modal.tag_tab" 
	When I click "tutorials.add_category_tag_modal.tag_input" 
	When I fill value "tag1" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.tag_input" 
	When I fill value "tag2" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.tag_input" 
	When I fill value "tag3" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.tag_input" 
	When I fill value "tag4" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.tag_input" 
	When I fill value "tag5" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	When I click "tutorials.add_category_tag_modal.tag_input" 
	When I fill value "tag6" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	Then I should see the error message "Users are allowed to add only 5 labels." 
	
@function
Scenario: add description with more than 600 characters 
	Given I logged in iroad with user "lockedtutorialuser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	And I click "tutorials.delete_category_btn" 
	When I click "tutorials.private_lock_tutorial.checkbox" 
	When I click "tutorials.public_lock_tutorial.checkbox" 
	When I click "tutorials.add_category_or_tag_btn" 
	When I click "tutorials.add_category_tag_modal.description_tab" 
	When I fill value "{s601}" to "tutorials.add_category_tag_modal.description_tab.description_textbox" textbox 
	When I click "tutorials.add_category_tag_modal.tag_apply_button" 
	
@function
Scenario: search tutorials by labels 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn" 
	And Store the text of element "tutorials.first_tutorial.name" in variable "varBefore" 
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "searchlabel1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter 
	Then I should see the message "searchlabel1" 
	# Search for a tutorial
	When I click "xpath=(//*[@title='searchlabel1'])[1]" 
	Then The text of element "tutorials.name_tutorial_label" should be equal value of variable "varBefore" 
	
@function
Scenario: search tutorials by category 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	And Store the text of element "tutorials.first_tutorial.name" in variable "varBefore" 
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown 
	# Search for a tutorial
	When I click "xpath=(//*[@title='cat1'])[1]" 
	Then The text of element "tutorials.name_tutorial_label" should be equal value of variable "varBefore" 
	
Scenario: Unverified user adds labels to multiple tutorials 
	Given I logged in iroad with user "unverifieduser3" and password "validpassword" 
	When I am at "/tutorials"
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.select_all_chk"
	When I click "tutorials.add_category_or_tag_btn" 
	When I click "tutorials.add_category_tag_modal.tag_tab"
	When I fill value "Unverifiedtag" to "tutorials.add_category_tag_modal.tag_input" textbox 
	And I press Enter 
	And I click "tutorials.add_category_tag_modal.tag_apply_button"
	Then I should see the message "Categories/Labels updated" 
	
Scenario: Select all tutorials 
	Given I logged in iroad with user "teamowneruser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	Then The element "tutorials.footer.not_hidden_deselectall" should not be shown 
	When I click "tutorials.select_all_chk" 
	Then The element "tutorials.footer.not_hidden_deselectall" should be shown 
	
Scenario: Show only selected tutorials 
	Given I logged in iroad with user "teamowneruser" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.select_tutorial_chk" 
	Then The element "tutorials.second_select_tutorial_chk" should be shown 
	When I click "tutorials.select_only_selected" 
	Then The element "tutorials.second_select_tutorial_chk" should not be shown 
	Then The element "tutorials.select_tutorial_chk" should be shown 
	
Scenario: Duplicate the Live tutorial when Live tutorial limit reaches 
	Given I logged in iroad with user "yearlyprivateplanuser5" and password "validpassword"  
	When I click "tutorials.my_tutorial_tab"
	When Store the number of element "tutorials.number_tutorial" in variable "before_num_tu_var"
	When I click on "tutorials.first_tutorial.three_dot_icon_by_name" of "Tutorial 1"
	And I click "tutorials.duplicate" 
	Then I should see the message "You are over your live tutorial limit." 
	When Store the number of element "tutorials.number_tutorial" in variable "after_num_tu_var"
	And The variable "before_num_tu_var" should be equal to variable "after_num_tu_var"

Scenario: Change a tutorial into Live tutorial when Live tutorial limit reaches 
	Given I logged in iroad with user "yearlyprivateplanuser5" and password "validpassword"  
	When I click "tutorials.my_tutorial_tab"
	And I search for "Non Live Tutorial" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
	When I click "tutorials.settings.live_tab" 
	And I click "tutorials.settings.live_tab.live_mode_chk" 
	Then I should see the message "You are over your live tutorial limit."  
	
#ref #4491
Scenario: Check if the category added to the only tutorial is removed 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	And Store the text of element "tutorials.first_tutorial.name" in variable "varBefore" 
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown 
	When I click "xpath=(//*[@title='cat1'])[1]" 
	When Store the number of element "tutorials.number_tutorial" in variable "before_num_tu_var"
	Then The variable "before_num_tu_var" should not be equal "0"
	#delete tutorial
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.delete"
	When I click "tutorials.confirm_yes"
	# Search for a tutorial
	Then The element "tutorials.add_category_list" should be shown
	When Store the number of element "tutorials.number_tutorial" in variable "after_num_tu_var"
	Then The variable "after_num_tu_var" should be equal "0" 
	
Scenario: Check if the label added to the only tutorial is removed 
	Given I logged in iroad with user "yearlyprivateplanuser4" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	And Store the text of element "tutorials.first_tutorial.name" in variable "varBefore" 
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter 
	When I click "xpath=(//*[@title='tu1'])[1]" 
	When Store the number of element "tutorials.number_tutorial" in variable "before_num_tu_var"
	Then The variable "before_num_tu_var" should not be equal "0"
	#delete tutorial
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.delete"
	When I click "tutorials.confirm_yes"
	# Search for a tutorial
	When Store the number of element "tutorials.number_tutorial" in variable "after_num_tu_var"
	Then The variable "after_num_tu_var" should be equal "0" 
	
Scenario: Access the Edit category / label page 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	When I click "tutorial.left.edit_category"
	Then The element "tutorial.edit_category_tag.category_tab_active" should be shown
	Then I should see the message "cat1"
	Then The element "xpath=//*[contains(@class,'category_item')]/*[contains(.,'cat1')]/*[text()='1']" should be shown
	#edit tag
	When I click "tutorial.edit_category_tag.tag_tab"
	Then The element "tutorial.edit_category_tag.tag_tab_active" should be shown
	Then I should see the message "tu1"
	Then The element "xpath=//*[contains(@class,'label_item')]/*[contains(.,'tu1')]/*[text()='1']" should be shown

Scenario: Delete a category / label 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tutoriallabel" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	When I click "tutorial.left.edit_category"
	Then The element "tutorial.edit_category_tag.category_tab_active" should be shown
	Then I should see the message "cat1"
	Then The element "xpath=//*[contains(@class,'category_item')]/*[contains(.,'cat1')]/*[text()='1']" should be shown
	When I hover the mouse on the "tutorials.add_category_tag_modal.category_first_item"
	When I click "tutorials.add_category_tag_modal.categories_tab.delete"
	Then The element "tutorials.add_category_tag_modal.categories_tab.undo" should be shown
	Then The element "tutorials.add_category_tag_modal.categories_tab.deleted_label" should be shown
	#verify
	When I click "tutorials.add_category_tag_modal.close_button"
	Then I should see the message "Categories/Tags updated"
	Then I should not see the message "cat1"
	#edit tag
	When I click "tutorial.left.edit_tag"
	Then The element "tutorial.edit_category_tag.tag_tab_active" should be shown
	Then I should see the message "tutoriallabel"
	Then The element "xpath=//*[contains(@class,'label_item')]/*[contains(.,'tutoriallabel')]/*[text()='1']" should be shown 
	When I hover the mouse on the "tutorials.add_category_tag_modal.tag_first_item"
	When I click "tutorials.add_category_tag_modal.tag_tab.delete"
	Then The element "tutorials.add_category_tag_modal.tag_tab.undo" should be shown
	Then The element "tutorials.add_category_tag_modal.tag_tab.deleted_label" should be shown
	#verify
	When I click "tutorials.add_category_tag_modal.close_button"
	Then I should see the message "Categories/Tags updated"
	When I reload page
	Then I should not see the message "tutoriallabel"
	
Scenario: Revert the deleted category / label 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	When I click "tutorial.left.edit_category"
	Then The element "tutorial.edit_category_tag.category_tab_active" should be shown
	Then I should see the message "cat1"
	Then The element "xpath=//*[contains(@class,'category_item')]/*[contains(.,'cat1')]/*[text()='1']" should be shown
	When I hover the mouse on the "tutorials.add_category_tag_modal.category_first_item"
	When I click "tutorials.add_category_tag_modal.categories_tab.delete"
	Then The element "tutorials.add_category_tag_modal.categories_tab.undo" should be shown
	Then The element "tutorials.add_category_tag_modal.categories_tab.deleted_label" should be shown
	#undo
	When I click "tutorials.add_category_tag_modal.categories_tab.undo"
	Then The element "tutorials.add_category_tag_modal.categories_tab.deleted_label" should not be shown
	#edit tag
	When I click "tutorial.edit_category_tag.tag_tab"
	Then The element "tutorial.edit_category_tag.tag_tab_active" should be shown
	Then I should see the message "tu1"
	Then The element "xpath=//*[contains(@class,'label_item')]/*[contains(.,'tu1')]/*[text()='1']" should be shown 
	When I hover the mouse on the "tutorials.add_category_tag_modal.tag_first_item"
	When I click "tutorials.add_category_tag_modal.tag_tab.delete"
	Then The element "tutorials.add_category_tag_modal.tag_tab.undo" should be shown
	Then The element "tutorials.add_category_tag_modal.tag_tab.deleted_label" should be shown
	#undo
	When I click "tutorials.add_category_tag_modal.tag_tab.undo"
	Then The element "tutorials.add_category_tag_modal.tag_tab.deleted_label" should not be shown
	#verify
	When I click "tutorials.add_category_tag_modal.close_button"
	Then I should see the message "cat1"
	Then I should see the message "tu1" 
	
#do not have this function
@wip 
Scenario: Rename the category / label 
	Given I am logged-in as a team member / owner 
	And I am at Categories / Labels tab 
	When I hover a category / label 
	And I click Edit 
	Then I should see two links: Save and Cancel 
	And I rename the category / label 
	And I press Enter or click Save 
	Then I should see Edited and Revert corresponding to it 
	When I click Save button 
	Then I should be redirected to My Tutorials page 
	And The notification "Success." should be shown 
	And The changes should be updated on the left panel 
	
#do not have this function
@wip
Scenario: Rename the category / label into empty name 
	Given I am logged-in as a team member / owner 
	And I am at Categories / Labels tab 
	When I hover a category / label 
	And I click Edit 
	When I remove the existing name and input nothing 
	And I press Enter or click Save 
	Then I should see the notification "The Category / Label should be not empty" 
	
#do not have this function
@wip	
Scenario: Cancel renaming the category / label 
	Given I am logged-in as a team member / owner 
	And I am at Categories / Labels tab 
	When I hover a category / label 
	And I click Edit 
	And I rename the category / label 
	And I click Cancel 
	Then The changes should not be saved 

#do not have this function
@wip		
Scenario: Revert the renamed category / label 
	Given I am logged-in as a team member / owner 
	And I am at Categories / Labels tab 
	When I hover a category / label 
	And I click Edit 
	And I rename the category / label 
	And I press Enter 
	Then I should see Edited and Revert corresponding to it 
	When I click Revert 
	Then The changes should not be saved 
	
Scenario: Add a new valid category / label 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	When I click "tutorial.left.edit_category"
	Then The element "tutorial.edit_category_tag.category_tab_active" should be shown
	And I fill value "newcategory1" to "tutorials.add_category_tag_modal.categories_tab.categories_textbox" textbox 
	And I press Enter 
	Then The element "tutorials.add_category_tag_modal.categories_tab.added_label" should be shown
	#edit tag
	When I click "tutorial.edit_category_tag.tag_tab" 
	And I fill value "newtutorial1" to "tutorials.add_category_tag_modal.tag_tab.tags_textbox" textbox 
	And I press Enter 
	Then The element "tutorials.add_category_tag_modal.tag_tab.added_label" should be shown
	#verify
	When I click "tutorials.add_category_tag_modal.close_button"
	Then I should see the message "Categories/Tags updated"
	Then The element "xpath=(//*[@title='newcategory1'])[1]" should not be shown
	Then The element "xpath=(//*[@title='newtutorial1'])[1]" should not be shown
	When I click "tutorials.add_category_button" 
	When I fill value "newcategory1" to "tutorials.add_category_textbox" textbox 
	And I press Enter 
	When I click "tutorials.add_tag_button"
	When I fill value "newtutorial1" to "tutorials.tag_textbox" textbox
	And I press Enter
	When I click "tutorial.left.edit_category"
	Then The element "xpath=//*[contains(@class,'category_item')]/*[contains(.,'newcategory1')]/*[text()='1']" should be shown
	When I click "tutorial.edit_category_tag.tag_tab" 
	Then The element "xpath=//*[contains(@class,'label_item')]/*[contains(.,'newtutorial1')]/*[text()='1']" should be shown
	
Scenario: Add an empty or space key category/label 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	When I click "tutorial.left.edit_category"
	Then The element "tutorial.edit_category_tag.category_tab_active" should be shown
	And I fill value " " to "tutorials.add_category_tag_modal.categories_tab.categories_textbox" textbox 
	And I press Enter 
	Then The element "tutorials.add_category_tag_modal.categories_tab.added_label" should not be shown
	#edit tag
	When I click "tutorial.edit_category_tag.tag_tab" 
	And I fill value " " to "tutorials.add_category_tag_modal.tag_tab.tags_textbox" textbox 
	And I press Enter 
	Then The element "tutorials.add_category_tag_modal.tag_tab.added_label" should not be shown
	#verify
	When I click "tutorials.add_category_tag_modal.close_button"
	Then I should not see the message "Categories/Tags updated" 
	
Scenario: Add a dupplicated category/label 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	When I click "tutorial.left.edit_category"
	Then The element "tutorial.edit_category_tag.category_tab_active" should be shown
	And I fill value "cat1" to "tutorials.add_category_tag_modal.categories_tab.categories_textbox" textbox 
	And I press Enter 
	Then The element "tutorial.noty.cat_exist" should be shown
	Then The element "tutorials.add_category_tag_modal.categories_tab.added_label" should not be shown
	#edit tag
	When I click "tutorial.edit_category_tag.tag_tab" 
	And I fill value "tu1" to "tutorials.add_category_tag_modal.tag_tab.tags_textbox" textbox 
	And I press Enter 
	Then The element "tutorial.noty.tag_exist" should be shown
	Then The element "tutorials.add_category_tag_modal.tag_tab.added_label" should not be shown
	#verify
	When I click "tutorials.add_category_tag_modal.close_button"
	Then I should not see the message "Categories/Tags updated"
	
Scenario: Delete a newly added category / label 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	When I click "tutorial.left.edit_category"
	Then The element "tutorial.edit_category_tag.category_tab_active" should be shown
	And I fill value "newCategory1" to "tutorials.add_category_tag_modal.categories_tab.categories_textbox" textbox 
	And I press Enter 
	Then The element "tutorials.add_category_tag_modal.categories_tab.added_label" should be shown
	#delete category
	When I hover the mouse on the "tutorials.add_category_tag_modal.categories_tab.added_label"
	When I click "tutorials.delete_category_btn"
	Then The element "tutorials.add_category_tag_modal.categories_tab.added_label" should not be shown
	#edit tag
	When I click "tutorial.edit_category_tag.tag_tab" 
	And I fill value "newTutorial1" to "tutorials.add_category_tag_modal.tag_tab.tags_textbox" textbox 
	And I press Enter 
	Then The element "tutorials.add_category_tag_modal.tag_tab.added_label" should be shown
	#delete tag
	When I hover the mouse on the "tutorials.add_category_tag_modal.tag_tab.added_label"
	When I click "tutorials.remove_tag_button"
	Then The element "tutorials.add_category_tag_modal.tag_tab.added_label" should not be shown
	
#do not have this function
@wip		
Scenario: Close the Edit category or label page without saving with Close link 
	Given I am at Categories / Labels tab 
	And I edit or delete a category / label 
	And I haven't click Save 
	When I click Close 
	Then I should see a notification "You have unsaved changes. If you exit you will lose those changes." 
	And I should see Cancel and Force Close links 
	When I click Cancel 
	Then The Edit category or label page  should not be closed 
	When I click Force Close 
	Then The page should be closed without saving the changes 
	
Scenario: Close the Edit category or label page without changes with Close link 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	When I click "tutorial.left.edit_category"
	#edit tag
	When I click "tutorial.edit_category_tag.tag_tab"
	#verify
	When I click "tutorials.add_category_tag_modal.close_button"
	Then I should not see the message "Categories/Tags updated"
	
#do not have this function
@wip		
Scenario: Close the Edit category or label page without saving with X icon 
	Given I am at Categories / Labels tab 
	And I edit or delete a category / label 
	And I haven't click Save 
	When I click the X icon 
	Then I should not see a notification 
	And I should be redirected to My Tutorials page 
	And The changes should not be saved 
	
Scenario: Open/ Close the left menu on the Edit category/labels page 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_category_btn" 
	When Clear all category and label base on element "tutorials.first_tutorial.delete_tag_btn"
	#add category
	When I click "tutorials.first_tutorial.add_category_btn" 
	When I fill value "cat1" to "tutorials.first_tutorial.add_category_txt" textbox 
	And I press Enter  
	Then The element "tutorials.add_category_list" should be shown
	#add tag
	When I click "tutorials.first_tutorial.add_tag_btn" 
	When I fill value "tu1" to "tutorials.first_tutorial.add_tag_txt" textbox 
	And I press Enter
	#edit category
	Then The element "left_menu.x_icon" should not be shown
	When I click "tutorial.left.edit_category"
	#verify
	When I click "left_menu.left_menu_icon"
	When I click "tutorials.add_category_tag_modal.close_button"
	Then The element "left_menu.x_icon" should be shown
	
Scenario: Disable  a tutorial 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.first_tutorial.switch_wrapper_on_btn"
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.setting" 
	When Switch to "tutorials.iorad_app_iframe" frame
	When Switch to "tutorials.settings.preview_tutorial_frame" frame
	Then I should see the notification "This tutorial is currently disabled and is visible only to you" 
	When I click "tutorials.settings.noty.enable_btn" 
	Then Switch back to main frame
	Then I should be redirected to My tutorials tab 
	When I click "tutorials.first_tutorial.switch_wrapper_off_btn" 
	
Scenario: Enable a tutorial 
	Given I logged in iroad with user "yearlyprivateplanuser6" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.first_tutorial.switch_wrapper_on_btn"
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.setting" 
	When Switch to "tutorials.iorad_app_iframe" frame
	When Switch to "tutorials.settings.preview_tutorial_frame" frame
	Then I should see the notification "This tutorial is currently disabled and is visible only to you" 
	When I click "tutorials.settings.noty.enable_btn" 
	Then Switch back to main frame
	Then I should be redirected to My tutorials tab 
	When I click "tutorials.first_tutorial.switch_wrapper_off_btn"
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.setting" 
	When Switch to "tutorials.iorad_app_iframe" frame
	When Switch to "tutorials.settings.preview_tutorial_frame" frame
	Then I should not see the notification "This tutorial is currently disabled and is visible only to you"
	
Scenario: Free user duplicates a premium tutorial when the limit reaches 
	Given I logged in iroad with user "freeplanuser2" and password "validpassword" 
	When I click "tutorials.my_tutorial_tab" 
	When I click "tutorials.three_dot_icon" 
	When I click "tutorials.duplicate" 
	Then I should see the notification "This tutorial has premium features and can't be copied"
	When I click "tutorials.noty.upgrade_link"
	Then I should see the pricing page content
	
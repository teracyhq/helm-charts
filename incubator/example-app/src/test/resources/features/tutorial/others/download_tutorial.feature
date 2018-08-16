@test7 
Feature: HTML Download Special Pricing 

	As a user
    I want to download my tutorials as HTML or
    so I have to pay more for that.

@function
Scenario: Free user downloads tutorial 
	Given I log in as a free user 
	And I am at My tutorials page 
	When I click "tutorials.three_dot_icon" 
	Then I should not see the "tutorials.download" item 
	
@function 
Scenario: Premium user downloads tutorial as HTML Zip 
	Given I logged in iroad with user "monthlypremiumplanuser5" and password "validpassword"
	And I am at My tutorials page 
	When Store the text "Tutorial-Custom-Theme-2_html" in variable "html_file_name_var"
	When I click "tutorials.three_dot_icon" 
	When I click by javascript "tutorials.download" 
	Then I should be redirected to the Download page 
	Then I should see the "tutorials.download.html_package_button" item 
	Then I should see the "tutorials.download.scorm_button" item 
	Then I should see the "tutorials.download.close_button" item 
	When I click "tutorials.download.html_package_button" 
	And wait for 2 seconds
	Then File zip "html_file_name_var" should exists
	
Scenario: Premium user downloads tutorial as SCROM 1.2 
	Given I logged in iroad with user "monthlypremiumplanuser5" and password "validpassword"
	And I am at My tutorials page 
	When Store the text "Tutorial-Custom-Theme-2_scorm" in variable "scrom_file_name_var"
	When I click "tutorials.three_dot_icon" 
	When I click by javascript "tutorials.download" 
	Then I should be redirected to the Download page 
	Then I should see the "tutorials.download.html_package_button" item 
	Then I should see the "tutorials.download.scorm_button" item 
	Then I should see the "tutorials.download.close_button" item 
	When I click "tutorials.download.scorm_button" 
	And wait for 2 seconds
	Then File zip "scrom_file_name_var" should exists
	
@function
Scenario: Cancel downloading with Close/X button or press Esc on keyboard 
	Given I logged in iroad with user "monthlypremiumplanuser5" and password "validpassword"
	And I am at My tutorials page 
	When I click "tutorials.three_dot_icon" 
	When I click by javascript "tutorials.download" 
	Then I click "tutorials.download.close_button" 
	And I should be redirected to the My Tutorials	
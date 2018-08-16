@test6 
Feature: Adding audio for tutorials. IE11 is not supported recording. 

	As a paid user
    I want to add audio for my tutorials
    so I can explain more for each step.
    
Background: 
	Given I logged in iroad with user "audiouser1" and password "audiopassword1" 
	
@smoke
Scenario: Open the Audio Editor form 
	When I click "tutorials.my_tutorial_tab" 
	Then I should be redirected to My tutorials tab 
	And I click "tutorials.edit_icon" 
	Then I should be redirected to the Editor page to edit that tutorial 
	Then I open the Audio Editor form 
	And I should see the number of steps of the tutorial
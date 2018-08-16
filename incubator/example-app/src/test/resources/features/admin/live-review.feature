@wip 
Feature: Admin reviews the pending tutorials captured with the iorad extension by free users 

	As an admin,
    I can review all the pending tutorials captured with the iorad extension by free users
    so that I can approve or reject them to show or hide on the extension panel.

Scenario: Free tutorial named "Untitled" should not be shown in Live Review 
	Given Free user captures a tutorial with the iorad extension 
	And The tutorial still has the default name 'Untitled' 
	When I am logged-in as admin 
	And I go to Live Review page 
	Then I should not see the tutorial in the Live Review page 
	
Scenario: Free tutorial changed the name should be shown in Live Review 
	Given Free user captures a tutorial with the iorad extension 
	And The free user has changed the default name of the tutorial 
	When I am logged-in as admin 
	And I go to Live Review page 
	Then I should see the tutorial in the Live Review page 
	When I click the tutorial title 
	Then The tutorial player should be opened in a new tab 
	
Scenario: Admin approves the pending tutorial in the Live Review page 
	Given There are some pending tutorials in the Live Review page 
	And I am logged-in as admin 
	When I go to the Live Review page 
	And I click Approve corresponding to a pending tutorial 
	And I click Approve in the confirmation pop-up 
	Then The pop-up should be closed 
	And The tutorial should be moved to the Approved Tutorials tab 
	And The tutorial owner should see an notification email about the tutorial approval 
	And The tutorial should be shown in the Extension panel of the site 
	
Scenario: Cancel approving the pending tutorial in the Live Review page 
	Given There are some pending tutorials in the Live Preview page 
	And I am logged-in as admin 
	When I go to the Live Review page 
	And I click Approve corresponding to a pending tutorial 
	And I click Cancel in the confirmation pop-up 
	Then The pop-up should be closed 
	And The tutorial should be kept in the Live Review page 
	
Scenario: Admin rejects the pending tutorial in the Live Review page 
	Given There are some pending tutorials in the Live Review page 
	And I am logged-in as admin 
	When I go to the Live Review page 
	And I click Reject corresponding to a pending tutorial 
	And I click Reject in the confirmation pop-up 
	Then The pop-up should be closed 
	And The tutorial should be moved to the Rejected Tutorials tab 
	And The tutorial owner should see an notification email about the tutorial Rejection 
	And No one should see the tutorial in the Extension panel of the site 
	
Scenario: Cancel rejecting the pending tutorial in the Live Review page 
	Given There are some pending tutorials in the Live Review page 
	And I am logged-in as admin 
	When I go to the Live Review page 
	And I click Reject corresponding to a pending tutorial 
	And I click Cancel in the confirmation pop-up 
	Then The pop-up should be closed 
	And The tutorial should be kept in the Live Review page 
	
Scenario: Admin approves a pending tutorial in the Rejected Tutorials tab 
	Given I am logged-in as admin 
	And I rejected some tutorials 
	When I go to the Rejected Tutorials tab 
	Then I should see a list of rejected tutorials 
	And I click Approve corresponding to a tutorial 
	And I click Approve in the confirmation pop-up 
	Then The pop-up should be closed 
	And The tutorial should be moved to the Approved Tutorials tab 
	And The tutorial owner should see an notification email about the tutorial approval 
	And The tutorial should be shown in the Extension panel of the site 
	
Scenario: Cancel approving a pending tutorial in the Rejected Tutorials tab 
	Given I am logged-in as admin 
	And I rejected some tutorials 
	When I go to the Rejected Tutorials tab 
	Then I should see a list of rejected tutorials 
	And I click Approve corresponding to a tutorial 
	And I click Cancel in the confirmation pop-up 
	Then The pop-up should be closed 
	And The tutorial should be kept in the Rejected Tutorials tab 
	
	
Scenario: Admin rejects the pending tutorial in the Approved Tutorials page 
	Given There are some approved tutorials in the Live Review page 
	And I am logged-in as admin 
	When I go to the Approved Tutorials page 
	And I click Reject corresponding to a tutorial 
	And I click Reject in the confirmation pop-up 
	Then The pop-up should be closed 
	And The tutorial should be moved to the Rejected Tutorials tab 
	And The tutorial owner should see an notification email about the tutorial Rejection 
	And No one should see the tutorial in the Extension panel of the site anymore 
	
Scenario: Cancel rejecting the pending tutorial in the Approved Tutorials page 
	Given There are some approved tutorials in the Approved Tutorials page 
	And I am logged-in as admin 
	When I go to the Approved Tutorials page 
	And I click Reject corresponding to a tutorial 
	And I click Canel in the confirmation pop-up 
	Then The pop-up should be closed 
	And The tutorial should ne kept at the Approved Tutorials page
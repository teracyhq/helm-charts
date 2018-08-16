@test6
Feature: Manage your team 

	As a team owner,
    I want to access the Creators page
    so that I could invite or remove members from my team.
	
@smoke 
Scenario: Access the Creators page when having creators in the team 
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	Then I should see the Creators page content 
	And The element "creators.active_creator_tab" should be shown 
	And The "creators.invite_button" should be enabled 
	And The element "creators.number_invite_creators" should be shown
	When I click "creators.invitation_tab" 
	Then I should navigate to the Invitations tab 
	
@smoke 
Scenario: Access the Creators page when the team is full 
	Given I logged in iroad with user "teamowneruser4" and password "validpassword" 
	When I am at the Creators page 
	Then I should see the Creators page content 
	And The element "creators.active_creator_tab" should be shown 
	And The "creators.invite_button" should be disabled 
	And The element "creators.number_invite_creators" should be shown 
	When I click "creators.invitation_tab" 
	Then The element "creators.invite_placeholder" should not be shown
	And The element "creators.invitation_tab.upload_csv_link" should not be shown 
	And The "creators.send_invite_button" should be disabled
	When I click "creators.invitaion_tab.get_more_link" 
	Then The element "my_plan.current_my_plan_tab" should be shown 
	
@smoke 
Scenario: invite a valid email 
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	When I click "creators.invitation_tab"
	And Store the number in the text of element "creators.invitation_remaining" in variable "oldremaining" 
	And The element "creators.invite_placeholder" should be shown 
	And The "creators.send_invite_button" should be disabled 
	When I fill value "teammemberuser6" to "creators.invite_placeholder" textbox 
	When I press Enter 
	When I click "creators.send_invite_button" 
	And Store the number in the text of element "creators.invitation_remaining" in variable "newremaining" 
	Then The variable "newremaining" should be smaller than variable "oldremaining" 
	And I hover the mouse on the "creators.email_pending" 
	And The element "creators.delete_pending_invitation" should be shown 
	When Open gmail with user "teammemberuser6" and password "googlefreeverifieduserpass" 
	Then The element "creators.join_button" should be shown in gmail 
	
@smoke 
Scenario: Access the Creators page when having no creators in the team yet 
	Given I logged in iroad with user "teamowneruser3" and password "validpassword" 
	When I am at the Creators page 
	Then I should see the Creators page content 
	And The element "creators.creator_tab" should not be shown 
	And The element "creators.invitation_tab" should be shown 
	And The element "creators.invitation_remaining" should be shown 
	And The element "creators.invitaion_email_pending" should be shown 
	And The "creators.send_invite_0_button" should be disabled 
	
@wip
Scenario: upload .csv file containing the allowed number of valid emails 
	Given I am at the Invitations tab 
	And The invitation left is greater than 0 
	When I click the link "Upload CSV" 
	And I browse a .csv file containg the allowed number of vaid emails 
	Then All the emails in the .csv file should be listed in the pending email list 
	And The "Send Invite to ..." should be enabled 
	When I click the "Send Invite to ..." 
	Then The red loader bar on the top of the page should be shown 
	And I should see the success notification 
	And The Pending label should be shown corresponding to each newly invited email 

@wip	
Scenario: Upload invalid file 
	Given I am at the Invitations tab 
	And The invitation left is greater than 0 
	When I click the link "Upload CSV" 
	And I browse an invalid file (e.g, .doc) 
	And I click the "Send Invite to ..." 
	Then The notification "File type not supported" should be shown 
	
@wip	
Scenario: Upload .csv file having more emails than the limit 
	Given I am at the Invitations tab 
	And The invitation left is greater than 0 
	When I click the link "Upload CSV" 
	And I browse a .csv file which has more the emails than the limit 
	And I click the "Send Invite to ..." 
	Then The notification "Unable to send invitation: Sorry, you've exceeded your maximum number of team members." should be shown 
	
@wip
Scenario: Upload .csv file having invalid emails 
	Given I am at the Invitations tab 
	And The invitation left is greater than 0 
	When I click the link "Upload CSV" 
	And I browse a .csv file which has invalid emails 
	And I click the "Send Invite to ..." 
	Then The notification " Could not find any new email in this file" should be shown 
	
@function
Scenario: invite more users than your team member 
	Given I logged in iroad with user "teamowneruser5" and password "validpassword" 
	When I am at the Creators page 
	And The element "creators.creator_tab" should not be shown 
	And The element "creators.creator_tab.upload_csv_link" should not be shown 
	And The element "creators.invite_placeholder" should not be shown 
	When I click "creators.invitaion_tab.get_more_link" 
	Then The element "my_plan.current_my_plan_tab" should be shown 
         
@function 
Scenario: remove input email 
	Given I logged in iroad with user "teamowneruser3" and password "validpassword" 
	When I am at the Creators page 
	Then I should be reditected to the "Invite Team Members" page 
	When I fill value "googleunverifieduser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	And I hover the mouse on the "creators.email_pending" 
	And I click "creators.delete_pending_invitation" 
	Then I should not see the message "googleunverifieduser" 
	
@function 
Scenario: invite an invalid email 
	Given I logged in iroad with user "teamowneruser3" and password "validpassword" 
	When I am at the Creators page 
	Then I should be reditected to the "Invite Team Members" page 
	When I fill value "invalid_email.com" to "creators.invite_placeholder" textbox 
	And I press Enter 
	Then I should see the message "Please enter a valid email address" 
	
@function 
Scenario Outline: invite a pending email 
	Given I logged in iroad with user "teamowneruser3" and password "validpassword" 
	# Invite an user first
	When I am at the Creators page 
	When I fill value "<Email>" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	# Re-invite the pending email
	When I am at the Creators page 
	Then I should be reditected to the "Invite Team Members" page 
	When I click "creators.invite_placeholder" 
	#Then The pending email "<Email>" should not be shown on the auto-sugesstion list
	When I fill value "<Email>" to "creators.invite_placeholder" textbox 
	And I press Enter 
	Then I should see the message "Invitation to this email address has already been sent" 
	
	Examples: 
		| Email                |
		| gmailunregisteruser1 |
		
@function 
Scenario: invite an email of a team member 
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	When I click "creators.invitation_tab"
	When I fill value "teammemberuser3" to "creators.invite_placeholder" textbox
	And I press Enter
	Then I should see the message "iorad.teammemberuser+demo3@gmail.com is already on your team. No need to add them twice."
	
@function 
Scenario: send the email to the team owner 
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	When I click "creators.invitation_tab"
	When I fill value "teamowneruser2" to "creators.invite_placeholder" textbox
	And I press Enter
	Then I should see the message "You cannot send an invite to yourself" 
	
@function 
Scenario Outline: invite user who has had plan 
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	Then I click "creators.invitation_tab" 
	Then I should be reditected to the "Invite Team Members" page 
	When I fill value "<Email>" to "creators.invite_placeholder" textbox 
	And I press Enter 
	And I click "creators.send_invite_button" 
	Then I should see the message "<Message>" 
	
	Examples: 
		| Email                            | Message                                                                                           |
		| iorad.subindiplanuser1@gmail.com | Unable to send invitation: iorad.subindiplanuser1@gmail.com is already subscribed to another plan |
		
@wip @function 
Scenario: invite both valid emails and invalid emails subscrbing the premium plan 
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	Then I click "creators.invitation_tab" 
	Then I should be reditected to the "Invite Team Members" page 
	When I fill value "iorad.subindiplanuser1@gmail.com" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I fill value "iorad.unverifieduser2@gmail.com" to "creators.invite_placeholder" textbox 
	And I press Enter 
	And I click "creators.send_invite_button" 
	Then I should see the message "Unable to send invitation: iorad.subindiplanuser1@gmail.com is already subscribed to another plan" 
	When Open gmail with user "iorad.unverifieduser2@gmail.com" and password "iorad@123" 
	Then The first email title contains message "You have been invited to join iorad.teamowneruser+demo2@gmail.com's team on iorad" 
	And The first email title contains message "iorad.unverifieduser2@gmail.com" 
	
@function 
Scenario: cancel inviting people 
	Given I logged in iroad with user "teamowneruser6" and password "validpassword" 
	When I am at the Creators page 
	Then I click "creators.invitation_tab" 
	Then I should be reditected to the "Invite Team Members" page 
	Then The "creators.send_invite_button" should be disabled 
	When I fill value "teammemberuser7" to "creators.invite_placeholder" textbox 
	And I press Enter 
	Then The "creators.send_invite_button" should be enabled 
	When I click on the "left_menu.tutorials" button from the slide out menu 
	And I am at the Creators page 
	Then I click "creators.invitation_tab" 
	Then I should see the message "teammemberuser7"
	Then The "creators.send_invite_button" should be enabled 

@function 
Scenario: delete a pending email 
# Invite a team member first
	Given I logged in iroad with user "teamowneruser6" and password "validpassword" 
	When I am at the Creators page 
	Then I click "creators.invitation_tab" 
	Then I should be reditected to the "Invite Team Members" page 
	When I fill value "teammemberuser8" to "creators.invite_placeholder" textbox 
	And I press Enter 
	And I click "creators.send_invite_button" 
	And I hover the mouse on the "creators.email_pending" 
	And I click "creators.delete_pending_invitation" 
	And I click "creators.confirm_delete_button" 
	Then I should not see the message "teammemberuser8" 

@function 
Scenario: cancel deleting pending email 
# Invite a team member first
	Given I logged in iroad with user "teamowneruser6" and password "validpassword" 
	When I am at the Creators page 
	Then I click "creators.invitation_tab" 
	Then I should be reditected to the "Invite Team Members" page 
	When I fill value "teammemberuser8" to "creators.invite_placeholder" textbox 
	And I press Enter 
	And I click "creators.send_invite_button" 
	And I hover the mouse on the "creators.email_pending" 
	And I click "creators.delete_pending_invitation" 
	And I click "creators.confirm_cancel_button" 
	Then I should see the message "teammemberuser8" 
	Then I should be reditected to the "Invite Team Members" page 

@function 
Scenario: resend pending email 
# Using team owner 2 to invite a team member first
	Given I logged in iroad with user "teamowneruser6" and password "validpassword" 
	When I am at the Creators page 
	Then I click "creators.invitation_tab" 
	And I fill value "teammemberuser7" to "creators.invite_placeholder" textbox 
	And I press Enter 
	And I click "creators.send_invite_button" 
	# Check the invitation email then clear inbox
	When I open a new tab 
	And Open gmail with user "teammemberuser7" and password "validpassword" 
	Then I should see the message "You have been invited to join iorad.teamowneruser+demo6@gmail.com's team on iorad" 
	And I should see the message "teammemberuser7" 
	And I clear email inbox 
	# Resend the invitation
	When I switch to "Creators" window 
	And I am at the Creators page 
	And I click "creators.invitation_tab" 
	And I should see the message "teammemberuser7" 
	When I hover the mouse on the "creators.email_pending" 
	When I click "creators.resend_pending_email" 
	Then I click "creators.confirm_resend_button" 
	When Open gmail with user "teammemberuser7" and password "validpassword" 
	Then I should see the message "You have been invited to join iorad.teamowneruser+demo6@gmail.com's team on iorad" 
	And I should see the message "teammemberuser7" 

#And All tutorials and theme created by the member should be transferred to the team owner
@function 
Scenario: cancel deleting a team member 
# Using team owner 2 to invite a team member first
	Given I logged in iroad with user "teamowneruser7" and password "validpassword" 
	When I am at the Creators page 
	And I click "creators.creator_tab" 
	And I should see the message "teammemberuser9" 
	When I hover the mouse on the "creators.img_creator" 
	When I click "creators.remove_creator" 
	Then I should be redirected to the remove Creators "teammemberuser9" confirmation page 
	When I click "creators.confirm_keep_button" 
	Then I should be back to the Creators page 
	And I should see the message "teammemberuser9" 
	
@function 
Scenario: delete a team member 
# Using team owner 2 to invite a team member first
	Given I logged in iroad with user "teamowneruser7" and password "validpassword" 
	When I am at the Creators page 
	And I click "creators.creator_tab" 
	And I should see the message "teammemberuser9" 
	When I hover the mouse on the "creators.img_creator" 
	Then The "creators.remove_creator" should be visible 
	When I click "creators.remove_creator" 
	Then I should be redirected to the remove Creators "teammemberuser9" confirmation page 
	When I click "creators.confirm_remove_button" 
	Then I should see the message "Status: Creator was removed" 
	And I should not see the message "teammemberuser9" 
	
Scenario: set a member as admin 
	#verify status before set as admin
	Given I logged in iroad with user "teammemberuser3" and password "validpassword"
	When I click on the "left_menu.tutorials" on the left panel 
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab
	And I should not see the message "share creator tutorial"
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	#set as admin
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	And I click "creators.creator_tab" 
	And I should see the message "teammemberuser3" 
	When I hover the mouse on the "creators.img_creator" 
	When I click by javascript "creators.creator_tab.set_as_admin"
	When I hover the mouse on the "creators.img_creator"
	And The element "creators.creator_tab.remove_admin" should be shown
	#verify status after set as admin
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	Given I logged in iroad with user "teammemberuser3" and password "validpassword"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab
	And I should see the message "share creator tutorial"

Scenario: Remove admin 
	#verify status before remove admin
	Given I logged in iroad with user "teammemberuser3" and password "validpassword"
	When I click on the "left_menu.tutorials" on the left panel 
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab
	And I should see the message "share creator tutorial"
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	#remove admin
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	And I click "creators.creator_tab" 
	And I should see the message "teammemberuser3" 
	When I hover the mouse on the "creators.img_creator" 
	When I click by javascript "creators.creator_tab.remove_admin"
	When I hover the mouse on the "creators.img_creator"
	And The element "creators.creator_tab.set_as_admin" should be shown
	#verify status after remove admin
	When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
	Given I logged in iroad with user "teammemberuser3" and password "validpassword"
	When I click on the "left_menu.tutorials" on the left panel
	When I click "tutorials.share_edit_tab" 
	Then I should be redirected to Shared Edit tab
	And I should not see the message "share creator tutorial"
	
@wip
Scenario: team admin invites /remove creator 
	Given I logged in iroad with user "teamowneruser2" and password "validpassword" 
	When I am at the Creators page 
	Then I should be able to add/ remove creators for my team 
	
@wip
Scenario: Chek the Get More link on the Creators page of member admin 
	Given I logged in as a member 
	And I set as admin for my team 
	And The creator limit reaches 
	When I access the Creators page 
	#@wip https://github.com/iorad/iorad/issues/3979 
	Then  The link "Get More" should be disabled / hidden 
	
@wip
Scenario: The Edit right should be shown for the member admin in Share page 
	Given  I logged-in as a member admin 
	And  My team has 2 admins 
	And  The admins have created some tutorial 
	Then  The tutorials created by other admins should be listed in the Shared Edit page 
	When  I go to the Shared Edit page 
	And  I access the Share page 
	And  I navigate the Assign tab 
	Then  I should see the emails of team owner and other admins set the Edit right 
	And  I should not able to remove their email 
	
@wip
Scenario: Send the access invite to the team owner and admin 
	Given  I logged-in as a member admin 
	And  My team has 2 admins 
	And  The admins have created some tutorial 
	Then  The tutorials created by other admins should be listed in the Shared Edit page 
	When  I go to the Shared Edit page 
	And  I access the Share page 
	And  I navigate to the Invite tab 
	When  I input the email of the team owner or other member admin 
	Then  I should see the error notification 
	
@wip
Scenario: Team admin edits the tutorial 
	Given  I am a team admin 
	And  There are some tutorials created in my team 
	When  I access the Shared Edit page 
	Then  I should be able to edit the tutorials listed in the Shared Edit page 

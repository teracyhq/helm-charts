@test4 
Feature: Invitee accepts the invitation to join the team or member leaves from the team 

	As an invitee,
    I want to receive the invitation email
    so that I can join the team and create private tutorials and use the features of a premium plan

@smoke 
Scenario: Invitee has no iorad account (1) 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I remove the creator "gmailunregisteruser1" 
	And I am at the Invite Creators tab 
	When I fill value "gmailunregisteruser1" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When Open gmail with user "gmailunregisteruser1" and password "gmailunregisterpass1" 
	And I close other tabs 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the sign up page content 
	When I fill value "validpublicname" to "signup.public_name" textbox 
	When I fill value "validpassword" to "signup.password" textbox 
	When I click "signup.terms" 
	Then The "signup.signup_button" should be enabled 
	When I click "signup.signup_button" 
	Then I should see the My tutorials page content 
	Then I should see the message "Congrats. Welcome to Team Owner 1's team." 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I am at the Creators page 
	Then The element "creators.img_creator" should be shown 
	
@smoke 
Scenario: Invitee has not logged in (2) 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I remove the creator "googlefreeverifieduseruser" 
	And I am at the Invite Creators tab 
	When I fill value "googlefreeverifieduseruser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When Open gmail with user "googlefreeverifieduseruser" and password "googlefreeverifieduserpass" 
	And I close other tabs 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the Log in tab content 
	When I fill value "validpassword" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the My tutorials page content 
	Then I should see the message "Congrats. Welcome to Team Owner 1's team." 
	#And I should become a member of the team
	#And I should see the tutorials created by all the team members in the My Learning tab
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I am at the Creators page 
	Then The element "creators.img_creator" should be shown 
	
@smoke 
Scenario: Invitee already logged in (3) 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I remove the creator "googlefreeverifieduseruser" 
	And I am at the Invite Creators tab 
	When I fill value "googlefreeverifieduseruser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "googlefreeverifieduseruser" and password "validpassword" 
	When Open gmail with user "googlefreeverifieduseruser" and password "googlefreeverifieduserpass" 
	And I close other tabs 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the My tutorials page content 
	Then I should see the message "Congrats. Welcome to Team Owner 1's team." 
	#And I should become a member of the team
	#And I should see the tutorials created by all the team members in the My Learning tab
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I am at the Creators page 
	Then The element "creators.img_creator" should be shown 
	
@smoke 
Scenario: Invitee has unverified account (4) 
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I remove the creator "googleunverifieduser" 
	And I am at the Invite Creators tab 
	When I fill value "googleunverifieduser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When Open gmail with user "googleunverifieduser" and password "googleunverifiedpass" 
	And I close other tabs 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the Log in tab content 
	When I fill value "validpassword" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the My tutorials page content 
	Then I should see the message "Congrats. Welcome to Team Owner 1's team." 
	#And I should become a member of the team
	#And I should see the tutorials created by all the team members in the My Learning tab
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	When I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When I am at the Creators page 
	Then The element "creators.img_creator" should be shown 
	
@regression @function 
Scenario: Invitee already deleted account (5) 
	Given I already deleted my iorad account 
	When I open my email invitation 
	And I click the link in the email 
	Then I should be redirected to the Sign Up page 
	When I sign up successfully 
	Given I am logged in as as an unverified invited account 
	When I open the invitation email 
	And I click the link in the email 
	Then I should be redirected to the Thank you page: "You are now apart of {team owner}'s Premium Private Team Plan. " 
	And I should see the "How iorad works" link that points to "https://www.iorad.com/127/4504/7-STEPS-TO-FREEDOM---the-iorad-way---" in a new tab 
	And I should see "New Tutorial" button that points to the Download/Connecting page 
	And I should be a member of the team 
	And I should see the tutorials created by the team owner 
	And The team owner should see me in the list of his current team members 
	And My account should be verified 
	
@low_priority @function 
Scenario: Check the used invitation link 
# Using team owner 1 to invite a team member first
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When Clear creators data 
	When I am at the Creators page 
	When I fill value "googleunverifieduser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	# The team member accepts the invitation via Email
	When Open gmail with user "googleunverifieduser" and password "googleunverifiedpass" 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the Log in tab content 
	When I fill value "validpassword" to "login.password" textbox 
	And I click "login.login_button" 
	#Then I should see the My tutorials page content
	And I should see the message "Congrats. Welcome to Team Owner 1's team." 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	# The team member accepts the invitation again
	Then Open gmail with user "googleunverifieduser" and password "googleunverifiedpass" again 
	And I close other tabs 
	And The element "creators.join_button" should be shown in gmail 
	And I click "creators.join_button" 
	And I switch to "iorad" window 
	When I fill value "validpassword" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should be redirected to the "/siteError?errormsg=You%20can%27t%20accept%20invite%20while%20already%20premium&status=500" page 
	And I should see the message "Oops..." 
	And I should see the message "Something went wrong" 
	And I should see the message "You can't accept invite while already premium" 
	
@low_priority @function 
Scenario: Check the expired invitation link 
# Using team owner 1 to invite a team member first
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When Clear creators data 
	When I am at the Creators page 
	When I fill value "googleunverifieduser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	# Delete the invitation from the pending email list
	And Clear creators data 
	# The team member accepts the invitation again
	Then Open gmail with user "googleunverifieduser" and password "googleunverifiedpass" again 
	And I close other tabs 
	And The element "creators.join_button" should be shown in gmail 
	And I click "creators.join_button" 
	And I switch to "iorad" window 
	Then I should be redirected to the "/siteError?errormsg=This%20invitation%20link%20is%20no%20longer%20valid.&status=500&backTo=tutorials" page 
	And I should see the message "Oops..." 
	And I should see the message "Something went wrong" 
	And I should see the message "This invitation link is no longer valid." 
	
@function 
Scenario: leave from the team with valid password 
# Using team owner 1 to invite a member
	Given I logged in iroad with user "teamowneruser" and password "validpassword" 
	When Clear creators data 
	When I am at the Creators page 
	When I fill value "googleunverifieduser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	# Accept the invitation
	When Open gmail with user "googleunverifieduser" and password "validpassword" 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the Log in tab content 
	When I fill value "validpassword" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the My tutorials page content 
	Then I should see the message "Congrats. Welcome to team owner 2's team." 
	# Leave the team with valid password
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.leave_the_team_button" 
	Then I should be redirected to the leave team confirmation page 
	When I fill value "validpassword" to "my_account.confirm_password" textbox 
	And I click "my_account.agree_button" 
	And I click "my_account.x_icon" 
	Then I should be redirected to the "/tutorials" page 
	And I should see the message "You are now on the free plan and on your own." 
	And All tutorials in "tutorials.my_tutorial_tab" tab should be removed 
	#And All tutorials in "tutorials.share_edit_tab" tab should be removed
	
	#Then I should be redirected to My tutorials page with the notification "You are now on the free plan and on your own."
	#And All my tutorials should be transferred to the team owner
	#And All tutorials of the members in My Learning tab should be removed
	#And All tutorials in Shared Edit tab if any should be removed
	
@function 
Scenario: leave from the team with invalid password 
# Using team owner 1 to invite a member
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When Clear creators data 
	When I am at the Creators page 
	When I fill value "googleunverifieduser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	# Accept the invitation
	When Open gmail with user "googleunverifieduser" and password "googleunverifiedpass" 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the Log in tab content 
	When I fill value "validpassword" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the My tutorials page content 
	Then I should see the message "Congrats. Welcome to Team Owner 1's team." 
	# Try to leave the team with invalid password
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.leave_the_team_button" 
	Then I should be redirected to the leave team confirmation page 
	When I fill value "incorect_pass" to "my_account.confirm_password" textbox 
	And I click "my_account.agree_button" 
	Then I should see the error message "Password incorrect." 
	
@function 
Scenario: leave from the team with empty password 
# Using team owner 1 to invite a member
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When Clear creators data 
	When I am at the Creators page 
	When I fill value "googleunverifieduser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	# Accept the invitation
	When Open gmail with user "googleunverifieduser" and password "googleunverifiedpass" 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the Log in tab content 
	When I fill value "validpassword" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the My tutorials page content 
	Then I should see the message "Congrats. Welcome to Team Owner 1's team." 
	# Try to leave the team with empty password
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.leave_the_team_button" 
	Then I should be redirected to the leave team confirmation page 
	When I fill value " " to "my_account.confirm_password" textbox 
	And I click "my_account.agree_button" 
	Then I should see the message "Password incorrect." 
	
@function 
Scenario: cancel leaving from the team 
# Using team owner 1 to invite a member
	Given I logged in iroad with user "teamowneruser1" and password "validpassword" 
	When Clear creators data 
	When I am at the Creators page 
	When I fill value "googleunverifieduser" to "creators.invite_placeholder" textbox 
	And I press Enter 
	When I click "creators.send_invite_button" 
	When I click on the "left_menu.logout" button from the slide out menu 
	Then I should be logged out and redirected to the home page 
	# Accept the invitation
	When Open gmail with user "googleunverifieduser" and password "googleunverifiedpass" 
	Then The element "creators.join_button" should be shown in gmail 
	When I click "creators.join_button" and switch to the second tab 
	Then I should see the Log in tab content 
	When I fill value "validpassword" to "login.password" textbox 
	And I click "login.login_button" 
	Then I should see the My tutorials page content 
	Then I should see the message "Congrats. Welcome to Team Owner 1's team." 
	# Leave the team then Cancel leaving
	When I click on the "left_menu.account" on the left panel 
	Then I should be redirected to the "/account" page 
	When I click "my_plan.leave_the_team_button" 
	Then I should be redirected to the leave team confirmation page 
	When I fill value "incorect_pass" to "my_account.confirm_password" textbox 
	And I click "my_account.agree_button" 
	And I click "my_account.cancel_button" 
	Then I should not see the message "Are you sure you want to leave the team?" 
	# Check the placeholder
	And I should be back to the "/account" page 
	When I click "my_plan.leave_the_team_button" 
	Then The element "my_account.confirm_password" should be shown 
    
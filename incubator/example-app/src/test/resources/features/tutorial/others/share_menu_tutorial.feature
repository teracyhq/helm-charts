@test5 @function
Feature: Share menu of a tutorial
  
    As a logged-in user, 
    I want to access Share menu or share otpion at the footer
    so that I can share my tutorials with many different ways.
    
   
  Scenario: Access the Share menu page
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At Share tutorial popup
    And The "tutorials.share_tutorial_popup_header" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    # Focus at the Link tab
    And The "tutorials.tab_share_tutorial_pane_link" should be visible
    # See 4 tabs
    And The "tutorials.tab_share_tutorial_tab_link" should be visible
    And The "tutorials.tab_share_tutorial_tab_embed" should be visible
    And The "tutorials.tab_share_tutorial_tab_assign" should be visible
    And The "tutorials.tab_share_tutorial_tab_invite" should be visible
    # And Close button
    And The "tutorials.tab_share_tutorial_tab_close" should be visible

  Scenario: Copy links in the Link tab
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At Share tutorial popup
    Then The "tutorials.share_tutorial_popup_header" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    # Focus at the Link tab
    And The "tutorials.tab_share_tutorial_pane_link" should be visible
    When I click "tutorials.tab_share_tutorial_short_link_copy_btn"
    Then I should see the message "Short link copied to your clipboard"
    When I click "tutorials.tab_share_tutorial_live_link_copy_btn"
    Then I should see the message "Live link copied to your clipboard"
    When I click "tutorials.tab_share_tutorial_direct_link_copy_btn"
    Then I should see the message "Direct link copied to your clipboard"

	# Should be executed manually for embed function
	@wip
  Scenario: Copy embeded code
    Given I am at the Share Menu page
    When I navigate to Embeded tab
    And I hover the embed code
    Then I should see the message on the code "Click to copy"
    When I click the code
    Then The notification "Embed link copied to your clipboard" should be shown
    When I embed the copied code in a selected website
    Then I should be able to play the tutorial in the selected website

  Scenario: Check if tutorial owner is listed in Assign tab
    Given I logged in iroad with user "premiumindividualuser2" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "premium 2" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails              							|
      | iorad.teammember1+demo@gmail.com 	|
      | iorad.teammember1@gmail.com 			|
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permissions granted to iorad.teammember1+demo@gmail.com, iorad.teammember1@gmail.com"
    And Wait for 5 seconds
    # At the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    And The element "tutorials.tab_share_tutorial_pane_assign_email_item" of "iorad.teammember1+demo@gmail.com" should be shown
    And The element "tutorials.tab_share_tutorial_pane_assign_email_item" of "iorad.teammember1@gmail.com" should be shown
    And The element "tutorials.tab_share_tutorial_pane_assign_email_item" of "premiumindividualuser2" should not be shown
    
  Scenario: Check the Assign tab of a team owner
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails              									|
      | iorad.subindiplanuser1@gmail.com 			|
      | iorad.teammember1+demo1@gmail.com			|
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permissions granted to iorad.subindiplanuser1@gmail.com, iorad.teammember1+demo1@gmail.com"
    And Wait for 5 seconds
    # Switch to the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    # Check individual plan user: iorad.subindiplanuser1@gmail.com
    When I hover on email "iorad.subindiplanuser1@gmail.com" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "iorad.subindiplanuser1@gmail.com" should be visible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "iorad.subindiplanuser1@gmail.com" should be disabled
    # Check other team user: iorad.teammember1+demo1@gmail.com
    When I hover the mouse on the "tutorials.tab_share_tutorial_tab_assign"
    And I hover on email "iorad.teammember1+demo1@gmail.com" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "iorad.teammember1+demo1@gmail.com" should be visible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "iorad.teammember1+demo1@gmail.com" should be disabled
    # Check team member: iorad.teammember1+demo@gmail.com
    When I hover the mouse on the "tutorials.tab_share_tutorial_tab_assign"
    And I hover on email "iorad.teammember1+demo@gmail.com" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "iorad.teammember1+demo@gmail.com" should be invisible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "iorad.teammember1+demo@gmail.com" should be enabled
		# Check the owner
		And The element "tutorials.tab_share_tutorial_pane_assign_email_item" of "teamowneruser1" should not be shown

  Scenario: Check the Assign tab of a team member
    Given I logged in iroad with user "iorad.teammember1@gmail.com" and password "123456"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "member tutorial 3" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I input emails at the Invite Share tab
      | Emails              									|
      #| iorad.teammember1+demo@gmail.com 			|
      | iorad.subindiplanuser1@gmail.com 			|
      | iorad.teammember1+demo1@gmail.com			|
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permissions granted to iorad.subindiplanuser1@gmail.com, iorad.teammember1+demo1@gmail.com"
    And Wait for 5 seconds
    # Switch to the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    And The element "tutorials.tab_share_tutorial_pane_assign_email_item" of "iorad.teammember1@gmail.com" should not be shown
    # Check individual plan user: iorad.subindiplanuser1@gmail.com
    When I hover on email "iorad.subindiplanuser1@gmail.com" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "iorad.subindiplanuser1@gmail.com" should be visible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "iorad.subindiplanuser1@gmail.com" should be disabled
    # Check other user: iorad.teammember1+demo1@gmail.com
    When I hover the mouse on the "tutorials.tab_share_tutorial_tab_assign"
    And I hover on email "iorad.teammember1+demo1@gmail.com" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "iorad.teammember1+demo1@gmail.com" should be visible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "iorad.teammember1+demo1@gmail.com" should be disabled
    # Check other team member: iorad.teammember1+demo@gmail.com
    When I hover the mouse on the "tutorials.tab_share_tutorial_tab_assign"
    And I hover on email "iorad.teammember1+demo@gmail.com" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "iorad.teammember1+demo@gmail.com" should be invisible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "iorad.teammember1+demo@gmail.com" should be enabled
    # Check team owner: iorad.teamowneruser1@gmail.com
    When I hover the mouse on the "tutorials.tab_share_tutorial_tab_assign"
    And I hover on email "iorad.teamowneruser1@gmail.com" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "iorad.teamowneruser1@gmail.com" should be invisible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "iorad.teamowneruser1@gmail.com" should be disabled
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_edit" of "iorad.teamowneruser1@gmail.com" should be visible

  Scenario Outline: Team owner / team member set the Edit right for other members
    Given I logged in iroad with user "<user>" and password "<password>"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # Switch to the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    # Set Edit right
    When I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "<shared_user>" should be invisible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>" should be enabled
    When I click on "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>"
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>" should be visible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_view_link" of "<shared_user>" should be visible
    When I click on "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>"
    Then I should see the message "Access updated."
    When Wait for 5 seconds
    And I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_edit" of "<shared_user>" should be visible
    # Login with iorad.teammember1+demo@gmail.com to see the shared tutorial
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When I logged in iroad with user "<shared_user>" and password "<password>"
    And I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.share_edit_tab"
    Then I should be redirected to Shared Edit tab
    When I search for "<tutorial>" tutorial
    Then I should not see the message "No Results Found"
    And The element "tutorials.three_dot_icon" should be shown
    Examples:
    |	user														|	password	|	tutorial					|	shared_user												|
    | iorad.teammember1@gmail.com			|	123456		| member tutorial 1	|	iorad.teammember1+demo@gmail.com	|
    | iorad.teamowneruser1@gmail.com	|	123456		|	Live 1 - Premium	|	iorad.teammember1+demo@gmail.com	|

  Scenario Outline: Team ower/ member sets the View right for other members
    Given I logged in iroad with user "<user>" and password "<password>"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # Switch to the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    # Set View right
    When I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn" of "<shared_user>" should be invisible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>" should be enabled
    When I click on "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>"
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>" should be visible
    And The "tutorials.tab_share_tutorial_pane_assign_email_item_view_link" of "<shared_user>" should be visible
    When I click on "tutorials.tab_share_tutorial_pane_assign_email_item_view_link" of "<shared_user>"
    Then I should see the message "Access updated."
    When Wait for 5 seconds
    And I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_view" of "<shared_user>" should be visible
    # Login with iorad.teammember1+demo@gmail.com to see the shared tutorial
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When I logged in iroad with user "<shared_user>" and password "<password>"
    And I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.share_edit_tab"
    Then I should be redirected to Shared Edit tab
    When I search for "<tutorial>" tutorial
    Then I should see the message "No Results Found"
    And The element "tutorials.three_dot_icon" should not be shown
    #And The tutorial should be listed in the My Learning page of the member
    Examples:
    |	user														|	password	|	tutorial					|	shared_user												|
    | iorad.teammember1@gmail.com			|	123456		| member tutorial 1	|	iorad.teammember1+demo@gmail.com	|
    | iorad.teamowneruser1@gmail.com	|	123456		|	Live 1 - Premium	|	iorad.teammember1+demo@gmail.com	|

  Scenario Outline: Delete an email in the Assign tab
  	Given I logged in iroad with user "teamowneruser" and password "validpassword"
  	When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "shared edit to memebr" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At Share tutorial popup
    Then The "tutorials.share_tutorial_popup_header" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    # At the Invite tab, send the invitation to the free existing users/ indivudal plan user/ other team user
    When I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    When I fill value "<Email>" to "tutorials.tab_share_tutorial_pane_invite_input_email_txt" textbox
    And I press Enter
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "<Invited_Message>"
    And Wait for 5 seconds
    # At the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    When I hover on email "<Email>" at the Assgin tab
    And I delete the email "<Email>" from the Assign tab
    Then I should see the message "<Removed_Message>"
    Examples:
    	| Email 														|		Invited_Message																					|	Removed_Message																					|
    	| iorad.teammember1@gmail.com				|		Permission granted to iorad.teammember1@gmail.com				|	Access of iorad.teammember1@gmail.com was removed				|
    	| iorad.subindiplanuser1@gmail.com	|		Permission granted to iorad.subindiplanuser1@gmail.com	|	Access of iorad.subindiplanuser1@gmail.com was removed	|
    	| iorad.verifieduser1@gmail.com			|		Permission granted to iorad.verifieduser1@gmail.com			|	Access of iorad.verifieduser1@gmail.com was removed			|

  Scenario: check the permission to Embed-Only tutorial
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 3 - Premium - Embed OnlOnly" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At Share tutorial popup
    Then The "tutorials.share_tutorial_popup_header" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    # Focus at the Link tab
    And The "tutorials.tab_share_tutorial_pane_link" should be visible
    # See 3 tabs
    And The "tutorials.tab_share_tutorial_tab_link" should be visible
    And The "tutorials.tab_share_tutorial_tab_embed" should be visible
    And The "tutorials.tab_share_tutorial_tab_assign" should be visible
    # Not see the Invite tab
    And The "tutorials.tab_share_tutorial_tab_invite" should be invisible

	# Waiting for new auto test data for specific domain emails
	@pending
  Scenario: Free user shares the tutorial with users having the same domain
    Given My email has the specific domain, for example, hoavt@teracy.com
    And I am at the Assign tab
    When I click the checkbox "Allow anybody with teracy.com email domain to view this tutorial"
    Then I should see the notification "Upgrade to automatically share with everybody in your company."
    When I click the Upgrade link in the notification
    Then I should be redirected to the /pricing page

	# Waiting for new auto test data for specific domain emails
	@pending
  Scenario: Premium user shares the tutorial with users havign the same domain
    Given My email has the specific domain, for example, hoavt@teracy.com
    And I am at the Assign tab of the Private / Unlisted / Public tutorial
    And The checkbox "Allow anybody with teracy.com email domain to view this tutorial" is unchecked
    When I click the checkbox "Allow anybody with teracy.com email domain to view this tutorial"
    Then The checkbox should be checked
    And I should see the notification "Domain "teracy.com" successfully allowed."
    And All users having the same domain email should see the tutorial in their My Learning page
    And They should be able to play the tutorial

	# Waiting for new auto test data for specific domain emails
	@pending
  Scenario: Premium user unchecks the "Allow anybody with teracy.com email domain to view this tutorial" checkbox
    Given My email has the specific domain, for example, hoavt@teracy.com
    And I am at the Assign tab of the Private / Unlisted / Public tutorial
    And The checkbox "Allow anybody with teracy.com email domain to view this tutorial" is checked
    When I click the checkbox "Allow anybody with teracy.com email domain to view this tutorial"
    Then The checkbox should be unchecked
    And I should see the notification "Domain "teracy.com" successfully disallowed."
    And All users having the same domain email should not see the tutorial in their My Learning page anymore
    And They should not be able to play the Private tutorial anymore
    And They should still be able to play the Public / Unlisted tutorial

	# Waiting for new auto test data for specific domain emails
	@pending
  Scenario: Check if the "Allow anybody with teracy.com email domain to view this tutorial" checkbox for Embed Only tutorial
    Given My email has the specific domain, for example, hoavt@teracy.com
    And I am at the Assign tab of the Embed Only tutorial
    Then I should not see the "Allow anybody with teracy.com email domain to view this tutorial" checkbox

	# Waiting for new auto test data for specific domain emails
	@pending
  Scenario: check if shared user still sees the tutorial after unchecking the the "Allow anybody..." checkbox
    Given My email has the specific domain, for example, hoavt@teracy.com
    And The checkbox "Allow anybody with teracy.com email domain to view this tutorial" is checked
    And I shared my tutorial with a user using the same domain email
    When I uncheck the "Allow anybody with teracy.com email domain to view this tutorial" checkbox
    Then The shared user should still play the tutorial

  Scenario: Invite user with valid email of existing user
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails              						 |
      | iorad.subindiplanuser1@gmail.com |
    Then The text of element "tutorials.tab_share_tutorial_pane_invite_inputted_email_txt" should contain "iorad.subindiplanuser1@gmail.com"
    When I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permission granted to iorad.subindiplanuser1@gmail.com"
    # Check email
    When Open gmail with user "iorad.subindiplanuser1@gmail.com" and password "iorad@123"
    Then The text of element "servermail.first_email_title" should contain "iorad.subindiplanuser1@gmail.com"
    And The text of element "servermail.first_email_title" should contain "Team Owner 1 has shared"
    
  Scenario: Invite user with the valid email of unregistered user
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails              |
      | testuser123@gmail.com |
    Then The text of element "tutorials.tab_share_tutorial_pane_invite_inputted_email_txt" should contain "testuser123@gmail.com"
    When I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permission granted to testuser123@gmail.com"
    # Check email
    When Open gmail with user "testuser1234@gmail.com" and password "iorad@123"
    Then The text of element "servermail.first_email_title" should contain "testuser123@gmail.com"
    And The text of element "servermail.first_email_title" should contain "Team Owner 1 has shared"

  Scenario: Check the notification when invites to 2 users
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails              |
      | testuser1@gmail.com |
      | testuser2@gmail.com |
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permissions granted to testuser1@gmail.com, testuser2@gmail.com"

  Scenario: Check the notification when invites to more than 2 users
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails              |
      | testuser3@gmail.com |
      | testuser4@gmail.com |
      | testuser5@gmail.com |
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permissions granted to testuser3@gmail.com, testuser4@gmail.com, testuser5@gmail.com"

  Scenario: Invite user with invalid email
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I input emails at the Invite Share tab
      | Emails             |
      | testing@iorad..com |
    Then I should see the message "Please enter a valid email address"

  Scenario: Input so many emails in the input form
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails           |
      | test1@gmail.com  |
      | test2@gmail.com  |
      | test3@gmail.com  |
      | test4@gmail.com  |
      | test5@gmail.com  |
      | test6@gmail.com  |
      | test7@gmail.com  |
      | test8@gmail.com  |
      | test9@gmail.com  |
      | test10@gmail.com |
      | test11@gmail.com |
      | test12@gmail.com |
      | test13@gmail.com |
      | test14@gmail.com |
      | test15@gmail.com |
    # The below step should be tested manually
    #Then There should be a scroll bar to view the input emails
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permissions granted to test1@gmail.com, test2@gmail.com and 13 others"

  Scenario: Invite user with empty email
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    Then The "tutorials.tab_share_tutorial_pane_invite_send_invite_btn" should be disabled

  Scenario: Invite the current user
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails                         |
      | iorad.teamowneruser1@gmail.com |
    Then I should see the message "You cannot send an invite to yourself"

  Scenario: Remove the input email
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite emails
    When I input emails at the Invite Share tab
      | Emails                    |
      | testremoveemail@gmail.com |
    Then The text of element "tutorials.tab_share_tutorial_pane_invite_inputted_email_txt" should contain "testremoveemail@gmail.com"
    When I click "tutorials.tab_share_tutorial_pane_invite_inputted_email_x_icon"
    Then The text of element "tutorials.tab_share_tutorial_pane_invite" should not contain "testremoveemail@gmail.com"

  Scenario: Invite the invited email
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Invite tab
    And I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Invite an email
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails                      |
      | test_resend_email@gmail.com |
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permission granted to test_resend_email@gmail.com"
    # Re-invite the email
    When I input emails at the Invite Share tab
      | Emails                      |
      | test_resend_email@gmail.com |
    Then I should see the message "Invitation to this email address has already been sent"
    And The "tutorials.tab_share_tutorial_pane_invite_send_invite_btn" should be disabled
    
  Scenario: Resend the pending invitation
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # Clear pending list first
    And I clear email pending list
    # At the Invite tab
    When I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    #And The "tutorials.tab_share_tutorial_pane_invite_suggestion_emails_list" should be visible
    # Send an invitation
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails                          |
      | iorad.unverifieduser4@gmail.com |
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permission granted to iorad.unverifieduser4@gmail.com"
    # Resend the invitation
    When I hover the mouse on the "tutorials.tab_share_tutorial_pane_invite_inputted_email_txt"
    Then The "tutorials.tab_share_tutorial_pane_invite_inputted_email_resend_btn" should be visible
    And The "tutorials.tab_share_tutorial_pane_invite_inputted_email_x_icon" should be visible
    When I click "tutorials.tab_share_tutorial_pane_invite_inputted_email_resend_btn"
    And I click "tutorials.tab_share_tutorial_pane_invite_confirm_resend"
    Then I should see the message "Permission granted to iorad.unverifieduser4@gmail.com"
    # Check email
    When Open gmail with user "iorad.unverifieduser4@gmail.com" and password "iorad@123"
    Then The text of element "servermail.first_email_title" should contain "iorad.unverifieduser4@gmail.com"
    And The text of element "servermail.first_email_title" should contain "Team Owner 1 has shared"

  Scenario: Delete the pending invitation
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # Clear pending list first
    And I clear email pending list
    # At the Invite tab
    When I click "tutorials.tab_share_tutorial_tab_invite"
    Then The "tutorials.tab_share_tutorial_pane_invite" should be visible
    # Send an invitation
    When I clear email pending list
    And I input emails at the Invite Share tab
      | Emails                          |
      | iorad.unverifieduser4@gmail.com |
    And I click "tutorials.tab_share_tutorial_pane_invite_send_invite_btn"
    Then I should see the message "Permission granted to iorad.unverifieduser4@gmail.com"
    # Resend the invitation
    When I hover the mouse on the "tutorials.tab_share_tutorial_pane_invite_inputted_email_txt"
    Then The "tutorials.tab_share_tutorial_pane_invite_inputted_email_resend_btn" should be visible
    And The "tutorials.tab_share_tutorial_pane_invite_inputted_email_x_icon" should be visible
    When I click "tutorials.tab_share_tutorial_pane_invite_inputted_email_x_icon"
    And I click "tutorials.tab_share_tutorial_pane_invite_confirm_remove"
    Then I should see the message "Access of iorad.unverifieduser4@gmail.com was removed"
    # Check email
    When Open gmail with user "iorad.unverifieduser4@gmail.com" and password "iorad@123"
    Then The text of element "servermail.first_email_title" should contain "iorad.unverifieduser4@gmail.com"
    And The text of element "servermail.first_email_title" should contain "Team Owner 1 has shared"
	
  Scenario: Close the Share menu page
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "Live 2 - Premium" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # Close popup
    When I click "tutorials.tab_share_tutorial_tab_close"
    # The Share menu page / Share option page should be closed
    Then The "tutorials.share_tutorial_popup_header" should be invisible
    And The "tutorials.share_tutorial_popup_subject" should be invisible
    And The "tutorials.share_tutorial_popup_subject" should be invisible
    # I should be back to Shared Edit page
    And The "tutorials.my_tutorials.tutorial_name" should be visible

  Scenario Outline: Check Live link shown for a tutorial having Live disabled
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<Live_disabled_Tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At Share tutorial popup
    And The "tutorials.share_tutorial_popup_header" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    And The "tutorials.share_tutorial_popup_subject" should be visible
    # Focus at the Link tab
    And The "tutorials.tab_share_tutorial_pane_link" should be visible
    And The "tutorials.tab_share_tutorial_live_link" should be invisible
		
		Examples:
			|	Live_disabled_Tutorial 					|
			|	tutorial created by the owner 1	|
    
    #Given I am at the Link tab of a tutorial having Live disabled
    #Then I should see the the Live link

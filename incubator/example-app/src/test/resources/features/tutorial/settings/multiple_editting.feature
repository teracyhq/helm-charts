Feature: Allow multiple editing
  
    As a team owner,
    I want to assign the Edit right to my team members
    so they can edit my tutorials

  Scenario Outline: Assign the Can Edit right to the team member
    Given I logged in iroad with user "<user>" and password "<password>"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<shared_tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    And The text of element "tutorials.tab_share_tutorial_pane_assign" should contain "<shared_user>"
    # Set Edit right
    When I hover on email "<shared_user>" at the Assgin tab
    And I click on "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>"
    And I click on "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>"
    Then I should see the message "Access updated."
    When Wait for 5 seconds
    And I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_edit" of "<shared_user>" should be visible
    # Login with shared_user to see the shared tutorial
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When I logged in iroad with user "<shared_user>" and password "<password>"
    # Check editable right
    And I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.share_edit_tab"
    Then I should be redirected to Shared Edit tab
    When I search for "<shared_tutorial>" tutorial
    Then The element "tutorials.shared_tab.tutorial_action_btn" should be shown
    When I click "tutorials.shared_tab.tutorial_action_btn"
    Then The url should contain "dev.iorad.local/editor/"
    # Check playable right
    When I go to "/tutorials" page
    And I click "tutorials.share_edit_tab"
    Then I should be redirected to Shared Edit tab
    When I search for "<shared_tutorial>" tutorial
    Then The element "tutorials.three_dot_icon" should be shown
    When I click "tutorials.three_dot_icon"
    And I click "tutorials.play"
    Then I should be redirected to the player page of the tutorial

    Examples: 
      | user           | password      | shared_user     | shared_tutorial   |
      | teamowneruser1 | validpassword | teammemberuser  | Live 1 - Premium  |
      | teammemberuser | validpassword | teammemberuser1 | member tutorial 2 |

  Scenario Outline: Team member edits a shared tutorial
    Given I logged in iroad with user "<user>" and password "<password>"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<shared_tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    And The text of element "tutorials.tab_share_tutorial_pane_assign" should contain "<shared_user>"
    # Set Edit right
    When I hover on email "<shared_user>" at the Assgin tab
    And I click on "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>"
    And I click on "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>"
    Then I should see the message "Access updated."
    When Wait for 5 seconds
    And I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_edit" of "<shared_user>" should be visible
    # Login with shared_user to see the shared tutorial
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When I logged in iroad with user "<shared_user>" and password "<password>"
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I click "tutorials.share_edit_tab"
    Then I should be redirected to Shared Edit tab
    When I search for "<shared_tutorial>" tutorial
    Then The element "tutorials.three_dot_icon" should be shown
    When I click "tutorials.three_dot_icon"
    Then The element "tutorials.play" should be shown
    And The element "tutorials.setting" should be shown
    And The element "tutorials.revisions" should be shown
    And The element "tutorials.duplicate" should be shown
    And The element "tutorials.share_button" should be shown

    Examples: 
      | user           | password      | shared_user     | shared_tutorial   |
      | teammemberuser | validpassword | teammemberuser1 | member tutorial 2 |

	# Automation can't start 2 session with 2 users loggin to the iorad system.
	@wip
  Scenario: Multiple users are editing the tutorials at the same time
    Given Multiple users are editing the tutorials at the same time
    Then I should see the notification

  Scenario Outline: Remove the Can Edit right of a team member
    Given I logged in iroad with user "<user>" and password "<password>"
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<shared_tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    And The text of element "tutorials.tab_share_tutorial_pane_assign" should contain "<shared_user>"
    # Set View right
    When I hover on email "<shared_user>" at the Assgin tab
    And I click on "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>"
    And I click on "tutorials.tab_share_tutorial_pane_assign_email_item_view_link" of "<shared_user>"
    Then I should see the message "Access updated."
    When Wait for 5 seconds
    And I hover on email "<shared_user>" at the Assgin tab
    Then The element "tutorials.tab_share_tutorial_pane_assign_email_item_permission_view" of "<shared_user>" should be shown
    # Login with shared_user to see the shared tutorial
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When I logged in iroad with user "<shared_user>" and password "<password>"
    # Check Shared Edit tab
    And I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.share_edit_tab"
    Then I should be redirected to Shared Edit tab
    When I search for "<shared_tutorial>" tutorial
    Then I should see the message "No Results Found"
    # Check Shared tab
    When I go to "/tutorials" page
    And I click "tutorials.shared_tab"
    Then I should be redirected to the Shared page
    When I search for "<shared_tutorial>" tutorial
    And I click "tutorials.shared_tab.tutorial_action_btn"
    Then I should be redirected to the player page of the tutorial

    Examples: 
      | user           | password      | shared_user    | shared_tutorial  |
      | teamowneruser1 | validpassword | teammemberuser | Live 1 - Premium |

  Scenario Outline: Search for tutorials at the Shared Tutorials tab
    Given I logged in iroad with user "<user>" and password "<password>"
    # Access the Finish page
    When I should see the My tutorials page content
    And I search for "<shared_tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    # Remove category/label
    When I click "tutorials.add_category_btn"
    And I remove tags from the tutorial settings page
 		# Add description/label
    When I fill value "<tags>" to "tutorials.settings.category_tag_popup.tag_textbox" textbox
    And I press Enter
    And I fill value "<description>" to "tutorials.settings.category_tag_popup.description_textbox" textbox
    And I click "tutorials.settings.category_tag_popup.save_button"
    Then I should see the message "Tutorial properties updated."
    # Finish
    When I click "tutorials.finish_button"
    And switch back to parent frame
    Then I should see the My tutorials page content
    # Go to Share tutorial popup
    When I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    When I search for "<shared_tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.share_button"
    # At the Assign tab
    When I click "tutorials.tab_share_tutorial_tab_assign"
    Then The "tutorials.tab_share_tutorial_pane_assign" should be visible
    And The text of element "tutorials.tab_share_tutorial_pane_assign" should contain "<shared_user>"
    # Set Edit right
    When I hover on email "<shared_user>" at the Assgin tab
    And I click on "tutorials.tab_share_tutorial_pane_assign_email_item_permission_btn" of "<shared_user>"
    And I click on "tutorials.tab_share_tutorial_pane_assign_email_item_edit_link" of "<shared_user>"
    Then I should see the message "Access updated."
    When Wait for 5 seconds
    And I hover on email "<shared_user>" at the Assgin tab
    Then The "tutorials.tab_share_tutorial_pane_assign_email_item_permission_edit" of "<shared_user>" should be visible
    # Login with shared_user to see the shared tutorial
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page
    When I logged in iroad with user "<shared_user>" and password "<password>"
    # Check Shared Edit tab
    And I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.share_edit_tab"
    Then I should be redirected to Shared Edit tab
    # Search by name
    When I search for "<shared_tutorial>" tutorial
    Then The text of element "tutorials.name_tutorial_label" should be "<shared_tutorial>"
    # Search by tags
    When I search for "<tags>" tutorial
    Then The text of element "tutorials.name_tutorial_label" should be "<shared_tutorial>"
    # Search by description
    When I search for "<description>" tutorial
    Then The text of element "tutorials.name_tutorial_label" should be "<shared_tutorial>"

    Examples: 
      | user           | password      | shared_user    | shared_tutorial  |	 tags         | description      	 |
      | teamowneruser1 | validpassword | teammemberuser | Live 1 - Premium |	 auto tag 11  | auto description 11 |

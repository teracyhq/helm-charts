@test7
Feature: Owner's tutorial shares the access and Edit permission to others
  
    As a logged-in user,
    I want to share my tutorial to others
    so that they can view or edit my tutorial

  Background: 
    Given I logged in iroad with user "teamowneruser1" and password "validpassword"
    Then I should see the My tutorials page content
    When I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    And The element "tutorials.preview_desktop_mode_active" should be shown

  Scenario: Access the Share page
    When I click "tutorials.settings.share_button"
    And switch back to parent frame
    # At Share tutorial popup
    And The "tutorials.share_tutorial_popup_header" should be visible
    # Focus at the Link tab
    And The "tutorials.tab_share_tutorial_pane_invite" should be visible

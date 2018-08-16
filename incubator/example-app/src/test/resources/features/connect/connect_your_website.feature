Feature: connect your website with iroad
  
    As a logged-in user,
    I want to connect my website with iorad
    so that I can add the iorad widget to my site and share my tutorials with others

  Scenario Outline: Open/Close the widget
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When Disconnect website
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When I click "iorad_connect.connect_your_website_button"
    Then I should be redirected to the "/connectIntegrations/direct/website"
    When I click "iorad_connect_website.arrow_widget_icon"
    Then The element "iorad_connect_website.tutorial_widget_frame" should be shown
    And I should see all categories contaning tutorials I have access
    When I click a category
    Then I should see all tutorials I have access in the category
    When I click the back arrow on the navigation bar
    Then I should be back to the category list
    When I click "iorad_connect_website.close_widget_button"
    Then The element "iorad_connect_website.tutorial_widget_frame" should not be shown

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario Outline: Play a tutorial in the widget
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When Disconnect website
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When I click "iorad_connect.connect_your_website_button"
    Then I should be redirected to the "/connectIntegrations/direct/website"
    When I click "iorad_connect_website.arrow_widget_icon"
    Then The element "iorad_connect_website.tutorial_widget_frame" should be shown
    And I have access the live tutorial
    When I click a category
    Then The category name should be shown in the navigation bar
    And The list of tutorials which I have access should be shown
    When I click a tutorial
    Then The tutorial steps should be listed in the widget
    And The tutorial title should be shown in the navigation bar
    When I click Guide Me button
    Then The tutorial should be played-back on my website

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario Outline: Back to a category from a tutorial
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When Disconnect website
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When I click "iorad_connect.connect_your_website_button"
    Then I should be redirected to the "/connectIntegrations/direct/website"
    When I click "iorad_connect_website.arrow_widget_icon"
    Then The element "iorad_connect_website.tutorial_widget_frame" should be shown
    Given I am playing a tutorial in the widget
    When I click the arrow back on the navigation bar
    Then I should be back to the category
    And I should see all tutorials I have access in the category

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario Outline: Add a live tutorial to the widget
    Given I logged in iroad with user "<username>" and password "<password>"
    And I still have right to create live tutorials
    When I created a tutorial by iorad chrome extension
    And I do not add the category for the tutorial
    Then The tutorial should have the "Live Mode" checkbox checked by default
    And The tutorial should have the "Enable" status on My tutorials by default
    And The tutorial should be listed in the widget in the Uncategorized category by default

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario: Free user creates 5 live tutorials to the widget
    Given I am logged-in as a free verified user
    And I created 5 live tutorials
    When I go my website and click the Widget
    Then I should see my tutorials listed in the widget
    And I should see the category name in the navigation bar

  Scenario: Free user try to create 6 live tutorials
    Given I am logged-in as a free verified user
    And I created 5 live tutorials
    When I create one more tutorial by iorad chrome extension
    Then The Live Mode checkbox of the tutorial should be unchecked by default
    And The Live Mode checkbox should not be able to checked
    And The tutorial should not be listed in the widget

  Scenario: free user upgrades the plan from the widget
    Given I am logged-in as a free verified user
    And I access the widget
    When I click Upgrade on the Widget
    Then I should be redirected to the /pricing page

  Scenario: Premium adds more 5 live tutorials to the widget
    Given I am logged-in as a premium individual user
    And I already have 5 live tutorials
    When I create more live tutorials
    Then These live tutorials should be added to the widget

  Scenario: The widget creator/members add live tutorials to the widget
    Given I am logged-in as a team member
    And A widget has created by another team member
    When I create a live tutorial
    Then The tutorial should be added to the widget

  Scenario Outline: Uncheck the Live Mode checkbox
    Given I logged in iroad with user "<username>" and password "<password>"
    And I have a live tutorial added to the widget
    When I edit the tutorial
    And I uncheck the Live Mode checkbox
    Then The tutorial should not be listed in the widget anymore
    And The tutorial should not be marked as Live in My Tutorials

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario Outline: Check the Live Mode checkbox
    Given I logged in iroad with user "<username>" and password "<password>"
    And I still have right to add more live tutorials
    And A live tutorial has the Live Mode checkbox unchecked
    When I edit the tutorial
    And I check the Live Mode checkbox
    Then The tutorial should be listed in the widget
    And The tutorial should be marked as Live in My Tutorials

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario Outline: Disable a live tutorial
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    And I have a live tutorial
    And The live tutorials has the Enable status
    When I click Enabled
    Then The tutorial status should be changed into Disabled
    And The tutorial should be marked as Live
    And The tutorial should not be listed in the Widget

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario Outline: Enabled a live tutorial
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click "tutorials.my_tutorial_tab"
    Then I should be redirected to My tutorials tab
    And I have a live tutorial with the Disabled status
    When I click the Disabled tatus of the tutorial
    Then The tutorial should have the Enabled status
    And The tutorial should be listed in the Widget

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario: Check if the other user can add live tutorials to the widget
    Given I am logged-in as a premium individual user
    And I am not a team member or the widget creator
    And The widget has created by another team
    When I create a live tutorial
    Then The tutorial should not be added to the tutorial list of the widget

  # for manual
  Scenario: Check if everyone can see the tutorial on the widget
    Given I am a logged in user
    And I am at my website connected to iorad
    When I click a category in the widget
    And I click a tutorial
    Then The steps of the tutorial should be listed
    When I click Guide Me
    Then The step should be highlighted on the website

  Scenario Outline: Open the live tutorial from Live tab in Editor
    Given I logged in iroad with user "<username>" and password "<password>"
    And I am at the Editor page of a live tutorial
    When I navigate to the Live tab
    And I click Open
    Then The tutorial should be opened in the widget on the websited in a new tab
    When I click Guide Me
    Then The tutorial should be played-back

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  @regression
  Scenario Outline: Play & edit a desktop after connecting the website
    Given I logged in iroad with user "<username>" and password "<password>"
    And I have a desktop /live tutorial
    And I have tutorials in My Tutorials / Edit Shared tab
    When I play a tutorial at My Tutorials  / Edit Shared tab
    Then The tutorial player should be opened in a new tab
    And I should be able to view the tutorial in Try / View mode
    When I click Edit on the player
    Then I should be redirected to the Editor page
    And I should be able to edit the tutorial
    And The tutorial changes should be saved successfully

    Examples: 
      | username       | password      |
      | teamowneruser  | validpassword |
      | teammemberuser | validpassword |

  Scenario: Edit a live tutorial after connecting the website
    Given I have a live tutorial
    When I click Edit of a live tutorial from My tutorials / the tutorial player
    Then The Editor page should be opened
    When I edit the tutorial
    And I click Preview & Finish
    Then I should be navigated to the Settings page
    When I edit the tutorial title
    And I change the privacy settings / customize the theme
    And I change the tool color
    And I click Finish
    Then The changes should be saved and applied on the player and the widget

  # currently, just public & unlisted tutorials are loaded in the widget
  Scenario Outline: Change the privacy of tutorials listed in the widget
    Given I logged in iroad with user "<username>" and password "<password>"
    When I go to the Settings page of a public tutorial
    And I change the privacy of tutorials into Unlisted/Private /Embed-Only
    And I open the widget
    And I open the category to which the tutorial is added
    Then The private /embed only tutorial should be listed in the category

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario: check if locked live tutorials are listed in the widget
    Given I am logged-in as a premium individual user
    And I have more than 5 live tutorials added to the widget
    When I cancel subscripition
    And My plan is changed into free
    Then The live tutorials should be locked
    And All these live tutorials should be kept on the widget
    And I should see the Upgrade button on the widget
    And I should see the message "iorad Live trial"
    And I should see the message "5 tutorials available"

  Scenario: Unlocked live tutorials and edit it
    Given I am logged-in as a free verified user
    And I have locked live tutorials
    When I unlocked live tutorial
    And I made some changes for the unlocked live tutorial
    Then The changes should be applied for the tutorial on the widget

  Scenario: search a tutorial in the widget
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When Disconnect website
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When I click "iorad_connect.connect_your_website_button"
    Then I should be redirected to the "/connectIntegrations/direct/website"
    When I click "iorad_connect_website.arrow_widget_icon"
    Then The element "iorad_connect_website.tutorial_widget_frame" should be shown
    When I fill value "abcxyzautotest" to "iorad_connect.widget_search_tutorial_textbox" textbox
    When I press Enter
    Then All tutorials whose title match the search and I have access should be listed


  Scenario: No search result found in the widget
    Given I am logged-in as a free verified user
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When Disconnect website
    When I click on the "left_menu.connect" on the left panel
    Then I should be redirected to the "/connectIntegrations/direct" page
    When I click "iorad_connect.connect_your_website_button"
    Then I should be redirected to the "/connectIntegrations/direct/website"
    When I click "iorad_connect_website.arrow_widget_icon"
    Then The element "iorad_connect_website.tutorial_widget_frame" should be shown
    When switch to "iorad_connect_website.tutorial_widget_frame" frame
    When I fill value "abcxyzautotest" to "iorad_connect.widget_search_tutorial_textbox" textbox
    When I press Enter
    Then The element "iorad_connect.widget_no_tutorial_found_label" should be shown

  Scenario Outline: Create/rename a category of the live tutorial
    Given I logged in iroad with user "<username>" and password "<password>"
    And The live tutorial is listed in the widget
    When I add the live tutorial to a category or rename the category
    Then The category should be listed in the widget
    And The tutorial should be in the category

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario Outline: Check the live tutorial having no specidal category is added to the Uncategorized category
    Given I logged in iroad with user "<username>" and password "<password>"
    And I create a live tutorial which is not added to any category yet
    When I open the widget
    And I click the Uncategorized category
    Then I should see the tutorial in the category

    Examples: 
      | username              | password      |
      | freeverifieduser      | validpassword |
      | premiumindividualuser | validpassword |

  Scenario: check the bullet for tutorials
    Given I have some live tutorials created within 7 days
    And I have live tutorials created more than 7 days ago
    When I open the widget
    Then I should see the bullet for the tutorials created within 7 days
    And I should not see the bullet for the tutorials created more than 7 days ago

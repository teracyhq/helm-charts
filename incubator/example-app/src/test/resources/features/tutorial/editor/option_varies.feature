@desktop
Feature: "Flexible learner choice" or "Option varies" is a per-step setting. It states what to do
  when playing a live tutorial and a step isn't found.  It shows text, link and playing audio.
  
    As a logged-in user,
    I want to enable the "Flexible learner choice" for tutorials captured with the iorad chrome extension
    so that text, link and audio can be shown at a step not found in live.

  Scenario: Free users access the Flexible Learner Choice popup
    Given I am a free user
    And I am at the Editor page of a tutorial captured by extension
    And I have two premium tutorials
    When I click the "Flexible learner choice" link
    Then The "Flexible learner choice" poup should be opened
    And I should see the checkbox "Flexible learner choice"
    And The fields should be masked
    And I should see the noty "Audio is only available to premium users.Upgrade"
    And I should see the message below Voice Over "Upgrade your plan to continue using this"
    And The "Upgrade" link should be referred to /pricing page

  Scenario: Private Plan users access the Flexible Learner Choice popup
    Given I am in the private plan
    And I am at the Editor page of a tutorial captured by extension
    And I have two premium tutorials
    When I click the "Flexible learner choice" link
    Then The "Flexible learner choice" poup should be opened
    And I should see the checkbox "Flexible learner choice"
    And The fields should be masked
    And I should see the noty "Audio is only available to premium users. Contact Us"
    And I should see the message below Voice Over "Your plan does not include audio. Contact Us"
    And The "Contact Us" link should be referred to /contact page

  Scenario: Premium users access the Flexible Learner Choice popup
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "premiumindividualuser2" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    And The element "option_varies.flexible_learner_choice_chk" should be shown
    # The field should be masked
    When I uncheck "option_varies.flexible_learner_choice_chk"
    Then The "option_varies.flexible_learner_choice_overlay_mask" should be visible
    When I check "option_varies.flexible_learner_choice_chk"
    Then The "option_varies.flexible_learner_choice_overlay_mask" should be invisible

  Scenario: Check the tooltip on the Flexible Learner Choice popup
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # Check the tooltip
    When I hover the mouse on the "option_varies.flexible_learner_choice_chk_tool_tip"
    Then The attribute "data-hint" of element "option_varies.flexible_learner_choice_chk_tool_tip" should contain "In live mode, the learner can select from equivalent"
    And The attribute "data-hint" of element "option_varies.flexible_learner_choice_chk_tool_tip" should contain "items other than what was captured."
    And The attribute "data-hint" of element "option_varies.flexible_learner_choice_chk_tool_tip" should contain "Commonly used on a list of items."

  Scenario Outline: Enable "Flexible learner choice" checkbox
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # I input the maximum of 250 characters into "If equivalent items are not found, show message" field
    When I check "option_varies.flexible_learner_choice_chk"
    When I fill value "<equivalent_message>" to the equivalent message text box
    And I click "option_varies.flexible_learner_popup.close_icon"
    Then The Flexible learner choice should be closed
    # Check the saved message
    When I click "option_varies.flexible_learner_choice_link"
    Then The "option_varies.flexible_learner_choice_chk" checkbox should be checked
    And The value of the equivalent message text box should be "<equivalent_message>"

    Examples: 
      | tutorial        | equivalent_message                                                                                                                                                                                                                                        |
      | Live tutorial 2 | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |

  @wip
  Scenario: Disable "Flexible learner choice" checkbox
    Given I added some info into the "Flexible learner choice" form
    And The "Flexible learner choice" is enabled
    When I click this checkbox
    Then This field should be unchecked
    When I play the tutorial with the equivalent items not found
    Then I should not see any info input in "If equivalent items are not found, show message" field

  Scenario: check tooltip next to the link "Flexible learner choice"
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Check the tooltip
    When I hover the mouse on the "option_varies.flexible_learner_choice_tool_tip"
    Then The attribute "data-hint" of element "option_varies.flexible_learner_choice_tool_tip" should contain "In live mode, the learner can select from equivalent"
    And The attribute "data-hint" of element "option_varies.flexible_learner_choice_tool_tip" should contain "items other than what was captured on this step."
    And The attribute "data-hint" of element "option_varies.flexible_learner_choice_tool_tip" should contain "Commonly used on dropdown options or user"
    And The attribute "data-hint" of element "option_varies.flexible_learner_choice_tool_tip" should contain "generated items like docs and tickets."

  Scenario Outline: Bold/Italic/Underline the text of "If equivalent items are not found, show message"field
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # Set bold text
    When I fill value "<equivalent_message>" to the equivalent message text box
    And I click "option_varies.flexible_learner_popup.bold_btn"
    Then The equivalent message "<equivalent_message>" should be bold
    # Set underline text
    When I fill value "<equivalent_message>" to the equivalent message text box
    And I click "option_varies.flexible_learner_popup.underline_btn"
    Then The equivalent message "<equivalent_message>" should be underline

    Examples: 
      | tutorial        | equivalent_message |
      | Live tutorial 2 | equivalent_message |

  Scenario Outline: Add a link for the text of "If equivalent items are not found, show message" field
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # Set hyperlink
    When I fill value "<equivalent_message>" to the equivalent message text box
    And I click "option_varies.flexible_learner_popup.hyperlink_btn"
    And I fill value "<hyperlink>" to "option_varies.flexible_learner_popup.hyperlink_txt" textbox
    And I click "option_varies.flexible_learner_popup.hyperlink_confirm_btn"
    And I click "option_varies.flexible_learner_popup.close_icon"
    Then The Flexible learner choice should be closed
    # Check the saved hyperlink
    When I click "option_varies.flexible_learner_choice_link"
    Then The "option_varies.flexible_learner_choice_chk" checkbox should be checked
    And The equivalent message text box should contain hyperlink "<hyperlink>" for text "<equivalent_message>"

    Examples: 
      | tutorial        | equivalent_message | hyperlink         |
      | Live tutorial 2 | equivalent_message | http://google.com |

  Scenario Outline: Cancel adding a link for the text of "If equivalent items are not found, show message"field
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # Cancel the hyperlink
    When I fill value "<equivalent_message>" to the equivalent message text box
    And I click "option_varies.flexible_learner_popup.hyperlink_btn"
    And I fill value "<hyperlink>" to "option_varies.flexible_learner_popup.hyperlink_txt" textbox
    And I click "option_varies.flexible_learner_popup.hyperlink_cancel_btn"
    And I click "option_varies.flexible_learner_popup.close_icon"
    Then The Flexible learner choice should be closed
    # Check the saved hyperlink
    When I click "option_varies.flexible_learner_choice_link"
    Then The "option_varies.flexible_learner_choice_chk" checkbox should be checked
    And The equivalent message text box should not contain hyperlink "<hyperlink>" for text "<equivalent_message>"

    Examples: 
      | tutorial        | equivalent_message | hyperlink         |
      | Live tutorial 2 | equivalent_message | http://google.com |

  Scenario Outline: Input more 250 characters in the "If equivalent items are not found, show message" field
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # I input more 250 characters into "If equivalent items are not found, show message" field
    When I fill value "<equivalent_message>" to the equivalent message text box
    And I click "option_varies.flexible_learner_popup.close_icon"
    Then I should see the message "I know you have a lot to say. But we only allow 250 characters."
    And The attribute "class" of element "option_varies.flexible_learner_popup.message_goneover_label" should contain "goneover"

    Examples: 
      | tutorial        | equivalent_message                                                                                                                                                                                                                                          |
      | Live tutorial 2 | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |

  Scenario Outline: Select link for the tutorial
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # Check the "Link for tutorial" field
    When I click "option_varies.flexible_learner_popup.link_for_tutorial_txt"
    And I fill value "<link_for_tutorial>" to "option_varies.flexible_learner_popup.link_for_tutorial_txt" textbox
    Then The text of elements "option_varies.flexible_learner_popup.link_for_tutorial_suggestion_item" should contain "<link_for_tutorial>"
    When I click "option_varies.flexible_learner_popup.link_for_tutorial_suggestion_item"
    Then The text of element "option_varies.flexible_learner_popup.link_for_tutorial" should contain "<link_for_tutorial>"
    And I click "option_varies.flexible_learner_popup.close_icon"

    Examples: 
      | tutorial        | link_for_tutorial |
      | Live tutorial 2 | Live              |

  @chrome, @firefox @Safari
  Scenario Outline: Upload a valid audio file
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # Upload audio file
    When Upload file "<audio_file_path>"
    Then I should see the message "Audio has been saved"
    When I click "option_varies.flexible_learner_popup.close_icon"
    # Check the saved audio
    When I click "option_varies.flexible_learner_choice_link"
    Then I should see the message "Audio added"

    Examples: 
      | tutorial        | audio_file_path                                   |  |
      | Live tutorial 2 | \\src\\test\\resources\\testdata\\valid_audio.mp3 |  |

  @IE11 @wip
  Scenario: Upload a valid audio file
    Given I am at the "Flexible learner choice" form
    When I click Choose File
    Then I should see the message "Your browser is not supported mp3 conversion. Try chrome or firefox."

  @chrome, @firefox @Safari
  Scenario Outline: Upload an invalid file type for Voice Over
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # Upload invalid audio file type
    When Upload file "<invalid_audio_file_type>"
    Then I should see the message "Invalid file type. Please select an audio file."

    Examples: 
      | tutorial        | invalid_audio_file_type                    |
      | Live tutorial 2 | \\src\\test\\resources\\testdata\\pic3.doc |

  @chrome, @firefox @Safari
  Scenario Outline: Upload an invalid audio lenght (more 1 minute)
    # Login and open the Tutorial Editor
    Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    When I click on the "left_menu.tutorials" on the left panel
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    When I click "option_varies.flexible_learner_choice_link"
    Then The Flexible learner choice should be shown up
    # Upload invalid audio file type
    When Upload file "<long_audio_file>"
    Then I should see the message "Sorry the max length for an audio file is 1 minute."

    Examples: 
      | tutorial        | long_audio_file                                  |
      | Live tutorial 2 | \\src\\test\\resources\\testdata\\over_1_min.mp3 |

  # Those @wip scenarioes need a micro conntected to the test machine to record an audio
  # Recommend for manual testing
  @chrome, @firefox @Safari @wip
  Scenario: Record audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Save
    Then The audio should be saved
    When I click Save
    Then I should be back to the first screen of the "Flexible learner choice" form
    And The audio should be saved
    And I should see the message about audio converted into mp3
    And I should see the message about the audio saved successfully
    And I should see the Remove link next to the audio

  @IE11 @wip
  Scenario: Record audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    Then I should see an error message

  @chrome, @firefox @Safari @wip
  Scenario: Make the recorded audio silent
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Save
    Then The audio should be saved
    When I click Silence
    Then I should not be able to hear the audio

  @chrome, @firefox @Safari @wip
  Scenario: Fade in / fade out the recorded audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Save
    Then The audio should be saved
    When I click Fade In / Fade Out
    Then The audio volume on the left / right should be smaller correlatively

  @wip
  Scenario: Copy & Paste the audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Save
    Then The audio should be saved
    When I select a part of the audio
    And I click Copy
    And I click Paste into a part of the audio
    Then The selected part of the audio should be copied and pasted successfully

  @chrome, @firefox @Safari @wip
  Scenario: Cut & Paste the audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Save
    Then The audio should be saved
    When I select a part of the audio
    And I click Cut
    Then The selected part should be cut
    When I click Paste into a part of the audio
    Then The selected part of the audio should be pasted successfully

  @chrome, @firefox @Safari @wip
  Scenario: Delete a part of the audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Save
    Then The audio should be saved
    When I select a part of the audio
    And I click Delete
    Then The selected part of the audio should be deleted

  @chrome, @firefox @Safari @wip
  Scenario: Play the audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Save
    Then The audio should be saved
    When I click the play icon
    Then The audio should be played

  @chrome, @firefox @Safari @wip
  Scenario: Cancel recording audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Cancel
    Then The audio should not be saved
    And I should be back to the first screen of the "Flexible learner choice" form

  @chrome, @firefox @Safari @wip
  Scenario: Cancel saving the recorded audio
    Given I am at the "Flexible learner choice" form
    When I click Record
    And Recording is working
    And I click Save
    Then The audio should be saved
    When I click Cancel
    Then I should be back to the first screen of the "Flexible learner choice" form
    And The audio should not be saved

  @chrome, @firefox @Safari @wip
  Scenario: Remove audio
    Given I am at the "Flexible learner choice" form
    And I recorded or uploaded an audio file
    When I click Remove link next to the audio file
    Then The audio should be removed
    And I should see the Choose File and Record links

  #Scenario Outline: Cancel saving the changes of the "Flexible learner choice" form
    # Login and open the Tutorial Editor
    #Given I logged in iroad with user "teammemberuser1" and password "validpassword"
    #When I click on the "left_menu.tutorials" on the left panel
    #Then I should see the My tutorials page content
    #When I search for "<tutorial>" tutorial
    #And I click "tutorials.my_tutorials_tab.tutorial_action_btn"
    #Then I should be redirected to the tutorial editor
    # Open "Flexible learner choice" form
    #When I open The Flexible learner choice
    #Then The Flexible learner choice should be shown up
    # I input the maximum of 250 characters into "If equivalent items are not found, show message" field
    #When I fill value "<equivalent_message>" to the equivalent message text box
    #And I click "option_varies.flexible_learner_popup.cancel_btn"
    #Then The Flexible learner choice should be closed
    # Check the saved message
    #When I open The Flexible learner choice
    #Then The value of the equivalent message text box should be "<equivalent_message>"
#
    #Examples: 
      #| tutorial        | equivalent_message |
      #| Live tutorial 2 | equivalent msg     |

  @chrome @wip
  Scenario: Play the tutorial from the extension panel having the equivalent items found
    Given I enabled the "Flexible learner choice" checkbox of a step
    And I added the message in the "If equivalent items are not found, show message" field
    And I aded a related link
    And I recorded an audio
    When I play the tutorial from the iorad extension
    And I am at the step not found on live
    Then I should see the message
    And I should see the "Click here" link under the message
    And I should see the audio
    When I click the "Click here" link
    Then Another live tutorial should be open in the extension
    When I click audio
    Then The audio should play

  @chrome @wip
  Scenario: Play the tutorial from the extension panel without the equivalent items found
    Given I disabled the "Flexible learner choice" checkbox of a step
    And I added the message in the "If equivalent items are not found, show message" field
    And I aded a related link
    And I recorded an audio
    When I play the tutorial from the iorad extension
    And I am at the step not found on live
    Then I should not see the message
    And I should not see the "Click here" link under the message
    And I should not see the audio

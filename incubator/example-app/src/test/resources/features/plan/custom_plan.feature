Feature: As a user, I want to use the custom public or private plan so that I can share the plan with my desired users.

  Scenario Outline: Free user subsribes the trial plan without cc requirement
    ### Login by admin user and add a new trial plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<trial_plan>" should be visible
    # No cc requirement
    When I click on "admin.plans.action.edit_icon" of "<trial_plan>"
    Then I should see the message "Update plan"
    When I uncheck "admin.edit_plan.setting_tab.cc_required"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Sign up an user
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    # Verify the user
    When Open gmail with user "signup_user" and password "signup.gmail_unverified_password"
    And I close other tabs
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link" and switch to the second tab
    # Checkout
    And I navigate to the url stored in variable "plan_link"
    Then I should see the Checkout page content
    And I should see the message "7 days for free!"
    And The "checkout.checkout_button" should be enabled
    When I click "checkout.more_creator_button"
    And I should see the message "$0"
    When I click "checkout.checkout_button"
    Then I should be redirected to Thank You page
    # Check Plan info
    When I am at the "/account" page
    When I click "my_plan.my_plan_link"
    Then The text of element "my_plan.price_plan" should be "$0/mo"
    And The trial ends Date for trial plan "7 days" should be correct

    #And I should be used all the features of the plan
    Examples: 
      | admin     | password      | free_user      | trial_plan    |
      | adminuser | validpassword | googlefreeuser | Trial Plan 11 |

  # The user can use all features -> Need check manually because automation can't capture a tutorial by using iorad extension
  @wip
  Scenario Outline: Free user subsribes the trial plan with cc requirement
    ### Login by admin user and get the plan's link
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<trial_plan>"
    Then I should see the message "Update plan"
    When I check "admin.edit_plan.setting_tab.cc_required"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Sign up an user
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    # Verify the user
    When Open gmail with user "signup_user" and password "signup.gmail_unverified_password"
    And I close other tabs
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link" and switch to the second tab
    # Checkout
    When I navigate to the url stored in variable "plan_link"
    Then I should see the Checkout page content
    And The "checkout.checkout_button" should be disabled
    And I should see the message "7 days for free!"
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.more_creator_button"
    Then The "checkout.checkout_button" should be enabled
    And I should see the message "$0"
    When I click "checkout.checkout_button"
    Then I should be redirected to Thank You page
    # Check Plan info
    When I am at the "/account" page
    When I click "my_plan.my_plan_link"
    #Then The text of element "my_plan.price_plan" should be "$0/mo"
    And The trial ends Date for trial plan "7 days" should be correct

    #And I should not be charged
    #And I should be used all the features of the plan
    Examples: 
      | admin     | password      | trial_plan    |
      | adminuser | validpassword | Trial Plan 22 |

  Scenario Outline: User subscribes the plan without free trial
    ### Login by admin user and get the plan's link
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<no_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "No trial"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Sign up an user
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    # Verify the user
    When Open gmail with user "signup_user" and password "signup.gmail_unverified_password"
    And I close other tabs
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link" and switch to the second tab
    # Checkout
    When I navigate to the url stored in variable "plan_link"
    Then I should see the Checkout page content
    And The "checkout.checkout_button" should be disabled
    #And I should see the message "$1 per creator per month"
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.more_creator_button"
    And The "checkout.checkout_button" should be enabled
    And I should see the message "$3"
    When I click "checkout.checkout_button"
    Then I should be redirected to Thank You page
    # Check billing
    When I am at the "/account" page
    And I click "billing_information.billing_information_link"
    Then The text of element "billing_information.first_history" should contain "$3 on"
    # Check quota
    When I click "quota.quota_link"
    Then The text of element "quota.quota_public_premium" should be "0 of unlimited"
    And The text of element "quota.quota_live_premium" should be "0 of unlimited"
    And The text of element "quota.quota_premium_premium" should be "0 of unlimited"
    # Check Plan info
    When I click "my_plan.my_plan_link"
    Then I should see the message "$3"
    And I should see the message "<no_trial_plan>"
    And I should see the message "2 creators"

    Examples: 
      | admin     | password      | no_trial_plan   |
      | adminuser | validpassword | No Trial Plan 5 |

  # Can't run the schedule task on local
  @wip
  Scenario: Existing user (used to be premium) subscribes the trial plan
    Given I used to subscribe a plan
    And I am logged in as a free user
    And Admin created a custom plan having the trial
    When I subscribe the plan
    Then I should not be able to use the trial
    And I should be charged immediately

  # use this link "http://test.iorad.com/api/actScheduledDowngradePlan?test=manualRun&userIds=11" to run the schedule task on the test server
  # Can't run the schedule task on local
  @wip
  Scenario: Check if the trial ends on correct date
    Given I've already subscrbied the plan having the trial of 7 days / 14 days / 1 month
    When I run the schedule task
    Then The plan should be converted into Free
    And All my tutorials should be locked

  # use this link "http://dev.iorad.local/api/actScheduledDowngradePlan?test=manualRun&userIds=13" to run the schedule task on the test server
  # Can't run the schedule task on local
  @wip
  Scenario: Check if the trial ends for unlimited free trial plan
    Given I've already subscrbied the plan having the trial
    When I run the schedule task
    Then The plan should not be converted into Free

  # Can't run the schedule task on local
  @wip
  Scenario: Resubscribe the trial plan without the cc requirement after the trial ends
    Given I have subscribed the trial plan
    And The trial ends
    When I subscribes the plan again
    Then I should be required to input the cc
    When I input the valid cc info
    And I click the Checkout button
    Then I should subscribe the custom plan successfully
    And I should be charged

  # Can't run the schedule task on local
  @wip
  Scenario: Subscribe the trial plan with the cc requirement after the trial ends
    Given I have subscribed the trial plan
    And The trial ends
    When I subscribes the plan again
    Then The cc info should be auto-filled in
    When I click the Checkout button
    Then I should subscribe the custom plan successfully
    And I should be charged

  Scenario Outline: During trial, user can not change creators of custom plan
    ### Login by admin user and add a new trial plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<trial_plan>" should be visible
    # Set cc requirement
    When I click on "admin.plans.action.edit_icon" of "<trial_plan>"
    Then I should see the message "Update plan"
    When I uncheck "admin.edit_plan.setting_tab.cc_required"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Sign up an user
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    # Verify the user
    When Open gmail with user "signup_user" and password "signup.gmail_unverified_password"
    And I close other tabs
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link" and switch to the second tab
    # Checkout
    And I navigate to the url stored in variable "plan_link"
    Then I should see the Checkout page content
    And I should see the message "7 days for free!"
    And The "checkout.checkout_button" should be enabled
    When I click "checkout.more_creator_button"
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page
    # Check Plan info
    When I am at the "/account" page
    When I click "my_plan.my_plan_link"
    Then The text of element "my_plan.price_plan" should be "$0/mo"
    And The trial ends Date for trial plan "7 days" should be correct
    And The "my_plan.more_plan_button" should be enabled
    And The "my_plan.less_plan_button" should be enabled
    # Increase cretors
    When Store the text of element "my_plan.creator_number" in variable "before_creators"
    And I click "my_plan.more_plan_button"
    Then I should see the message "Contact Us"
    And I should see the message "to make changes to your account"
    When Store the text of element "my_plan.creator_number" in variable "after_creators"
    Then The variable "after_creators" should be equal to variable "before_creators"
    # Decrease cretors
    When Store the text of element "my_plan.creator_number" in variable "before_creators"
    And I click "my_plan.less_plan_button"
    Then I should see the message "Contact Us"
    And I should see the message "to make changes to your account"
    When Store the text of element "my_plan.creator_number" in variable "after_creators"
    Then The variable "after_creators" should be equal to variable "before_creators"

    Examples: 
      | admin     | password      | free_user      | trial_plan    |
      | adminuser | validpassword | googlefreeuser | Trial Plan 33 |

  Scenario Outline: Duplicate Private tutorial when the limit reaches
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Set private tutorial limit of 2
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "Private"
    And I enable the plan feature "Private limit"
    And I uncheck "admin.edit_plan.feature_tab.private_tutorial_unlimited_chk"
    And I fill value "2" to "admin.edit_plan.feature_tab.private_tutorial_number_textbox" textbox
    And I enable the plan feature "Premium limit"
    And I check "admin.edit_plan.feature_tab.premium_tutorial_unlimited_chk"
    And I enable the plan feature "Live Tutorials limit"
    And I check "admin.edit_plan.feature_tab.live_tutorial_unlimited_chk"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.duplicate"
    Then I should see the message "You are over your private tutorial limit."

    Examples: 
      | admin     | password      | plan          | subcribed_user | tutorial                        |
      | adminuser | validpassword | Live - Annual | teamowneruser1 | tutorial created by the owner 1 |

  # Can't automate capturing a tutorial by iorad extension
  @wip
  Scenario: Create more Private tutorial when the private limit reaches
    Given Admin creates a custom plan which has Private of 2 tutorials
    And I subscribe the plan
    And I create 2 private tutorials
    When I create another new tutorial
    And I set the tutorial into Private / Unlisted / Embed Only
    Then I should see the message "You've reached the usage limit for this feature. Contact Us"
    And The Contact Us link should be linked to the /contactus page

  Scenario Outline: Change a tutorial into Unlisted / Embed Only when the Private limit reaches
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Set private tutorial limit of 2
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "Private"
    And I enable the plan feature "Private limit"
    And I uncheck "admin.edit_plan.feature_tab.private_tutorial_unlimited_chk"
    And I fill value "2" to "admin.edit_plan.feature_tab.private_tutorial_number_textbox" textbox
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ## Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    # Set to Embed Only
    When I click "tutorials.settings.access_permission.selectize_control"
    And I select "Embed Only" from the selection list "tutorials.settings.access_permission.selectize_options"
    Then The "tutorials.settings.embed_tab" should be visible
    # Set Unlisted
    When I click "tutorials.settings.access_permission.selectize_control"
    And I select "Unlisted" from the selection list "tutorials.settings.access_permission.selectize_options"
    Then The text of element "tutorials.settings.access_permission.selectize_control" should be "Unlisted"
    # Set back to Private
    When I click "tutorials.settings.access_permission.selectize_control"
    And I select "Private" from the selection list "tutorials.settings.access_permission.selectize_options"
    Then The text of element "tutorials.settings.access_permission.selectize_control" should be "Private"

    Examples: 
      | admin     | password      | plan          | subcribed_user         | tutorial         |
      | adminuser | validpassword | Live - Annual | teamowneruser1         | Live 2 - Premium |

  # Can't automate capturing a tutorial by iorad extension
  @wip
  Scenario: Create a Unlisted / Embed Only tutorial in the allowed Private limit
    Given Admin creates a custom plan which has private tutorial limit of 2
    And Admin enables the features: Unlisted  and Embed Only
    And I subscribe the plan
    And I create 1 private tutorials
    When I create a new tutorial
    And I set the tutorial into Unlisted / Embed Only
    Then The tutorial should be changed into Unlisted / Embed Only

  # Waiting for a new uer having a specific domain
  @wip
  Scenario: Check a Private feature "Shared with email" enabled
    Given Admin creates a custom plan having private tutorials
    And Admin enables the feature Shared with email"
    And I subscribe the plan with the email having a specific domain
    When I create a private tutorial
    And I open the Share & Access form
    Then I should see the checkbox "Allow anybody with [domain] email domain to view this tutorial"
    When I check this checkbox
    Then The checkbox should be checked
    And The tutorial should be shared with users having the same email domain

  # Waiting for a new uer having a specific domain
  @wip
  Scenario: Check a Private feature "Shared with email" disabled
    Given Admin creates a custom plan having private tutorials
    And Admin disables the feature Shared with email"
    And I subscribe the plan with the email having a specific domain
    When I create a private tutorial
    And I open the Share & Access form
    Then I should see the checkbox "Allow anybody with [domain] email domain to view this tutorial"
    When I check this checkbox
    Then I should see the notification "You've reached the usage limit for this feature. Contact Us"
    And The Contact Us should be linked to the /contactus page

  Scenario Outline: Check a premium features enabled: Audio, Mask data, Theme, Tool and Layout
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Enable premium feature
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "Theme"
    And I enable the plan feature "Audio"
    #And I enable the plan feature "Mask Data"
    And I enable the plan feature "Highlight"
    And I enable the plan feature "Layout"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ## Login by a subcriber and check the enabled/disabled features
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    # Theme/ Color / Layout
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then I should not see the message "Your plan does not include this feature."
    When I fill value "#fff" to "tutorials.settings.customize_theme.background_color_textbox" textbox
    And I click "tutorials.settings.customize_theme.background_color_picker.submit_btn"
    Then I should see the message "Saved"
    When I click "tutorials.settings.customize_theme.layout_tab"
    Then I should not see the message "Your plan does not include this feature."
    # Editor
    When switch back to parent frame
    And I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.edit_icon"
    And Switch to "tutorials.iorad_app_iframe" frame
    # Mask Data
    When I click "tutorials.add_mask_data_link"
    Then I should see the message "Drag your mouse over the area you want to mask."
    # Audio
    When I click "tutorials.add_audio_link"
    Then The "tutorials.add_audio_form" should be visible
    And I click "tutorials.add_audio_close_button"

    Examples: 
      | admin     | password      | plan | subcribed_user | tutorial          |
      | adminuser | validpassword | Live | teamowneruser  | Just share Access |

  Scenario Outline: Check premium features disabled
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Theme enabled, and Tool Color and Layout tabs disabled
    When I click "admin.edit_plan.feature_tab"
    And I disable the plan feature "Theme"
    And I disable the plan feature "Audio"
    And I disable the plan feature "Mask limit"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled/disabled features
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    # Theme/ Color / Layout
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    Then I should see the message "Your plan does not include this feature."
    And The "tutorials.contact_us_link" should be visible
    When I click "tutorials.settings.customize_theme.layout_tab"
    Then I should see the message "Your plan does not include this feature."
    And The "tutorials.contact_us_link" should be visible
    # Editor
    When switch back to parent frame
    And I click on the "left_menu.tutorials" button from the slide out menu
    And I click "tutorials.edit_icon"
    And Switch to "tutorials.iorad_app_iframe" frame
    # Audio
    When I click "tutorials.add_audio_link"
    Then I should see the message "Your plan does not include audio."
    And The "tutorials.contact_us_link" should be visible
    # Mask Data
    #When I click "tutorials.add_mask_data_link"
    #Then I should see the message "Your plan does not include this feature."
    #And The "tutorials.contact_us_link" should be visible

    Examples: 
      | admin     | password      | plan | subcribed_user 				 | tutorial          |
      | adminuser | validpassword | Live | premiumindividualuser2  | Premium 4 |

  Scenario Outline: Check the case Theme enabled, and Tool Color and Layout tabs disabled
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Theme enabled, and Tool Color and Layout tabs disabled
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "Theme"
    And I disable the plan feature "Highlight"
    And I disable the plan feature "Layout"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled/disabled features
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.setting"
    Then I should be redirected to the Finish page of the tutorial
    When I click "tutorials.settings.customize_theme"
    And I click "tutorials.settings.customize_theme.layout_tab"
    Then I should see the message "Your plan does not include this feature."
    And The "tutorials.contact_us_link" should be visible

    Examples: 
      | admin     | password      | plan | subcribed_user | tutorial          |
      | adminuser | validpassword | Live | teamowneruser  | Just share Access |

  # Can't create new tutorial by automation
  @wip
  Scenario: Create a premium tutorial when the premium limit reaches
    Given Admin creates a custom plan having the premium limit of 2
    When I subscribe the plan
    And I create 2 tutorials using the premium features: Audio, Mask Data, Custom Theme, Layout, and Tool Color
    And I create another tutorial
    And I use the premium features: Audio, Mask Data, Custom Theme, Layout, and Tool Color
    Then I should see the message "You've reached the usage limit for this feature. Contact Us"

  Scenario Outline: Duplicate a premium tutorial when the premium limit reaches
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Set Premium tutorial limit of 1
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "Premium"
    And I enable the plan feature "Premium limit"
    And I uncheck "admin.edit_plan.feature_tab.premium_tutorial_unlimited_chk"
    And I fill value "1" to "admin.edit_plan.feature_tab.premium_tutorial_number_textbox" textbox
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.duplicate"
    Then I should see the message "You are over your premium tutorial limit."

    Examples: 
      | admin     | password      | plan   | subcribed_user  | tutorial   				|
      | adminuser | validpassword | Live	 | teamowneruser	 | Just share Access |

   # Can't auto capturing new tutorial using iorad extension
  @wip
  Scenario: Create a Live tutorial when the Live limit reaches
    Given Admin creates a custom plan having the live tutorial limit of 2
    When I subscribe the plan
    And I create 2 live tutorials
    And I create a tutorial with iorad chrome extension
    And I check the Live Mode on the Settings page
    Then I should see the message "You've reached the usage limit for this feature. Contact Us"
    And The Contact Us link should be linked to the /contactus page

  Scenario Outline: Duplicate a Live tutorial when the Live limit reaches
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Set live tutorial limit of 2
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "Live"
    And I enable the plan feature "Live Tutorials limit"
    And I uncheck "admin.edit_plan.feature_tab.live_tutorial_unlimited_chk"
    And I fill value "2" to "admin.edit_plan.feature_tab.live_tutorial_number_textbox" textbox
    And I enable the plan feature "Premium limit"
    And I check "admin.edit_plan.feature_tab.premium_tutorial_unlimited_chk"
    And I enable the plan feature "Private limit"
    And I check "admin.edit_plan.feature_tab.private_tutorial_unlimited_chk"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I search for "<tutorial>" tutorial
    And I click "tutorials.three_dot_icon"
    And I click "tutorials.duplicate"
    Then I should see the message "You are over your live tutorial limit."

    Examples: 
      | admin     | password      | plan          | subcribed_user | tutorial         |
      | adminuser | validpassword | Live - Annual | teamowneruser1 | Live 1 - Premium |

   # Can't auto capturing new tutorial using iorad extension
  @wip
  Scenario: User can create unlimited live tutorials when Live featue is unlimited
    Given Admin creates a custom plan having unlimited private / premium / live limit
    When I subscribes the plan
    And I navigate to Account page
    Then The private / premium / live info on Account Summary should be "xx of unlimited"
    And I should be able to create unlimited private / premium / live tutorials

  @wip
  Scenario: Check the Integrates features (Connect website, Zendesk Connect and Zendesk Tutorial limit) enabled

  @wip
  Scenario: Check the Connect Website Live feature disabled

  @wip
  Scenario: Check the Zendesk Connect feature disabled

  @wip
  Scenario: Check the Zendesk Tutorial Limit

  # This test uses the 'Live - Annual' as a custom plan
  Scenario Outline: Check the Custom Translation feature enabled
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Enable the 'Custom Translation' feature
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "<plan_feature>"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I click "tutorials.three_dot_icon"
    Then The "tutorials.translate" should be visible

    Examples: 
      | admin     | password      | plan          | plan_feature       | subcribed_user |
      | adminuser | validpassword | Live - Annual | Custom Translation | teamowneruser1 |

  # This test uses the 'Live - Annual' as a custom plan
  Scenario Outline: Check the Custom Translation feature disabled
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Disable the 'Custom Translation' feature
    When I click "admin.edit_plan.feature_tab"
    And I disable the plan feature "<plan_feature>"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I click "tutorials.three_dot_icon"
    Then The "tutorials.translate" should be invisible

    Examples: 
      | admin     | password      | plan          | plan_feature       | subcribed_user |
      | adminuser | validpassword | Live - Annual | Custom Translation | teamowneruser1 |

  # This test uses the 'Live - Annual' as a custom plan
  Scenario Outline: Check the Analytics feature enabled
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Enable the 'Analytics' feature
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "<plan_feature>"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I click "tutorials.three_dot_icon"
    Then The "tutorials.statistics" should be visible
    When I click "tutorials.statistics"
    Then The "tutorials.statistics.statistics_modal" should be visible

    Examples: 
      | admin     | password      | plan          | plan_feature | subcribed_user |
      | adminuser | validpassword | Live - Annual | Analytics    | teamowneruser1 |

  Scenario Outline: Check the Analytics feature disabled
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Disable the 'Analytics' feature
    When I click "admin.edit_plan.feature_tab"
    And I disable the plan feature "<plan_feature>"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I click "tutorials.three_dot_icon"
    Then The "tutorials.statistics" should be visible
    When I click "tutorials.statistics"
    Then I should see the message "Sample data. Your plan does not include this feature."

    Examples: 
      | admin     | password      | plan          | plan_feature | subcribed_user |
      | adminuser | validpassword | Live - Annual | Analytics    | teamowneruser1 |

  Scenario Outline: Check the Download features (SCROM / HTML ZIP) enabled
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Disable the 'Download' feature
    When I click "admin.edit_plan.feature_tab"
    And I enable the plan feature "Download Tutorials"
    And I enable the plan feature "Download SCORM LMS"
    And I enable the plan feature "Download HTML ZIP"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I click "tutorials.three_dot_icon"
    Then The "tutorials.download" should be visible
    When I click "tutorials.download"
    Then I should be redirected to the Download page
    And The "tutorials.download.html_package_btn" should be enabled
    And The "tutorials.download.scorm_btn" should be enabled

    Examples: 
      | admin     | password      | plan          | subcribed_user |
      | adminuser | validpassword | Live - Annual | teamowneruser1 |

  # This test uses the 'Live - Annual' as a custom plan
  Scenario Outline: Check the Download features (SCROM / HTML ZIP) disabled
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Disable the 'Download' feature
    When I click "admin.edit_plan.feature_tab"
    And I disable the plan feature "<plan_feature>"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I click "tutorials.three_dot_icon"
    Then The "tutorials.download" should be invisible

    Examples: 
      | admin     | password      | plan          | plan_feature       | subcribed_user |
      | adminuser | validpassword | Live - Annual | Download Tutorials | teamowneruser1 |

  # Free charge public plan (Forever Trial) / Unlimited free trial!
  @low_priority
  Scenario Outline: No account/not logged-in unverified user subscribes the unlimited free trial public custom plan
    ### Login by admin user and add a new trial plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<unlimited_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<unlimited_trial_plan>" should be visible
    # Get the plan's link
    When I click on "admin.plans.action.edit_icon" of "<unlimited_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "Forever"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    ## Login by unverified user and hit the link
    When I click on the "left_menu.logout" button from the slide out menu
    And I navigate to the url stored in variable "plan_link"
    Then The "checkout.checkout_button" should be visible
    When I click "checkout.checkout_button"
    And I signup an anynomous user and store in variable "signup_user"
    Then I should be redirected to the "/account" page
    And I should see the message "You'll need to confirm your email first."
    And I should see the message "Resend verification"

    Examples: 
      | admin     | password      | unlimited_trial_plan       |
      | adminuser | validpassword | Unlimited Free Trial Plan1 |

  @low_priority 
  Scenario Outline: Logged-in unverified user subscribes the Unlimited free trial custom public plan
    ### Login by admin user and add a new trial plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<unlimited_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<unlimited_trial_plan>" should be visible
    # Get the plan's link
    When I click on "admin.plans.action.edit_icon" of "<unlimited_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "Forever"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    ## Login by premium user and hit the link
    When I click on the "left_menu.logout" button from the slide out menu
    And I signup an anynomous user and store in variable "signup_user"
    And I navigate to the url stored in variable "plan_link"
    Then I should be redirected to the "/account" page
    And I should see the message "You'll need to confirm your email first."
    And I should see the message "Resend verification"

    Examples: 
      | admin     | password      | unlimited_trial_plan       |
      | adminuser | validpassword | Unlimited Free Trial Plan1 |

  @low_priority
  Scenario Outline: logged-in premium user subscribes the Unlimited free trial custom public plan
    ### Login by admin user and add a new trial plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<trial_plan>" should be visible
    # Get the plan's link
    When I click on "admin.plans.action.edit_icon" of "<trial_plan>"
    Then I should see the message "Update plan"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    ## Login by premium user and hit the link
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<premium_user>" and password "<password>"
    And I navigate to the url stored in variable "plan_link"
    Then I should see the message "You're already subscribed to another plan."

    Examples: 
      | admin     | password      | premium_user                | trial_plan |
      | adminuser | validpassword | googlepremiumindividualuser | Trial Plan |

  # Paid public plan
  @low_priority
  Scenario Outline: unregistered user subscribes the no-trial public plan via email
    ### Login by admin user and invite an unregistered user
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<no_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "No trial"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    # Invite an anynomous user
    When I generate an anynomous user and store in variable "unregister_user"
    And I fill variable "unregister_user" to "admin.edit_plan.invite_email_textbox" textbox
    And I press Enter
    And I click "admin.edit_plan.share_button"
    Then I should see the message "Email invitations were sent"
    And I click on the "left_menu.logout" button from the slide out menu
    # Accept the invitation and sign up
    When Open gmail with user "unregister_user" and password "<password>"
    Then The message "Your custom iorad plan is configured and ready to go!" should be shown in gmail
    And The element "servermail.click_here_link" should be shown
    When I click "servermail.click_here_link"
    And I switch to "Sign Up" window
    Then I should see the sign up page content
    And The attribute "value" of element "signup.email" should equal variable "unregister_user"
    # Sign up
    When I fill value "<password>" to "signup.password" textbox
    And I fill value "<register_name>" to "signup.public_name" textbox
    When I click "signup.terms"
    And I click "signup.signup_button"
    Then I should see the Checkout page content
    # Checkout
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    Examples: 
      | admin     | password      | no_trial_plan  | register_name |
      | adminuser | validpassword | No Trial Plan4 | auto test     |

  @low_priority 
  Scenario Outline: Not-logged-in unverified user subscribes the no-trial public custom plan via email
    ### Sign up an user first
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Login by admin user and invite an unverified user
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<no_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "No trial"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    # Invite an unverified user
    When I fill variable "signup_user" to "admin.edit_plan.invite_email_textbox" textbox
    And I press Enter
    And I click "admin.edit_plan.share_button"	
    Then I should see the message "Email invitations were sent"
    And I click on the "left_menu.logout" button from the slide out menu
    # Accept the invitation
    When Open gmail with user "unregister_user" and password "<password>"
    And I close other tabs
    Then The message "Your custom iorad plan is configured and ready to go!" should be shown in gmail
    And The element "servermail.click_here_link" should be shown
    When I click "servermail.click_here_link"
    And I switch to "Sign In" window
    Then I should see the Log in tab content
    And The attribute "value" of element "login.email" should equal variable "signup_user"
    # Sign in
    When I fill value "<password>" to "login.password" textbox
    And I click "login.login_button"
    Then I should see the Checkout page content
    # Checkout
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    #And My account should be verified
    Examples: 
      | admin     | password      | no_trial_plan  |
      | adminuser | validpassword | No Trial Plan4 |

  @low_priority
  Scenario Outline: Logged-in unverified user subscribes the no-trial public custom plan via email
    ### Sign up an user first
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Login by admin user and invite an unverified user
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<no_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "No trial"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    # Invite an unverified user
    When I fill variable "signup_user" to "admin.edit_plan.invite_email_textbox" textbox
    And I press Enter
    And I click "admin.edit_plan.share_button"
    Then I should see the message "Email invitations were sent"
    And I click on the "left_menu.logout" button from the slide out menu
    # Login and Accept the invitation
    When I fill variable "signup_user" to "login.email" textbox
    And I fill value "<password>" to "login.password" textbox
    And I click "login.login_button"
    When Open gmail with user "signup_user" and password "<password>"
    And I close other tabs
    Then The message "Your custom iorad plan is configured and ready to go!" should be shown in gmail
    And The element "servermail.click_here_link" should be shown
    When I click "servermail.click_here_link"
    And I switch to "Checkout" window
    Then I should see the Checkout page content
    # Checkout
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    Examples: 
      | admin     | password      | no_trial_plan  |
      | adminuser | validpassword | No Trial Plan4 |

  @low_priority
  Scenario Outline: No account/not logged-in unverified user subscribes the no-trial public custom plan via direct link
    ### Sign up an user first
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Login by admin user and invite an unverified user
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<no_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "No trial"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    And I click on the "left_menu.logout" button from the slide out menu
    # copy the link and paste on the browser address
    When I navigate to the url stored in variable "plan_link"
    Then I should see the Checkout page content
    When I click "checkout.checkout_button"
    And I click "login.login_tab"
    Then I should see the Log in tab content
    When I fill variable "signup_user" to "login.email" textbox
    When I fill value "<password>" to "login.password" textbox
    And I click "login.login_button"
    Then I should see the message "You'll need to confirm your email first."
    And The "my_account.resend_verification_link" should be visible
    When I click "my_account.resend_verification_link"
    Then I should see the message "Verification email sent"
    # Verify the user
    When Open gmail with user "signup_user" and password "signup.gmail_unverified_password"
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link"
    # Checkout
    When I navigate to the url stored in variable "plan_link"
    Then I should see the Checkout page content
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    #And My account should be verified
    Examples: 
      | admin     | password      | no_trial_plan  |
      | adminuser | validpassword | No Trial Plan4 |

  @low_priority
  Scenario Outline: Logged-in unverified user subscribes the no-trial public custom plan via direct link
    ### Sign up an user first
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Login by admin user and invite an unverified user
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<no_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "No trial"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    # Copy plan's link
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    And I click on the "left_menu.logout" button from the slide out menu
    # Login and navigate to the plan's link
    When I fill variable "signup_user" to "login.email" textbox
    And I fill value "<password>" to "login.password" textbox
    And I click "login.login_button"
    When I navigate to the url stored in variable "plan_link"
    Then I should see the message "You'll need to confirm your email first."
    And The "my_account.resend_verification_link" should be visible
    When I click "my_account.resend_verification_link"
    Then I should see the message "Verification email sent"
    # Verify the user
    When Open gmail with user "signup_user" and password "signup.gmail_unverified_password"
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link"
    # Checkout
    When I navigate to the url stored in variable "plan_link"
    Then I should see the Checkout page content
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    Examples: 
      | admin     | password      | no_trial_plan  |
      | adminuser | validpassword | No Trial Plan4 |

  @low_priority
  Scenario Outline: unregistered user subscribes the no-trial private custom plan
    ### Login by admin user and invite an unregistered user
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<no_trial_plan>"
    Then I should see the message "Update plan"
    When I select view settings plan type "Invite only"
    And I check "admin.edit_plan.setting_tab.cc_required"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    # Invite an anynomous user
    When I generate an anynomous user and store in variable "unregister_user"
    And I fill variable "unregister_user" to "admin.edit_plan.invite_email_textbox" textbox
    And I press Enter
    And I click "admin.edit_plan.share_button"
    Then I should see the message "Email invitations were sent"
    And I click on the "left_menu.logout" button from the slide out menu
    # Accept the invitation and sign up
    When Open gmail with user "unregister_user" and password "<password>"
    Then The message "Your custom iorad plan is configured and ready to go!" should be shown in gmail
    And The element "servermail.click_here_link" should be shown
    When I click "servermail.click_here_link"
    And I switch to "Sign Up" window
    Then I should see the sign up page content
    And The attribute "value" of element "signup.email" should equal variable "unregister_user"
    # Sign up
    When I fill value "<password>" to "signup.password" textbox
    And I fill value "<register_name>" to "signup.public_name" textbox
    When I click "signup.terms"
    And I click "signup.signup_button"
    Then I should see the Checkout page content
    # Checkout
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    Examples: 
      | admin     | password      | no_trial_plan         | register_name |
      | adminuser | validpassword | No Trial Private Plan | auto test     |

  @low_priority
  Scenario Outline: not logged-in unverified user subscribes the no-trial private custom plan
    ### Sign up an user first
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Login by admin user and invite an unverified user
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<private_no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<private_no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<private_no_trial_plan>"
    Then I should see the message "Update plan"
    When I select view settings plan type "Invite only"
    And I check "admin.edit_plan.setting_tab.cc_required"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    # Invite an unverified user
    When I fill variable "signup_user" to "admin.edit_plan.invite_email_textbox" textbox
    And I press Enter
    And I click "admin.edit_plan.share_button"
    Then I should see the message "Email invitations were sent"
    And I click on the "left_menu.logout" button from the slide out menu
    # Accept the invitation
    When Open gmail with user "unregister_user" and password "<password>"
    And I close other tabs
    Then The message "Your custom iorad plan is configured and ready to go!" should be shown in gmail
    And The element "servermail.click_here_link" should be shown
    When I click "servermail.click_here_link"
    And I switch to "Sign In" window
    Then I should see the Log in tab content
    And The attribute "value" of element "login.email" should equal variable "signup_user"
    # Sign in
    When I fill value "<password>" to "login.password" textbox
    And I click "login.login_button"
    Then I should see the Checkout page content
    # Checkout
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    #And My account should be verified
    Examples: 
      | admin     | password      | private_no_trial_plan |
      | adminuser | validpassword | Trial No Private Plan |

  @low_priority
  Scenario Outline: Logged-in unverified user subscribes the no-trial private custom plan
    ### Sign up an user first
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    And I click on the "left_menu.logout" button from the slide out menu
    ### Login by admin user and invite an unverified user
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<private_no_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<private_no_trial_plan>" should be visible
    And I click on "admin.plans.action.edit_icon" of "<private_no_trial_plan>"
    Then I should see the message "Update plan"
    When I select view settings plan type "Invite only"
    And I check "admin.edit_plan.setting_tab.cc_required"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    # Invite an unverified user
    When I fill variable "signup_user" to "admin.edit_plan.invite_email_textbox" textbox
    And I press Enter
    And I click "admin.edit_plan.share_button"
    Then I should see the message "Email invitations were sent"
    And I click on the "left_menu.logout" button from the slide out menu
    # Login and Accept the invitation
    When I fill variable "signup_user" to "login.email" textbox
    And I fill value "<password>" to "login.password" textbox
    And I click "login.login_button"
    When Open gmail with user "signup_user" and password "<password>"
    And I close other tabs
    Then The message "Your custom iorad plan is configured and ready to go!" should be shown in gmail
    And The element "servermail.click_here_link" should be shown
    When I click "servermail.click_here_link"
    And I switch to "Checkout" window
    Then I should see the Checkout page content
    # Checkout
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    Examples: 
      | admin     | password      | private_no_trial_plan |
      | adminuser | validpassword | Trial No Private Plan |

  # Can't run the schedule task on local
  @wip @low_priority
  Scenario: Convert into free plan from a unlimited free trial custom plan
    Given I subscribed a unlimited free trial custom plan
    When I go to the Account page
    And I click Change Plan button
    Then I should be redirected to the /checkout page of the custom plan
    When I click Downgrade plan to iorad Free link
    Then I should be redirected to the confirmation page
    When I fill in my correct password or email (for google user)
    And I click Cancel Subscription
    Then I should be redirected to My tutorials page with the message
    When Running the schedule task
    Then I should be converted into free
    And All tutorials should be locked

  @low_priority
  Scenario Outline: Subscribed user access the unlimited free trial custom plan via correct share link
    ### Login by admin user and add a new trial plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<unlimited_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<unlimited_trial_plan>" should be visible
    # Get the plan's link
    When I click on "admin.plans.action.edit_icon" of "<unlimited_trial_plan>"
    Then I should see the message "Update plan"
    When I select free plan type "Forever"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    ## Login by premium user and hit the link
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcired_user>" and password "<password>"
    And I navigate to the url stored in variable "plan_link"
    Then I should see the message "You're already subscribed to another plan."

    Examples: 
      | admin     | password      | unlimited_trial_plan       | subcired_user               |
      | adminuser | validpassword | Unlimited Free Trial Plan1 | googlepremiumindividualuser |

  @low_priority
  Scenario Outline: Anonymous user views incorrect public plan link
    Given I navigate to url "<incorrect_plan_link>"
    Then I should see the message "Oops..."
    And I should see the message "Something went wrong"
    And I should see the message "The plan does not exist."
    And The "error_page.go_back_button" should be visible
    When I click "error_page.go_back_button"
    Then I should see the homepage content

    Examples: 
      | incorrect_plan_link                                    |
      | http://dev.iorad.local/acceptSpecial?publicPlanId=1333 |

  @low_priority
  Scenario Outline: Logged-in user views public plan via incorrect share link
    Given I logged in iroad with user "<admin>" and password "<password>"
    And I navigate to url "<incorrect_plan_link>"
    Then I should see the message "Oops..."
    And I should see the message "Something went wrong"
    And I should see the message "The plan does not exist."
    And The "error_page.go_back_button" should be visible
    When I click "error_page.go_back_button"
    And I should see the My tutorials page content

    Examples: 
      | admin                       | password      | incorrect_plan_link                                    |
      | googlepremiumindividualuser | validpassword | http://dev.iorad.local/acceptSpecial?publicPlanId=1333 |

  @low_priority
  Scenario Outline: Logged-in user uses the public/private custom plan link more than one time
    ### Login by admin user and add a new trial plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<free_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<free_trial_plan>" should be visible
    # Get the plan's link
    When I click on "admin.plans.action.edit_icon" of "<free_trial_plan>"
    Then I should see the message "Update plan"
    When I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    ### Sign up an user
    When I click on the "left_menu.logout" button from the slide out menu
    Given I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    When Open gmail with user "signup_user" and password "signup.gmail_unverified_password"
    And I close other tabs
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link" and switch to the second tab
    Then I should see the message "Thanks. You're good to go."
    # Subcribe the plan twice
    When I navigate to the url stored in variable "plan_link"
    Then The "checkout.checkout_button" should be visible
    When I click "checkout.checkout_button"
    Then I should be redirected to Thank You page
    When I navigate to the url stored in variable "plan_link"
    Then I should see the message "You cannot subscribe this plan again!"

    Examples: 
      | admin     | password      | free_trial_plan  |
      | adminuser | validpassword | Free Trial Plan2 |

  @low_priority
  Scenario Outline: Edit plan and uncheck some features: Download, Translation, Analytics
    ### Login by admin user and edit the plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    #And I click on "admin.plans.action_btn" of "<plan>"
    And I click on "admin.plans.action.edit_icon" of "<plan>"
    Then I should see the message "Update plan"
    # Disable the 'Custom Translation' feature
    When I click "admin.edit_plan.feature_tab"
    And I disable the plan feature "Custom Translation"
    And I disable the plan feature "Analytics"
    And I disable the plan feature "Download Tutorials"
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    ### Login by a subcriber and check the enabled feature
    When I click on the "left_menu.logout" button from the slide out menu
    And I logged in iroad with user "<subcribed_user>" and password "<password>"
    Then I should see the My tutorials page content
    When I click "tutorials.three_dot_icon"
    Then The "tutorials.translate" should be invisible
    Then The "tutorials.statistics" should be visible
    Then The "tutorials.download" should be invisible
    When I click "tutorials.statistics"
    Then I should see the message "Sample data. Your plan does not include this feature."

    Examples: 
      | admin     | password      | plan          | subcribed_user |
      | adminuser | validpassword | Live - Annual | teamowneruser1 |

  @low_priority @regression
  Scenario Outline: Create custom plan with min and max user of 1
    ### Login by admin user and add a new trial plan
    Given I logged in iroad with user "<admin>" and password "<password>"
    When I click on the "left_menu.admin" button from the slide out menu
    And I create a plan named  "<unlimited_trial_plan>"
    And I reload page
    And I click on the "left_menu.admin" button from the slide out menu
    Then The "admin.plans.action_btn" of "<unlimited_trial_plan>" should be visible
    # Get the plan's link
    When I click on "admin.plans.action.edit_icon" of "<unlimited_trial_plan>"
    Then I should see the message "Update plan"
    When I click "admin.edit_plan.price_tab"
    And I fill value "1" to "admin.edit_plan.price_tab.min_creators" textbox
    And I fill value "1" to "admin.edit_plan.price_tab.max_creators" textbox
    And I click "admin.edit_plan.update_plan_button"
    Then I should see the message "updated"
    And The "admin.edit_plan.plan_direct_link" should be visible
    When I click "admin.edit_plan.plan_direct_link"
    Then I should see the message "Plan link copied to your clipboard"
    And Store the copied text of clipboard into variable "plan_link"
    ### Sign up an user
    When I click on the "left_menu.logout" button from the slide out menu
    And I am at the "/login" page
    And I click "signup.signup_tab"
    And I signup an anynomous user and store in variable "signup_user"
    When Open gmail with user "signup_user" and password "signup.gmail_unverified_password"
    Then The element "signup.verify_user_link" should be shown in gmail
    When I click "signup.verify_user_link"
    And I navigate to the url stored in variable "plan_link"
    Then I should see the Checkout page content
    And I should see the message "7 days for free!"
    And The "checkout.checkout_button" should be enabled
    When I click "checkout.checkout_button"
    Then I should be redirected to Thank You page

    Examples: 
      | admin     | password      | unlimited_trial_plan | subcribe_user       |
      | adminuser | validpassword | Free Trial Plan2     | upplanverifieduser1 |

  # Can't auto capturing new tutorial using iorad extension
  @wip
  Scenario: Admin adds more private, live, premium, zendesk tutorials for a specific user
    Given My private, live, premium, zendesk module limit reaches
    And Admin adds more private, live, premium, zendesk tutorials for only me
    Then I should be able to create more private, live, premium, zendesk tutorials
    And I should see the private , premium, live tutorial number updated in Your Account page

  # Can't auto capturing new tutorial using iorad extension
  @wip
  Scenario: Admin adds more private tutorials in the main plan
    Given I subscribed the custom plan
    And My private tutorial limit reaches
    And Admin edits the main plan with increasing more private tutorials
    Then I should not be able to add more private tutorials
    And The changes of the plan should be applied to new subscribers only

   # Can't auto capturing new tutorial using iorad extension
  @wip
  Scenario: Capture a tutorial with the iorad chrome extension when live tutorial limit reaches
    Given I subscribed the custom plan
    And My Live tutorial limit reaches
    When I create a tutorial with iorad chrome extension
    Then The tutorial should have the Live Mode unchecked by default

  # Can't automat capturing new tutorial using iorad extension
  @wip
  Scenario: check if live number is updated in Account Summary of team member
    Given I am a member of a custom plan having the live tutorial limit of 10
    And The team owner has created 5 live tutorials
    When I go to Account page
    Then The Live number should be 5 of 10 in the Account Summary tab
    When I create one more live tutorial
    Then This live number should be updated in the Account Summary tab of both mine, team owner's and other members'

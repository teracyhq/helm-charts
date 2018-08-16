@test2
Feature: Update the credit card 

	As a premium plan user,
    I want to change the info of the current credit card
    so I could use the credit card as expected
	
@smoke
Scenario: Access the Credit card update page from the Billing tab 
	Given I logged in iroad with user "teamowneruser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	When I click "my_plan.my_plan_link" 
	When I click "my_plan.more_plan_button"
	And I click "my_plan.update_card_button"
	Then I should be redirected to the UPDATE CREDIT CARD page 
	And The "creditcard.update_button" should be disabled
	
@smoke
Scenario: Access the Credit card update page from the /checkout page 
	Given I logged in iroad with user "lockeduser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	When I click "my_plan.my_plan_link" 
	When I click "my_plan.change_plan_button"
	When I click "pricing.go_live_button" 
	Then I should be redirected to the "/checkout/live" page
	And I click "my_plan.update_card_button"
	Then I should be redirected to the UPDATE CREDIT CARD page 
	And The "creditcard.update_button" should be disabled
	
@smoke
Scenario: Update credit card with valid info 
	Given I logged in iroad with user "teamowneruser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	When I click "billing_information.billing_information_link" 
	When I click "billing_information.update_link" 
	Then I should be redirected to the UPDATE CREDIT CARD page 
	And The "creditcard.update_button" should be disabled 
	When I fill value "checkout.card_number_value" to "checkout.card_number" textbox 
	When I fill value "checkout.expdate_value" to "checkout.expdate" textbox 
	When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
	And The "creditcard.update_button" should be enabled 
	When I click "creditcard.update_button" 
	Then I should see the message "Credit card has been updated." 
	
@function 
 Scenario Outline: Update credit card with invalid card number
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click on the "left_menu.account" on the left panel
    And I click "billing_information.billing_information_link"
    Then I should see the message "Current credit card"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown
    When I click "billing_information.update_link"
    Then I should be redirected to the UPDATE CREDIT CARD page
    And The "creditcard.update_button" should be disabled
    When I fill value "<invalid_card_number>" to "checkout.card_number" textbox
    And I fill value "checkout.expdate_value" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And The "creditcard.update_button" should be enabled
    When I click "creditcard.update_button"
    Then I should see the message "Your card number is incorrect."

    Examples: 
      | username               | password      | invalid_card_number          |
      | teamowneruser          | validpassword | checkout.card_number_invalue |
      | premiumindividualuser1 | validpassword | checkout.card_number_invalue |
	
	#do not have information of locked card number, this case is only run on production env, not run on local
@production @wip @function 
Scenario: Update credit card with locked card number 
	Given I logged in iroad with user "teamowneruser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	When I click "billing_information.billing_information_link" 
	When I click "billing_information.update_link" 
	Then I should be redirected to the UPDATE CREDIT CARD page 
	And The "creditcard.update_button" should be disabled 
	When I fill value "checkout.lock_card_number_value" to "checkout.card_number" textbox 
	When I fill value "checkout.expdate_value" to "checkout.expdate" textbox 
	When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
	And The "creditcard.update_button" should be enabled 
	When I click "creditcard.update_button" 
	Then I should see the message "Your card number is incorrect." 
	
@function 
Scenario Outline: Update credit card with invalid expired year
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click on the "left_menu.account" on the left panel
    And I click "billing_information.billing_information_link"
    Then I should see the message "Current credit card"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown
    When I click "billing_information.update_link"
    Then I should be redirected to the UPDATE CREDIT CARD page
    And The "creditcard.update_button" should be disabled
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "<invalid_expire_year>" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And The "creditcard.update_button" should be enabled
    When I click "creditcard.update_button"
    Then I should see the message "Your card's expiration year is invalid."

    Examples: 
      | username               | password      | invalid_expire_year |
      | teamowneruser          | validpassword | 01/2014             |
      | premiumindividualuser1 | validpassword | 01/2014             |

@function
Scenario Outline: Update credit card with invalid expired month 
    Given I logged in iroad with user "teamowneruser" and password "validpassword" 
    When I click on the "left_menu.account" on the left panel 
    When I click "billing_information.billing_information_link" 
    When I click "billing_information.update_link" 
    Then I should be redirected to the UPDATE CREDIT CARD page 
    And The "creditcard.update_button" should be disabled 
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox 
    When I fill value "<invalid_expire_month>" to "checkout.expdate" textbox 
    When I fill value "checkout.cvc_value" to "checkout.cvc" textbox 
    And The "creditcard.update_button" should be enabled 
    When I click "creditcard.update_button" 
    Then I should see the message "Your card's expiration month is invalid."
    
    Examples: 
      | invalid_expire_month |
      | 0118             |
    
@function 
Scenario: Lack of CC info 
	Given I logged in iroad with user "teamowneruser" and password "validpassword" 
	When I click on the "left_menu.account" on the left panel 
	When I click "billing_information.billing_information_link" 
	When I click "billing_information.update_link" 
	Then I should be redirected to the UPDATE CREDIT CARD page 
	And The "creditcard.update_button" should be disabled 
	When I fill value "checkout.card_number_value" to "checkout.card_number" textbox 
	When I fill value "checkout.expdate_value" to "checkout.expdate" textbox 
	When I fill value " " to "checkout.cvc" textbox 
	And The "creditcard.update_button" should be disabled 
	
@function 
Scenario Outline: Cancel updating credit card
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click on the "left_menu.account" on the left panel
    And I click "billing_information.billing_information_link"
    Then I should see the message "Current credit card"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown
    When I click "billing_information.update_link"
    Then I should be redirected to the UPDATE CREDIT CARD page
    When I click "creditcard.cancel_button"
    Then I should not see the message "Credit card update"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown

    Examples: 
      | username      					| password      	|
      | teamowneruser 					| validpassword 	|
  		| premiumindividualuser1 	| validpassword 	|
  
  @function 
  Scenario: check the Stripe link
    Given I logged in iroad with user "teamowneruser" and password "validpassword"
    When I click on the "left_menu.account" on the left panel
    And I click "billing_information.billing_information_link"
    Then I should see the message "Current credit card"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown
    When I click "billing_information.update_link"
    Then I should be redirected to the UPDATE CREDIT CARD page
    When I click "creditcard.stripe_link" and switch to the second tab
    Then The url should be "https://stripe.com/"
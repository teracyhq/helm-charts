@test1
Feature: Billing Information
  
  As a logged-in premium user,
  	I want to access the Billing Information page
  	so that I could know and update my current credit card, and view the transaction history.

  @smoke
  Scenario Outline: view billing information as an owner or individual premium user
    When I go to "/login"
    When I fill value "<username>" to "login.email" textbox
    When I fill value "<password>" to "login.password" textbox
    And I click "login.login_button"
    When I click on the "left_menu.account" on the left panel
    When I click "billing_information.billing_information_link"
    Then I should see the message "Current credit card"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown
    Then I should see the message "Billing history"
    Then I click "billing_information.first_history"
    When I click "billing_information.view_invoice_link"
    When I click "billing_information.invoice_close_button"
    Then I should see the message "Invoice"
    When I click "billing_information.view_receipt_link"
    Then I should see the message "Receipt"
    When I click "billing_information.receipt_close_button"

    Examples: 
      | username               | password |
      | teamowneruser          |   123456 |
      | premiumindividualuser1 |   123456 |

  @smoke
  Scenario: Update credit card with valid info
    When I go to "/login"
    When I fill value "teamowneruser" to "login.email" textbox
    When I fill value "123456" to "login.password" textbox
    And I click "login.login_button"
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

  Scenario Outline: view invoice
  	# Login then go to the Billing tab
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click on the "left_menu.account" on the left panel
    And I click "billing_information.billing_information_link"
    Then I should see the message "Current credit card"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown
    When I click "billing_information.first_history"
    Then The element "billing_information.view_invoice_link" should be shown
    And The element "billing_information.view_receipt_link" should be shown
    # View invoice
    When I click "billing_information.view_invoice_link"
    Then I should see the message "Invoice"
    And I should see the message "From"
    And I should see the message "To"
    And I should see the message "Service provided"
    And I should see the message "Billing period"
    And I should see the message "Total due"
    And The "billing_information.invoice_print_button" should be enabled
    And The "billing_information.invoice_close_button" should be enabled
    # Close invoice
    When I click "billing_information.invoice_close_button"
    Then The element "billing_information.invoice_close_button" should not be shown
    And The element "billing_information.invoice_print_button" should not be shown
    And The element "billing_information.view_invoice_link" should be shown
    And The element "billing_information.view_receipt_link" should be shown
    
    Examples: 
      | username               | password      | 
      | teamowneruser          | validpassword | 
      | premiumindividualuser1 | validpassword | 
      
  Scenario Outline: view receipt
    # Login then go to the Billing tab
    Given I logged in iroad with user "<username>" and password "<password>"
    When I click on the "left_menu.account" on the left panel
    And I click "billing_information.billing_information_link"
    Then I should see the message "Current credit card"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown
    When I click "billing_information.first_history"
    Then The element "billing_information.view_invoice_link" should be shown
    And The element "billing_information.view_receipt_link" should be shown
    # View receipt
    When I click "billing_information.view_receipt_link"
    Then I should see the message "Receipt"
    And I should see the message "From"
    And I should see the message "To"
    And I should see the message "Service provided"
    And I should see the message "Billing method"
    And I should see the message "Total due"
    And I should see the message "Paid"
    And The "billing_information.receipt_print_button" should be enabled
    And The "billing_information.receipt_close_button" should be enabled
    # Close receipt
    When I click "billing_information.receipt_close_button"
    Then The element "billing_information.receipt_close_button" should not be shown
    And The element "billing_information.receipt_print_button" should not be shown
    And The element "billing_information.view_invoice_link" should be shown
    And The element "billing_information.view_receipt_link" should be shown
    
    Examples: 
      | username               | password      | 
      | teamowneruser          | validpassword | 
      | premiumindividualuser1 | validpassword |

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

  # Need a card number which is locked
  @production @pending
  Scenario: Update credit card with locked card number
    Given I am at "/account/billing"
    When I click "Update" link
    Then I should be redirected to the "UPDATE CREDIT CARD" page
    When I fill in valid card number but the card is locked
    And I fill valid values into all other fields
    And I click Save
    Then I should see the message "Your card was declined."

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

  # The system restricts users input month, so users can only input month from 01 to 12
  # This case should be removed from functionals tests
  @wip
  Scenario: Update credit card with invalid expired month
    Given I am at "/account/billing"
    When I click "Update" link
    Then I should be redirected to the "UPDATE CREDIT CARD" page
    When I input the valid cc number and CVC
    And I input invalid month, valid year
    Then The "Save" button should be enabled
    When I click Save
    Then I should see the message "Your card's expiration month is invalid."

  Scenario Outline: update cc with any empty required fields
    Given I logged in iroad with user "teamowneruser" and password "validpassword"
    When I click on the "left_menu.account" on the left panel
    And I click "billing_information.billing_information_link"
    Then I should see the message "Current credit card"
    And The element "billing_information.visa" should be shown
    And The element "billing_information.update_link" should be shown
    When I click "billing_information.update_link"
    Then I should be redirected to the UPDATE CREDIT CARD page
    When I fill value "checkout.card_number_value" to "checkout.card_number" textbox
    And I fill value "<invalid_expire_year>" to "checkout.expdate" textbox
    And I fill value "checkout.cvc_value" to "checkout.cvc" textbox
    And The "creditcard.update_button" should be disabled
    
    Examples:
    	|	card_number				|	expired_date	|	cvc_number	|
			|	4242424242424242	|	01/2020				|							|
			|	4242424242424242	|								|		321				|
			|										|	01/2020				|		321				|
			|	4242424242424242	|								|							|
			|										|								|		321				|
			|										|	01/2020				|							|
			
			
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

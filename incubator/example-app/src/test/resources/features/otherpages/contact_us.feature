@test5
Feature: contact us 

	As a user,
    I want to send a message to the site admin
    so that I can contact him.

@smoke 
Scenario: successful message sending as an anonymous user 
	Given I am an anonymous user 
	When I click on the "left_menu.contact_us" on the left panel 
	Then I should be redirected to the "/contactus" 
	Then The "contact_us.send_button" should be disabled 
	When I fill value "{!auto,s5,n5}" to "contact_us.your_name" textbox 
	When I fill value "{!auto,s5,n5,!@gmail.com}" to "contact_us.email" textbox 
	When I fill value "{!auto,s5,n5}" to "contact_us.message" textbox 
	And I should see the message "info@iorad.com" 
	And I should see the message "(408) 634-6723" 
	And I click "contact_us.send_button" 
	And I should see the message "Thank you! We received your message and will reply as soon as possible!" 
	And I click "contact_us.close_button" 
	
	
@smoke 
Scenario: successful message sending as a logged in user 
	Given I am a logged in user 
	When I click on the "left_menu.contact_us" on the left panel 
	Then I should be redirected to the "/contactus" 
	Then The "contact_us.send_button" should be disabled 
	When I fill value "{!auto,s5,n5}" to "contact_us.message" textbox 
	Then The "contact_us.send_button" should be enabled 
	And I should see the message "info@iorad.com" 
	And I should see the message "(408) 634-6723" 
	And I click "contact_us.send_button" 
	And I should see the message "Thank you! We received your message and will reply as soon as possible!" 
	And I click "contact_us.close_button" 

@function
Scenario: Anonymous user - send message with empty info 
	Given I am an anonymous user 
	When I click on the "left_menu.contact_us" on the left panel  
	Then I should be redirected to the "/contactus" 
	Then The "contact_us.send_button" should be disabled 
	When I fill value "{! }" to "contact_us.your_name" textbox 
	When I fill value "{! }" to "contact_us.email" textbox 
	When I fill value "{! }" to "contact_us.message" textbox 
	Then The "contact_us.send_button" should be disabled 

@function	
Scenario Outline: Anonymous user - send message with invalid email 
	Given I am an anonymous user 
	When I click on the "left_menu.contact_us" on the left panel 
	Then I should be redirected to the "/contactus" 
	When I fill value "{!auto,s5,n5}" to "contact_us.your_name" textbox 
	When I fill value "<email>" to "contact_us.email" textbox 
	When I fill value "{!auto,s5,n5}" to "contact_us.message" textbox 
	Then I should see the message "Please enter a valid email address"
	Examples: 
      | email       | 
      | iorad  | 
      | iorad.com | 
      | iorad@gmail | 
 
@function     
Scenario: send message with empty content 
	Given I am a logged in user 
	When I click on the "left_menu.contact_us" on the left panel  
	Then I should be redirected to the "/contactus" 
	Then The "contact_us.send_button" should be disabled 
	When I fill value "{! }" to "contact_us.message" textbox 
	Then The "contact_us.send_button" should be disabled 

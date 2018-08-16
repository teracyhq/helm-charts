@test6 
Feature: Navigate between pages when user has not logged in yet 

	As an anonymous user,
  I want to navigate between pages
  so that I can see the content of each page.

Background: 
	Given I am an anonymous user 
	
	#do not add extension
@smoke @chrome @wip 
Scenario: homepage on chrome when iorad chrome extension is not added 
	Given I am at "/" 
	And I haven't added the iorad chrome extension 
	Then I should see the homepage content 
	And I should see the "iorad capture for chrome" button 
	And I should see Log In and Sign Up link on the right top corner 
	When I click the "iorad capture for chrome" button 
	Then The iorad chrome extension pop-up should appear 
	When I follow the steps to add the iorad extension 
	Then The extension should be added to the chrome 
	And The https://start.iorad.com/installed page should be opened a a new tab 
	When I click RELOAD YOUR BROWSER button 
	Then The browser should be refreshed 
	And The start.iorad.com page should be changed into "https://start.iorad.com/done" 
	And The capture guide step should be shown on the page 
	When I back to the iorad homepage 
	Then The "iorad capture for chrome" button should be changed into "Capture" 
	When I click Capture 
	Then I should be redirected to the Log In screen 
	
	#do not add extension
@smoke @firefox @wip 
Scenario: homepage on firefox when iorad firefox extension is not added 
	Given I am at "/" 
	And I haven't added the iorad firefox extension 
	Then I should see the homepage content 
	And I should see the "iorad capture for firefox" button 
	And I should see Log In and Sign Up link on the right top corner 
	When I click the "iorad capture for firefox" button 
	Then The addons page with iorad capture addon should be opened in a new tab 
	And I click Add to Firefox button on the page 
	And I follow the steps to add addon 
	Then The extension should be added to the firefox 
	And The https://start.iorad.com/installed page should be opened a a new tab 
	When I click RELOAD YOUR BROWSER button 
	Then The browser should be refreshed 
	And The start.iorad.com page should be changed into "https://start.iorad.com/done" 
	And The capture guide step should be shown on the page 
	When I back to the iorad homepage 
	Then The "iorad capture for firefox" button should be changed into "Capture" 
	When I click Capture 
	Then I should be redirected to the Log In screen 
	
@smoke @edge @wip 
Scenario: homepage on edge when iorad edge extension is not added 
	Given I am at "/" 
	And I haven't added the iorad edge extension 
	Then I should see the homepage content 
	And I should see the "iorad capture for edge" button 
	And I should see Log In and Sign Up link on the right top corner 
	When I click the "iorad capture for edge" button 
	Then The addons page with iorad capture addon should be opened in a new tab 
	And I click Add to Edge button on the page 
	And I follow the steps to add addon 
	Then The extension should be added to the edge 
	And The https://start.iorad.com/installed page should be opened a a new tab 
	When I click RELOAD YOUR BROWSER button 
	Then The browser should be refreshed 
	And The start.iorad.com page should be changed into "https://start.iorad.com/done" 
	And The capture guide step should be shown on the page 
	When I back to the iorad homepage 
	Then The "iorad capture for edge" button should be changed into "Capture" 
	When I click Capture 
	Then I should be redirected to the Log In screen 
	
@chrome @firefox @edge @wip
Scenario: check the display of the "iorad capture for [browser]" button 
	Given I am at "/" 
	Then I should see the homepage content 
	Then I scroll down 
	Then I scroll down 
	Then I scroll down 
	And The element "home_page.capture_button" should be shown 
	When I click "home_page.capture_button" 
	Then I should be redirected to the "Sign Up" screen 
	
@chrome @wip @function 
Scenario: 
	check the display of the Capture button after adding the iorad extension 
	Given I am at "/" 
	And I have added the iorad chrome extension 
	When I scroll down 
	And I scroll up 
	Then I should see the "Capture" button floating on the top right corner 
	
	#do not install extension
@firefox @safari @IE11 @wip @function 
Scenario: check the display of the Capture button 
	Given I am at "/" 
	When I scroll down 
	And I scroll up 
	Then I should see the "Capture" button floating on the top right corner 
	
@smoke 
Scenario: check Log In link on the homepage 
	Given I am at "/" 
	When I click on the "left_menu.login" on the left panel 
	Then I should see the Log in tab content 
	
@smoke 
Scenario: check Sign Up link on the homepage 
	Given I am at "/" 
	When I click on the "left_menu.signup" on the left panel 
	Then I should see the sign up page content 
	
	#do not install extension
@function 
Scenario: check the down-arrow on the homepage 
	Given I am at "/" 
	When I click "home_page.arrow_scroll_down" 
	Then I should see the message "7,000+ companies use iorad." 

	#do not install extension
@firefox @safari @IE11 @wip @function 
Scenario: check the display of the Capture button 
	Given I am at "/" 
	When I click "home_page.arrow_scroll_down" 
	And I scroll up 
	Then I should see the "Capture" button floating on the top right corner 

@function 
Scenario: play videos on homepage 
	Given I am at "/" 
	And I click "home_page.play_video_button" 
	And switch to "home_page.video_frame" frame 
	Then I click "home_page.pause_video" 
	Then I click "home_page.play_video" 
	
@function 
Scenario: open/ close the left panel on homepage 
	Given I am at "/" 
	When I click "left_menu.left_menu_icon" 
	Then The element "left_menu.left_menu_panel" should be shown 
	When I click "left_menu.x_icon" 
	Then The element "left_menu.left_menu_panel" should not be shown 
	
@smoke 
Scenario: sign up page 
	Given I am at "/signup" 
	Then I should see the sign up page content 
	Then The element "login.login_tab" should be shown 
	And I click "login.login_tab" 
	And I click "signup.signup_tab" 
	
@smoke 
Scenario: log in page 
	Given I am at "/login" 
	Then I should see the Log in tab content 
	Then The element "signup.signup_tab" should be shown 
	And I click "signup.signup_tab" 
	And I click "login.login_tab" 
	
@smoke 
Scenario: pricing page 
	Given I am at "/pricing" 
	Then I should see the pricing page content 
	Then The element "pricing.go_premium_button" should be shown 
	Then The element "pricing.go_live_button" should be shown 
	Then The element "pricing.contact_us_button" should be shown 
	When I click "pricing.go_premium_button" 
	Then I should see the Log in tab content 
	When I am at "/pricing" 
	When I click "pricing.go_live_button" 
	Then I should see the Log in tab content 
	When I am at "/pricing" 
	When I click "pricing.contact_us_button" 
	Then I should see the contact us page content 
	
@smoke 
Scenario: FAQ page 
	Given I am at "/faq" 
	Then I should see the Frequently Asked Questions page content 
	
@smoke 
Scenario: about us page 
	Given I am at "/about" 
	Then I should see the about us page content 
	
@smoke 
Scenario: contact us page 
	When I click on the "left_menu.contact_us" on the left panel 
	Then I should see the contact us page content 
	
@smoke 
Scenario: Privacy policy page 
	Given I am at "/termsconditions" 
	Then I should see the Terms of use and Privacy policy page content 
	
@smoke 
Scenario: forgot password page 
	Given I am at "/resetPassword/" 
	Then I should see the forgot password page content 
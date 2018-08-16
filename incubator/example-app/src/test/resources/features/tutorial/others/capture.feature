@wip 
@windows 
@mac 
Feature: tutorial creation 

	As a logged-in user,
    I want to create a tutorial
    so that I could show it to others.

Background: 
	Given I am a logged-in user 
	
@smoke @chrome 
Scenario: Add iorad chrome extension from the Choose mode page 
	Given I havenn't installed the iorad chrome extension 
	When I click Capture on the left panel or on My Tutorials page 
	Then I should be redirected to the What are you capturing? page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	And I should see the "Add iorad Live to Chrome" button 
	When I click "Add iorad live to Chrome" 
	Then I should see the iorad extension pop-up 
	When I click Add extension 
	Then The browser should be auto-refereshed 
	And The iorad capture extension should be launched 
	And The iorad extension icon should be added to the right corner of Chrome 
	And I should see the "iorad's ready to go!" notification 
	And I should see the "Start Automatic Capture" button 
	When I click Start Automatic Capture button 
	Then I should see "Capturing starts in..." 
	And On the count down 3 - 1, the Capture connected screen should be shown 
	And I should be able to capture on any website 
	
@smoke @firefox 
Scenario: Add iorad firefox extension from the Choose mode page 
	Given I havenn't installed the iorad chrome extension 
	When I click Capture on the left panel or on My Tutorials page 
	Then I should be redirected to the What are you capturing? page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	And I should see the "Add iorad Live to Firefox" button 
	When I click "Add iorad live to Firefox" 
	Then The Adds-on page having iorad adds-on should be opened in a new tab 
	When I click Add to Firefox 
	And I add iorad adds-on as the guide 
	Then The browser should be auto-refereshed 
	And The "Add iorad Live to Firefox" button should be changed into "Launch Web Capture" 
	And The iorad extension icon should be added to the right corner of Firefox 
	And I should see the "iorad's ready to go!" notification on the What are you capturing page 
	When I click "Launch Web Capture" 
	Then I should be redirected to the Connecting page 
	When I click Start Automatic Capture button 
	Then I should see "Capturing starts in..." 
	And On the count down 3 - 1, the Capture connected screen should be shown 
	And I should be able to capture on any website 
	
	
@smoke @chrome 
Scenario: Create tutorial when iorad chrome extension is added 
	Given I added iorad chrome extension 
	When I click Capture on the left panel or on My Tutorials page 
	Then I should be redirected to the What are you capturing? page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	And I should see the "Launch Web Capture" button 
	When I click the "Launch Web Capture" button 
	Then The iorad capture extension should be launched 
	When I click Start Automatic Capture button 
	Then I should see Capture start in... 
	And On the count down 3 - 1, the Capture connected screen should be shown 
	And I should be able to make the tutorial 
	
Scenario: Create tutorial when iorad app is not added yet 
	Given I haven't add the iorad app 
	When I click Capture on the left panel or on My Tutorials page 
	Then I should be redirected to the What are you capturing? page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	When I navigate to Desktop tab 
	Then I should see the "Launch Desktop capture" button 
	When I click the "Launch Desktop capture" button 
	Then I should be redirected to the Conecting page 
	And I should see the spinning icon 
	And I should see the text "Not installed? Grab it." 
	When I click the "Grab it" link 
	Then I should be redirected to the Download page 
	And The downloaded iorad app file should be launched to save after some seconds 
	
Scenario: Check Connection Failed 
	Given I haven't add the iorad app 
	When I click Capture on the left panel or on My Tutorials page 
	Then I should be redirected to the What are you capturing? page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	When I navigate to Desktop tab 
	Then I should see the "Launch Desktop capture" button 
	When I click the "Launch Desktop capture" button 
	Then I should be redirected to the Conecting page 
	And I should see the spinning icon 
	And I should see the text "Not installed? Grab it." 
	When I don't click Grab it and wait for some seconds 
	Then I should see the "Connection Failed" screen 
	And I should see the Capture link 
	And I should see the Try connecting again button 
	When I click Try Connecting again 
	Then I should be back to the Connecting page 
	
Scenario: Check the Capture link on the Connection Failed 
	Given I haven't add the iorad app 
	When I click Capture on the left panel or on My Tutorials page 
	Then I should be redirected to the What are you capturing? page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	When I navigate to Desktop tab 
	Then I should see the "Launch Desktop capture" button 
	When I click the "Launch Desktop capture" button 
	Then I should be redirected to the Conecting page 
	And I should see the spinning icon 
	And I should see the text "Not installed? Grab it." 
	When I don't click Grab it and wait for some seconds 
	Then I should see the "Connection Failed" screen 
	And I should see the Capture link 
	And I should see the Try connecting again button 
	When I click the Capture link 
	Then I should be redirected to the Download page 
	And The downloaded iorad app file should be launched to save after some seconds 
	
Scenario: Check the links on the Download page 
	Given I haven't add the iorad app 
	When I click Capture on the left panel or on My Tutorials page 
	Then I should be redirected to the What are you capturing? page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	When I navigate to Desktop tab 
	Then I should see the "Launch Desktop capture" button 
	When I click the "Launch Desktop capture" button 
	Then I should be redirected to the Conecting page 
	And I should see the spinning icon 
	And I should see the text "Not installed? Grab it." 
	When I click the "Grab it" link 
	Then I should be redirected to the Download page 
	And The downloaded iorad app file should be launched to save after some seconds 
	And I should see the message "If it's not started yet you can try again." 
	And I should see the Back button to back the Choose mode page 
	And I should see the message "Already installed? Click to connect." 
	And The "Click" link should be reffered to the Connecting page 
	When I click "try again" link 
	Then The downloaded iorad app file should be launched to save 
	
@smoke 
Scenario: Capture tutorial when iorad app is installed 
	Given I added the iorad app 
	When I click Capture on the left panel or on My Tutorials page 
	Then I should be redirected to the What are you capturing? page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	When I navigate to Desktop tab 
	Then I should see the "Launch Desktop capture" button 
	When I click the "Launch Desktop capture" button 
	Then I should be redirected to the Conecting page 
	And The iorad app should be launched after some seconds 
	And The Connecting page should be changed into "Capture connected " 
	When I capture some screens 
	And I click Done 
	Then I should be redirected to the Editor page 
	
@smoke @chrome 
Scenario: create a tutorial from /tutorials page 
	Given I am at /tutorials page 
	And I installed the iorad app 
	And I added the iorad chrome extension 
	Then I should see "Capture" button 
	When I click on "Capture" button 
	Then The loading screen "Good things come to those who wait. The iorad editor is loading." should be shown for some seconds 
	Then I should be redirected to the "What are you capturing?" page 
	And I should see two tabs: Web and Desktop 
	And The Web tab is opened by default 
	And I should see the "Launch iorad live to chrome" button 
	When I navigate to Desktop tab 
	Then I should see the "Launch iorad for desktop" 
	When I click 
	And I should be able to capture with the iorad app or the iorad chrome extension 
	When I finished capturing 
	Then I should be redirected to the Editor page 
	
@smoke @IE @safari 
Scenario: create a tutorial from /tutorials page 
	Given I am at /tutorials page 
	And I installed the iorad capture app 
	Then I should see "Capture" button 
	When I click on "Capture" button 
	Then The loading screen "Good things come to those who wait. The iorad editor is loading." should be shown for some seconds 
	And I should be redirected to the Connecting page 
	And The capture frame should launch 
	When I finished capturing 
	Then I should be redirected to the Editor page 
	
@smoke 
@chrome 
Scenario: create a tutorial from the slide out menu 
	Given I am at any page 
	When I open the slide out menu 
	Then I should see "Capture" button on the slide out menu 
	When I click the "Capture" button 
	Then The loading screen "Good things come to those who wait. The iorad editor is loading." should be shown for some seconds 
	And I should be redirected to the Choose mode page 
	When I finished capturing 
	Then I should be redirected to the Editor page 
	
@smoke 
@firefox @safari 
Scenario: create a tutorial from the slide out menu 
	Given I am at any page 
	When I open the slide out menu 
	Then I should see "Capture" button on the slide out menu 
	When I click the "Capture" button 
	Then The loading screen "Good things come to those who wait. The iorad editor is loading." should be shown for some seconds 
	And I should be redirected to the Connecting or Download page (if I haven't installed the iorad app) 
	
	
@smoke 
Scenario: unverified user creates tutorial 
	Given I created a new account 
	And I haven't activate my account 
	And I am logged in 
	And I created 1 tutorial 
	When I click New Tutorial 
	Then I should see an message "You'll need to confirm your email first. Resend verification" 
	And The screen should be locked and masked 
	And I should not be able to do any actions 
	When I click the Resend verification link 
	Then I should see the message "Verification email sent." 
	And An activation email should be sent to my email address 
	
@chrome @smoke 
Scenario: Download and install iorad capture 
	Given I haven't downloaded and installed iorad capture 
	When I click the "Capture" button 
	Then I should be redirected to the Choose mode page 
	When I click Download icon or Use the smaller install file 
	Then I should be redirected to Downloading page 
	And The capture installer should be downloaded successfully 
	When I click "restart the download" 
	Then The capture installer should be downloaded 
	When I open the downloaded file and follow the instruction 
	Then The iorad capture should be installed successfully 
	
@chrome @smoke 
Scenario: Add iorad chrome extension 
	Given I haven't downloaded and installed iorad capture 
	When I click "Capture" button 
	Then I should be redirected to the Choose mode page 
	And I should see the red button "Get just the chrome extension" 
	When I click "Get just the chrome extension" button 
	Then The chrome extension page should be opened in a new tab 
	When I follow the instruction 
	Then The iorad chrome extension should be added to the Chrome browser 
	And I should be able to capture with the iorad chrome extension 
	
Scenario: Restart capturing 
	Given I opened the iorad capture 
	When I cancel capturing 
	Then I should be redirected to the Capture Canceled page 
	When I click Restart Capture 
	Then The capture frame should be opened 
	
Scenario: Navigate to My tutorials page from the Capture Canceled page 
	Given I opened the iorad capture 
	When I cancel capturing 
	Then I should be redirected to the Capture Canceled page 
	When I click "View My tutorials" 
	Then I should be redirected to the My tutorials tab 
	
@chrome 
Scenario: Check the links when capturing with iorad extension 
	When I click iorad extension icon 
	Then The instruction to manage capturing should be shown 
	When I start capturing 
	And I click the iorad extension icon on the browser 
	Then The capture should be paused 
	And I should see the links: Done, Capture, Restart and Cancel 
	When I click a link 
	Then The link should work properly 
	
Scenario: Check the links when capturing with iorad app 
	Given I am capturing with the iorad app 
	And The capture frame is opened 
	When I click capture icon on the bottom frame 
	Then I should see the links: Cancel, Restart, Capture size, Full screen, shortcut key Combo, Following mouse, mask inside when paused, mask outside during capture, and Help 
	When I click any link 
	Then The link should work properly 
	
@chrome 
Scenario: Check the Alert link 
	Given I am capturing with the iorad app on Chrome 
	Then I should see the red text "Alert!" on the capture bottom bar 
	When I click Alert 
	Then I should see the alert screen 
	When I click "I got it" 
	Then The alert screen should be closed 
	And I should see the red text "Alert" in the next capture on chrome 
	
@chrome 
Scenario: Hide the alert text when capturing with the iorad capp on chrome 
	Given I am capturing with the iorad app on Chrome 
	Then I should see the red text "Alert!" on the capture bottom bar 
	When I click Alert 
	Then I should see the alert screen 
	When I click "Don't show it again" 
	And I click "I got it" 
	Then The alert screen should be closed 
	And I should not see the red text "Alert" in the next capture on chrome 
	
@firefox @safari 
Scenario: Check the Alert! text on capture 
	Given I am capturing with the iorad app on Firefox / Safari 
	Then I should not see the red text "Alert!" on the capture bottom bar 
	
	# ref: https://github.com/iorad/iorad/issues/3810
	# For extension: need to check logged-in & anonymous users
Scenario: Restore capture from extension and capture app 
	When I create a new tutorial with desktop or extension 
	And I reload the page/shut down network connection before the tutorial saved 
	And I return back to the tutorial (i.e. via refresh) 
	Then I should see the notification "Editor was closed during an unsaved capture and is going to be restored now" on the tutorial Editor 
	And I should see the notification "Capture data successfully restored" 
	
@wip 
Scenario:
Check if iorad capture app is launched after removing the iorad extension 
	Given I installed iorad capture app and extension 
	When I log in 
	And I click Capture 
	When I click the "Launch Web Capture" button 
	Then The iorad capture extension should be launched 
	When I click the iorad extension icon on the browser 
	And The iorad extension panel should be shown 
	When I right-click the iorad extension ion the browser 
	And I remove the iorad extension from the browser 
	And I click Start Automatic Capture /Cancel or X icon to close the extension panel 
	#ref: need to recheck the outcome
	Then Nothing happens 
	When I refresh the page 
	Then The iorad capture app should be launched
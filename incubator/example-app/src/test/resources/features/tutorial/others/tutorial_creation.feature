#@windows
#@mac
#Feature: tutorial creation
#
    #As a logged-in user,
    #I want to create a tutorial
    #so that I could show it to others.
#
    #Background:
        #Given I am a logged in user
#
    #@smoke @chrome
    #Scenario: create a tutorial from /tutorials page
        #Given Open browser with adding iorad extension
          #And I am at "/tutorials"
          #And I installed the iorad app
         #Then I should see the "homepage.Capture button"
         #When I click "homepage.Capture button"
         #Then I should be redirected to the Choose mode page
          #And I should be able to capture with the iorad app or the iorad chrome extension
         #When I finished capturing
         #Then I should be redirected to the Editor page
#
    #@smoke @firefox @IE @safari
    #Scenario: create a tutorial from /tutorials page
        #Given I am at "/tutorials"
          #And I installed the iorad capture app
         #Then I should see the "homepage.Capture button"
         #When I click "homepage.Capture button"
         #Then I should be redirected to the Connecting page
          #And The capture frame should launch
         #When I finished capturing
         #Then I should be redirected to the Editor page
#
    #@smoke
    #@chrome
    #Scenario: create a tutorial from the slide out menu
        #Given I am at "/tutorials"
         #When I click on the "Capture" on the left panel
         #Then I should be redirected to the Choose mode page
         #When I finished capturing
         #Then I should be redirected to the Editor page
#
    #@smoke
    #@firefox @safari
    #Scenario: create a tutorial from the slide out menu when installed the iorad app
    #		Given I am at "/tutorials"
          #And I installed the iorad app
         #When I click on the "Capture" on the left panel
         #Then I should be redirected to the Connecting page
    #
    #@smoke
    #@firefox @safari
    #Scenario: create a tutorial from the slide out menu when not installed the iorad app
        #Given I am at "/tutorials"
          #And I haven't installed the iorad app
         #When I click on the "Capture" on the left panel
         #Then I should be redirected to the Download page
#
#
    #@smoke
    #Scenario: unverified user creates tutorial
        #Given I created a new account
          #And I haven't activate my account
          #And I am a logged in user
          #And I created 1 tutorial
         #When I click New Tutorial
         #Then I should see the message "You'll need to confirm your email first. Resend verification"
          #And The screen should be locked and masked
          #And I should not be able to do any actions
         #When I click the Resend verification link
         #Then I should see the message "Verification email sent."
          #And An activation email should be sent to my email address

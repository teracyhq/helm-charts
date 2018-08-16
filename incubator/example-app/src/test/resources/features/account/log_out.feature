@test1
Feature: log out
  
    As a logged-in user,
    I want to sign out,
    so that I can ensure the privacy and security for my account.

  Background: 
    Given I am a logged in user

  @smoke
  Scenario: successful log out
    Given I go to "/"
    When I click on the "left_menu.logout" button from the slide out menu
    Then I should be logged out and redirected to the home page

#refer: https://github.com/iorad/iorad-extension/wiki/How-to-connect-a-website
@smoke 
Feature: Connect iorad with other pages 

	As a user,
    I want to use the Connect feature
    so that everyone can play my live tutorials from the iorad widget.
    
#https://github.com/iorad/iorad-extension/wiki/How-to-connect-a-website
@test7
Scenario Outline: Connect the website 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When Get valid connect your website domain and store in variable "varDomain" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	When I fill variable "varDomain" to "iorad_connect_website.domain_textbox" textbox 
	Then The "iorad_connect_website.connect_your_website_button" should be enabled 
	And I click "iorad_connect_website.connect_your_website_button" 
	And The "iorad_connect_website.combine_interco_checkbox" checkbox should be unchecked 
	And The "iorad_connect_website.google_translate_checkbox" checkbox should be unchecked 
	And I click by javascript "iorad_connect_website.i_pass_it_button" 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	And The element "iorad_connect_website.edit_button" should be shown 
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
		
@test2 
Scenario Outline: cancel connecting your website with iorad 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	When I click "iorad_connect_website.cancel_button" 
	Then I should be redirected to the "/connectIntegrations" page 
	And The element "iorad_connect_website.edit_button" should not be shown 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
		
@test2 
Scenario Outline: Input invalid domain for the website when domain contains space character 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	Then The "iorad_connect_website.connect_your_website_button" should be disabled 
	When I fill value "teracy . com" to "iorad_connect_website.domain_textbox" textbox 
	When I click "iorad_connect_website.connect_your_website_button" 
	Then I should see the message "This is not a valid domain." 
	And The "iorad_connect_website.connect_your_website_button" should be disabled 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
		
@test2 
Scenario Outline: Input invalid domain for the website when domain contains special character 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	Then The "iorad_connect_website.connect_your_website_button" should be disabled 
	When I fill value "teracy@com" to "iorad_connect_website.domain_textbox" textbox 
	When I click "iorad_connect_website.connect_your_website_button" 
	Then I should see the message "This is not a valid domain." 
	And The "iorad_connect_website.connect_your_website_button" should be disabled 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
								
@test2 
Scenario Outline: The wideget code is not pasted to the site yet 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	When I fill value "iorad_connect_website.valid_domain" to "iorad_connect_website.domain_textbox" textbox 
	And I click "iorad_connect_website.connect_your_website_button" 
	And Close the iorad widget 
	And I click "iorad_connect_website.i_pass_it_button" 
	Then I should see the message "Connect failed: Widget code not found on the remote webpage" 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
		
@test3 
Scenario Outline: Change the widget color 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	When I fill value "iorad_connect_website.valid_domain" to "iorad_connect_website.domain_textbox" textbox 
	Then The "iorad_connect_website.connect_your_website_button" should be enabled 
	And I click "iorad_connect_website.connect_your_website_button" 
	When Close the iorad widget 
	When I click "iorad_connect_website.main_color_button" 
	Then The element "iorad_connect_website.color_picker" should be shown 
	When I click "iorad_connect_website.color_picker_ok_button" 
	Then The element "iorad_connect_website.color_picker" should not be shown 
	When I click "iorad_connect_website.highlight_color_button" 
	Then The element "iorad_connect_website.color_picker" should be shown 
	When I click "iorad_connect_website.color_picker_ok_button" 
	Then The element "iorad_connect_website.color_picker" should not be shown 
	#When I change the color
	#Then Just the main color should be applied to the widget for preview
	
	#Then Everyone should see the color changes
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
@test3 
Scenario Outline: Cancel changing the widget color 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	When I fill value "iorad_connect_website.valid_domain" to "iorad_connect_website.domain_textbox" textbox 
	Then The "iorad_connect_website.connect_your_website_button" should be enabled 
	And I click "iorad_connect_website.connect_your_website_button" 
	When Close the iorad widget 
	When I click "iorad_connect_website.main_color_button" 
	Then The element "iorad_connect_website.color_picker" should be shown 
	When I click "iorad_connect_website.color_picker_cancel_button" 
	Then The element "iorad_connect_website.color_picker" should not be shown 
	When I click "iorad_connect_website.highlight_color_button" 
	Then The element "iorad_connect_website.color_picker" should be shown 
	When I click "iorad_connect_website.color_picker_cancel_button" 
	Then The element "iorad_connect_website.color_picker" should not be shown 
	#Then Just the main color should be applied to the widget for preview
	#Then The color changes should not be applied for the widget anymore
	#And The previous color should be kept
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
		
#https://github.com/iorad/iorad/issues/4523
#Chat widget is not displayed
@fail @test3 
Scenario Outline: Open the chat window 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	When I fill value "iorad_connect_website.valid_domain" to "iorad_connect_website.domain_textbox" textbox 
	Then The "iorad_connect_website.connect_your_website_button" should be enabled 
	And I click "iorad_connect_website.connect_your_website_button" 
	When Open the iorad widget 
	And The element "iorad_connect_website.tutorial_widget_frame" should be shown 
	And The "iorad_connect_website.combine_interco_checkbox" checkbox should be checked 
	When I click "iorad_connect_website.chat_with_us_button" 
	When switch to "iorad_connect_website.chat_widget_frame" frame 
	Then The element "iorad_connect_website.chat_with_us_window" should be shown 
	When switch back to main frame 
	When I click "iorad_connect_website.tutorials_button" 
	Then The element "iorad_connect_website.chat_with_us_window" should not be shown 
	And The element "iorad_connect_website.chat_with_us_button" should be shown 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
#https://github.com/iorad/iorad/issues/4523
#Chat widget is not displayed
@fail @test3 
Scenario Outline: Uncheck the "combine iorad with Intercome" checkbox 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	When I fill value "iorad_connect_website.valid_domain" to "iorad_connect_website.domain_textbox" textbox 
	Then The "iorad_connect_website.connect_your_website_button" should be enabled 
	And I click "iorad_connect_website.connect_your_website_button" 
	When Open the iorad widget 
	And The element "iorad_connect_website.tutorial_widget_frame" should be shown 
	And The "iorad_connect_website.combine_interco_checkbox" checkbox should be checked 
	When I uncheck "iorad_connect_website.combine_interco_checkbox" 
	Then The element "iorad_connect_website.tutorials_button" should not be shown 
	Then The element "iorad_connect_website.chat_with_us_button" should not be shown 
	Then The element "iorad_connect_website.chat_with_us_hidden_button" should be shown 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
	
@test3 
Scenario Outline: Check the "Add google translate" checkbox 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When Disconnect website 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_your_website_button" 
	Then I should be redirected to the "/connectIntegrations/direct/website" 
	When I fill value "iorad_connect_website.valid_domain" to "iorad_connect_website.domain_textbox" textbox 
	Then The "iorad_connect_website.connect_your_website_button" should be enabled 
	And I click "iorad_connect_website.connect_your_website_button" 
	When Open the iorad widget 
	And The element "iorad_connect_website.tutorial_widget_frame" should be shown 
	And The "iorad_connect_website.google_translate_checkbox" checkbox should be unchecked 
	When I check "iorad_connect_website.google_translate_checkbox" 
	When switch to "iorad_connect_website.tutorial_widget_frame" frame 
	Then The element "iorad_connect_website.google_translate_icon" should be shown 
	When I click "iorad_connect_website.google_translate_icon" 
	Then The element "iorad_connect_website.google_translate_popup" should be shown 
	And I click by javascript "iorad_connect_website.afrikaans_language" 
	And The element "iorad_connect_website.select_category_afrikaans" should be shown 
	When I click "iorad_connect_website.google_translate_icon" 
	Then The element "iorad_connect_website.google_translate_popup" should be shown 
	And I click by javascript "iorad_connect_website.english_language" 
	And The element "iorad_connect_website.select_category_english" should be shown 
	When I click "iorad_connect_website.google_translate_icon" 
	When switch back to main frame 
	When I uncheck "iorad_connect_website.google_translate_checkbox" 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
																				
#https://github.com/iorad/iorad/issues/4588
# don't know zendesk account and zendesk page
@fail @smoke 
Scenario: Connect the Zendesk page when already having the zendesk account 
Given I am logged-in as a free user / premium uer 
And I sign up an account on Zendesk page 
And I enabled the helpdesk on the Zendesk page 
And I activated the Zendesk account 
When I click Connect on the left panel 
Then I should be redirected to the Direct tab of the /connectIntegrations/direct page 
When I click Connect corresponding the Zendesk 
Then I should be redirected to the /connectIntegrations/direct/zendesk page 
And The Authenticate button is disabled 
When I input the domain of my Zendesk site 
Then The Authenticate button should be enabled 
When I click the Authenticate button 
Then I should be redirected to the Log In screen on the zendesk page 
When I log in successfully on the Zendesk page 
And I am back to the the /connectIntegrations/direct page 
Then I should see the Connected corresponding to the Zendesk 
																					
# don't know zendesk account and zendesk page
@test3 @fail 
Scenario Outline: Connect to the Zendesk page when having no zendesk account yet 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_zendesk_button" 
	Then I should be redirected to the "/connectIntegrations/direct/zendesk" 
	Then The "iorad_connect_zendesk.authenticate_button" should be disabled 
	When I fill value "iorad_connect_zendesk.no_account" to "iorad_connect_zendesk.zendesk_textbox" textbox 
	Then The "iorad_connect_zendesk.authenticate_button" should be enabled 
	#When I click "iorad_connect_zendesk.authenticate_button"
	
	#Then I should be redirected to the the zendesk page having Sign Up form
	#When I follow the instruction on the Zendesk
	#Then I should be able to connect the Zendesk with iorad
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
																						
@smoke @test3 
Scenario Outline: Input a invalid domain having spaces and special characters into Zendesk domain 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_zendesk_button" 
	Then I should be redirected to the "/connectIntegrations/direct/zendesk" 
	Then The "iorad_connect_zendesk.authenticate_button" should be disabled 
	When I fill value "testing  zendesk" to "iorad_connect_zendesk.zendesk_textbox" textbox 
	Then I should see the message "This is not a valid domain." 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
		
@smoke @test2 
Scenario Outline: cancel connect the Zendesk with iorad 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.connect_zendesk_button" 
	Then I should be redirected to the "/connectIntegrations/direct/zendesk" 
	When I click "iorad_connect_zendesk.cancel_button" 
	Then I should be redirected to the "/connectIntegrations" page 
	Then The element "iorad_connect.connect_zendesk_button" should be shown 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |
																										
@test7 
Scenario Outline: logged-in user checks the Request link 
	Given I logged in iroad with user "<username>" and password "<password>" 
	When I click on the "left_menu.connect" on the left panel 
	Then I should be redirected to the "/connectIntegrations/direct" page 
	When I click "iorad_connect.plugin_tab" 
	Then I should be redirected to the "/connectIntegrations/plugins" page 
	Then The element "iorad_connect.get_freshdesk_button" should be shown 
	Then The element "iorad_connect.get_zendesk_button" should be shown 
	Then The element "iorad_connect.get_wordpress_button" should be shown 
	Then The element "iorad_connect.get_confluence_server_button" should be shown 
	Then The element "iorad_connect.get_confluence_cloud_button" should be shown 
	Then The element "iorad_connect.get_jira_server_button" should be shown 
	When I click "iorad_connect.get_freshdesk_button" 
	Then I should be redirected to the "support.freshdesk.com" page in new tab 
	When I click "iorad_connect.get_zendesk_button" 
	Then I should be redirected to the "zendesk.com/apps/support/iorad/?source=app_directory" page in new tab 
	When I click "iorad_connect.get_wordpress_button" 
	Then I should be redirected to the "wordpress.org/plugins/iorad-editor/" page in new tab 
	When I click "iorad_connect.get_confluence_server_button" 
	Then I should be redirected to the "marketplace.atlassian.com/apps/1213532/instant-knowledge-base-solution-articles?hosting=server&tab=overview" page in new tab 
	When I click "iorad_connect.get_confluence_cloud_button" 
	Then I should be redirected to the "marketplace.atlassian.com/apps/1214248/iorad-confluence-cloud-plugin?hosting=cloud&tab=overview" page in new tab 
	When I click "iorad_connect.get_jira_server_button" 
	Then I should be redirected to the "marketplace.atlassian.com/apps/1213829/iorad-capture-steps?hosting=server&tab=overview" page in new tab 
	
	Examples: 
		| username              | password      |
		| freeverifieduser      | validpassword |
		| premiumindividualuser1 | validpassword |

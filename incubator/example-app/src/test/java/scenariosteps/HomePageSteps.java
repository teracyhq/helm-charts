package scenariosteps;

import java.util.Set;

import org.junit.Assert;
import org.openqa.selenium.WebElement;

import cucumber.api.java.en.When;
import iorad.page.IoradBase;
import iorad.utils.TestLogger;

public class HomePageSteps extends IoradBase {
	@When("^I should see the homepage content$")
	public void i_should_see_the_homepage_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("Share your application knowledge"));
		Assert.assertTrue(getTextOnPage("With our free extension, it takes 60 seconds to create guided"));
		Assert.assertTrue(getTextOnPage("7,000+ companies use iorad."));
	}

	@When("^I should see the sign up page content$")
	public void i_should_see_the_sign_up_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("signup.signup_button"));
		Assert.assertNotNull(waitForGetElementPresent("signup.public_name"));
		Assert.assertNotNull(waitForGetElementPresent("signup.email"));
	}

	@When("^(?:I should be redirected the Log In page|I should see the Log in tab content)$")
	public void i_should_see_the_log_in_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("login.login_button"));
		Assert.assertNotNull(waitForGetElementPresent("login.password"));
		Assert.assertNotNull(waitForGetElementPresent("login.email"));
	}

	@When("^(?:I should see the pricing page content|I should be redirected to the pricing page)$")
	public void i_should_see_the_pricing_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("Plans & Pricing"));
		Assert.assertTrue(getTextOnPage("All plans come with unlimited tutorials & learners"));
	}

	@When("^I should see the forgot password page content$")
	public void i_should_see_the_forgot_password_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("forgot_password.send_reset_link_button"));
		Assert.assertNotNull(waitForGetElementPresent("forgot_password.email"));
	}

	@When("^I should see the contact us page content$")
	public void i_should_see_the_contact_us_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("contact_us.message"));
		Assert.assertNotNull(waitForGetElementPresent("contact_us.send_button"));
	}

	@When("^I should see the Frequently Asked Questions page content$")
	public void i_should_see_the_frequently_asked_questions_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("Frequently Asked Questions"));
		Assert.assertTrue(getTextOnPage("You have 10 seconds. Why would I use this?"));
		Assert.assertTrue(getTextOnPage(
				"You want to show someone how to use an application but don’t have the time or the patience to copy/paste screenshots, fumble through a screencast or schedule a screenshare."));
	}

	@When("^I should see the about us page content$")
	public void i_should_see_the_about_us_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("The main idea behind iorad is time. How to save a lots of it."));
	}

	@When("^I should see the Terms of use and Privacy policy page content$")
	public void i_should_see_the_tearms_of_use_and_privacy_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage(
				"The Company may provide hyperlinks to third-party websites as a convenience to users of the Site. The Company does not control any third-party website and is not responsible for and makes no representations concerning the contents of any hyperlinked third-party website or any hyperlink in a hyperlinked site. The Company does not endorse, recommend or approve any third-party website or the contents of any third-party website hyperlinked from the Site. The Company shall have no liability to any entity for the content or use of the content available through such hyperlink."));
	}

	@When("^I should see the help page content in a new tab$")
	public void i_should_see_the_help_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		pause(2000);
		String base = driver.getWindowHandle();
		Set<String> set = driver.getWindowHandles();
		set.remove(base);
		driver.switchTo().window((String) set.toArray()[0]);
		Assert.assertTrue(getTextOnPage("Check the knowledge base."));
		driver.close();
		driver.switchTo().window(base);
	}

	@When("^I should see the blog content in a new tab$")
	public void i_should_see_the_blog_content_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		pause(2000);
		String base = driver.getWindowHandle();
		Set<String> set = driver.getWindowHandles();
		set.remove(base);
		driver.switchTo().window((String) set.toArray()[0]);
		Assert.assertTrue(getTextOnPage("About iorad"));
		driver.close();
		driver.switchTo().window(base);
	}

	@When("(?:^I should be redirected to the Integrations page$|^I should see the iorad Connect content$)")
	public void i_should_see_the_iorad_connect_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("iorad_connect.connect_zendesk_button"));
		Assert.assertNotNull(waitForGetElementPresent("iorad_connect.connect_your_website_button"));
	}

	@When("^I should see the Checkout page content$")
	public void i_should_see_the_checkout_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("Checkout"));
	}

	@When("(?:^I should see the My tutorials page content$|^I am at My tutorials page$|^I should be redirected to the My Tutorials$)")
	public void i_should_see_the_my_tutorials_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		swichBackToMainFrame();
		pause(2);
		Assert.assertNotNull(waitForGetElementPresent("tutorials.search_tutorials"));
	}

	@When("^I should see the Account Summary page content$")
	public void i_should_see_the_account_summary_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("my_plan.current_account_my_plan_tab"));
	}

	@When("^I should see the Plan page content$")
	public void i_should_see_the_plan_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("my_plan.your_current_plan_text"));
		Assert.assertNotNull(waitForGetElementPresent("my_plan.current_my_plan_tab"));
	}

	@When("^I should see the Quota page content$")
	public void i_should_see_quota_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("quota.quota_public"));
		Assert.assertNotNull(waitForGetElementPresent("quota.current_quota_tab"));
	}

	@When("^I should see the Personal Settings page content$")
	public void i_should_see_the_personal_setting_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("my_account.public_name"));
		Assert.assertNotNull(waitForGetElementPresent("my_account.company_name"));
		Assert.assertNotNull(waitForGetElementPresent("my_account.email"));
		Assert.assertNotNull(waitForGetElementPresent("my_account.avatar"));
	}

	@When("^I should see the Billing Information page content$")
	public void i_should_see_the_billing_information_page_content() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("billing_information.visa"));
		Assert.assertNotNull(waitForGetElementPresent("billing_information.update_link"));
		Assert.assertTrue(getTextOnPage("Current credit card"));
		Assert.assertTrue(getTextOnPage("Billing history"));
	}

	@When("(?:^I should see the Creators page content$|^I should be redirected to Creators page$)")
	public void i_should_see_the_creators_page_content() throws Throwable {
		Assert.assertTrue(getTextOnPage("My Team"));
	}

	@When("(?:^I should be reditected to the \"Invite Team Members\" page$|^I should navigate to the Invitations tab$)")
	public void i_should_be_redirected_to_invite_team_member_page_content() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("creators.invitation_remaining"));
		// Input Email Textbox
		Assert.assertNotNull(waitForGetElementPresent("creators.invite_placeholder"));
		// Send Invitation
		Assert.assertNotNull(waitForGetElementPresent("creators.send_invite_button"));
	}

	@When("(?:^I should be redirected to the Finish page of the tutorial$|^I should be redirected to the Finish page$)")
	public void i_should_be_redirected_to_the_finish_page_of_the_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		pause(2000);
		switchToIFrame("tutorials.iorad_app_iframe");
		if (waitForGetElementPresent("tutorials.edit_preview_and_finish_button") != null)
			click("tutorials.edit_preview_and_finish_button");
		Assert.assertTrue(getTextOnPage("Finish"));
		// swichBackToParentFrame();
	}

	@When("^I should be redirected to the Share & Access tab$")
	public void i_should_be_redirected_to_the_share_access_tab() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		swichBackToMainFrame();
		Assert.assertTrue(getTextOnPage("Share"));
	}

	@When("^I should be redirected to the player page of the tutorial$")
	public void i_should_be_redirected_to_the_player_page_of_the_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		try {
			pause(2000);
			String base = driver.getWindowHandle();
			Set<String> set = driver.getWindowHandles();
			set.remove(base);
			driver.switchTo().window((String) set.toArray()[0]);
		} catch (Exception e) {
			TestLogger.info("Do not need to change to new tab");
		}
		switchToIFrame("tutorials.iorad_app_iframe");
		Assert.assertNotNull(waitForGetElementPresent("tutorials.try_icon"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.view_icon"));
	}

	@When("(?:^I should be redirected to the Choose page$|^I should be redirected to the Editor page to create new tutorial$)")
	public void i_should_be_redirected_to_the_editor_page_to_create_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		switchToIFrame("tutorials.iorad_app_iframe");
		Assert.assertTrue(getTextOnPage("What are you capturing?"));
	}

	@When("^I should be redirected to the Editor page(?: to edit that tutorial)?$")
	public void i_should_be_redirected_to_the_editor_page_to_edit_that_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		switchToIFrame("tutorials.iorad_app_iframe");
		Assert.assertNotNull(waitForGetElementPresent("tutorials.edit_preview_and_finish_button"));
	}

	@When("^I should be redirected to the tutorial editor$")
	public void i_should_be_redirected_to_the_tutorial_editor() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		switchToIFrame("option_varies.iorad_app_iframe");
		Assert.assertNotNull(waitForGetElementPresent("option_varies.flexible_learner_choice_link"));
		Assert.assertNotNull(waitForGetElementPresent("option_varies.preview_and_finish_button"));
	}

	@When("^I open the Audio Editor form?$")
	public void i_should_be_redirected_to_the_audio_editor_form() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		click("tutorials.add_audio_link");
		swichBackToMainFrame();
		Assert.assertNotNull(waitForGetElementPresent("tutorials.add_audio_form"));
	}

	@When("^I should be redirected to the Audio Editor page?$")
	public void i_should_be_redirected_to_the_audio_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.add_audio_form"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.add_audio_generate_all_step"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.add_audio_close_button"));
	}

	@When("^I should be redirected to Shared Edit tab$")
	public void i_should_be_redirected_to_shared_edit_tab() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.current_share_edit_tab"));
	}

	@When("^I should be redirected to the Shared page$")
	public void i_should_be_redirected_to_shared_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.current_shared_tab"));
	}

	@When("^I should be redirected to the Shared Editor page$")
	public void i_should_be_redirected_to_shared_editor_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.share_tutorial_popup_header"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.tab_share_tutorial_pane_link"));
	}

	@When("^I should be redirected to My tutorials tab$")
	public void i_should_be_redirected_to_my_tutorials_tab() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.current_my_tutorial_tab"));
	}

	@When("^I should be redirected to the My Learning page$")
	public void i_should_be_redirected_to_the_my_learning_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.current_my_learning_tab"));
	}

	@When("^I should be redirected to the Connecting page$")
	public void i_should_be_redirected_to_the_connecting_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("CONNECTING"));
		Assert.assertTrue(getTextOnPage("Not able to launch"));
	}

	@When("^I should be redirected to the Download page$")
	public void i_should_be_redirected_to_the_download_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("Download"));
	}

	@When("^I should be redirected to the Cancelling your premium membership page$")
	public void i_should_be_redirected_to_the_cancel_your_premium_membershipn_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("Cancelling your premium membership?"));
	}

	@When("^I haven't downgraded the plan into free yet$")
	public void i_haven_not_downgraded_the_plan_into_free_yet() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		openLeftMenuPanel();
		click("left_menu.change_plan");
		if (waitForGetElementPresent("checkout.downgrade_plan_to_iorad_free_link") == null) {
			WebElement checkElem = waitForGetElementPresent("checkout.checkout_button");
			click("checkout.plus_button");
			if (!checkElem.isEnabled())
				click("checkout.minus_button");
			click("checkout.checkout_button");
			waitForGetElementPresent("creators.creator_tab");
		}
	}

	@When("^I should be redirected to Thank You page$")
	public void i_should_be_redirected_to_thank_you_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("Thank you!"));
		Assert.assertTrue(getTextOnPage("Your life with iorad live begins."));
	}

	@When("^I should be redirected to the UPDATE CREDIT CARD page$")
	public void i_should_be_redirected_to_update_credit_card_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(getTextOnPage("Credit card update"));
	}

	@When("^I should be redirected to the Revisions page of the tutorial$")
	public void i_should_be_redirected_to_the_revisions_page_of_the_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.revision_page_label"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.revision_page_current_date_time"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.revision_page_current_label"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.revision_page_close"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.revision_page_open_in_editor"));
	}

	@When("^I should be redirected to the Statistics page$")
	public void i_should_be_redirected_to_the_statistic_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.statistics.statistics_modal"));
	}

	@When("^I should be able to view the statistics of the tutorial?$")
	public void i_should_be_view_the_statistic_of_the_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertNotNull(waitForGetElementPresent("tutorials.statistic.try"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.statistic.view"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.statistic.mobile"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.statistic.pdf_downloads"));
		Assert.assertNotNull(waitForGetElementPresent("tutorials.statistic.google_translations"));
	}
}

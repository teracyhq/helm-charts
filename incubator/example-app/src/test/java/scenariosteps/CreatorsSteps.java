package scenariosteps;

import org.junit.Assert;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import iorad.page.IoradBase;
import iorad.utils.RandomData;
import iorad.utils.TestLogger;

public class CreatorsSteps extends IoradBase {

	@Given("^I am at the Creators page$")
	public void i_at_the_creators_page() throws Throwable {
		openLeftMenuPanel();
		click("left_menu.creators");
		pause(2000);
	}
	
	@Given("^I am at the Invite Creators tab$")
	public void i_at_the_invite_creators() throws Throwable {
		openLeftMenuPanel();
		click("left_menu.creators");
		if(isPresent("creators.invitation_tab")) {
			click("creators.invitation_tab");
		}
		Assert.assertTrue("The invite creators textbox not present", isVisible("creators.invite_placeholder"));
	}

	@Then("^I should be (?:back|redirected) to the Creators page$")
	public void i_should_be_redirected_to_the_creators_page() throws Throwable {
		// Invite button
		Assert.assertTrue(isDisplay("creators.active_creator_tab"));
	}

	@Then("^The Invite team members page should be closed$")
	public void the_invite_team_members_page_should_be_closed() throws Throwable {
		// Input Email Textbox disappears
		Assert.assertFalse(isDisplay("creators.invite_placeholder"));
		// Invite button
		Assert.assertTrue(isDisplay("creators.invite_creator_button"));
	}

	@When("^I have invited full members of the team$")
	public void i_invite_full_members_of_the_team() throws Throwable {
		int index = 0;
		// Input email until the remaining is 0
		do {
			// Generate the email
			String email = String.format("autotest%d@gmail.com", index);

			// Input email
			sendKey("creators.invite_placeholder", email);
			// Press Enter
			pressEnterKey();
			index++;

		} while (!getText("creators.invitation_remaining").contains("0 invitation"));
	}

	@Given("^Clear creators data$")
	public void clear_creators_data() throws Throwable {
		openLeftMenuPanel();
		click("left_menu.creators");
		// delete creator data
		if (isPresent("creators.creator_tab")) {
			TestLogger.info("Go to creator tab");
			click("creators.creator_tab");
			while (isPresent("creators.email_creator")) {
				TestLogger.info("Delete creators email");
				mouseHover("creators.email_creator");
				click("creators.remove_creator");
				click("creators.confirm_remove_button");
			}
		}
		// delete pending invitation data
		if (isPresent("creators.invitation_tab")) {
			TestLogger.info("Go to invitation_tab");
			click("creators.invitation_tab");
			while (isPresent("creators.email_pending")) {
				TestLogger.info("Delete invitation email");
				mouseHover("creators.email_pending");
				click("creators.delete_pending_invitation");
				click("creators.confirm_delete_button");
			}

		}

	}
	
	@Given("^I remove the creator \"(.*)\"$")
	public void remove_creator(String creator) throws Throwable {
		RandomData randomData = new RandomData();
		creator = randomData.getRandomString(creator);
		openLeftMenuPanel();
		click("left_menu.creators");
		if (isPresent("creators.creator_tab")) {
			click("creators.creator_tab");
			if (isPresent("creators.specific_creator", creator)) {
				clickByJavascript("creators.delete_specific_creator", creator);
				click("creators.confirm_remove_button");
			}
		}
		// delete pending invitation data
		if (isPresent("creators.invitation_tab")) {
			click("creators.invitation_tab");
			if (isPresent("creators.specific_email_pending", creator)) {
				clickByJavascript("creators.delete_specific_email_pending", creator);
				click("creators.confirm_delete_button");
			}

		}

	}

	@Then("^I should be redirected to the remove Creators \"(.*)\" confirmation page$")
	public void i_should_be_redirected_to_the_remove_creators_confirmation_page(String creator) throws Throwable {

		// Get actual email from CommonData
		RandomData randomData = new RandomData();
		creator = randomData.getRandomString(creator);

		String expectText = creator
				+ " will be removed from your team. All tutorials made by this user will be transferred to you.";
		// The messages are correct
		Assert.assertTrue("The confirm text not display",driver.getPageSource().contains(expectText));
		// Keep button
		Assert.assertNotNull("The Keep button not display", waitForGetElementVisible("creators.confirm_keep_button"));
		// Remove button
		Assert.assertNotNull("The Remove button not display",
				waitForGetElementVisible("creators.confirm_remove_button"));

	}
}

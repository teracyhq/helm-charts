package scenariosteps;

import org.junit.Assert;
import org.openqa.selenium.WebElement;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import iorad.page.PageCore;

public class OptionVariesSteps extends PageCore {

	@Then("^The Flexible learner choice should be shown up$")
	public void the_flexible_learner_choice_show_up() throws Throwable {
		// Labels
		Assert.assertTrue(getTextOnPage("Flexible learner choice"));
		Assert.assertTrue(getTextOnPage("If equivalent items are not found, show message"));
		Assert.assertTrue(getTextOnPage("Link for tutorial"));
	}

	@Then("^The Flexible learner choice should be closed$")
	public void the_flexible_learner_choice_close() throws Throwable {
		Assert.assertNull(waitForGetElementVisible("option_varies.flexible_learner_choice_chk"));
	}

	@When("^I fill value \"(.*)\" to the equivalent message text box$")
	public void fill_value_to_equivalent_textbox(String message) throws Throwable {
		switchToIFrame("option_varies.flexible_learner_popup.message_frame");
		sendKey("option_varies.flexible_learner_popup.message_txt", message);
		doubleClick("option_varies.flexible_learner_popup.message_txt");
		swichBackToParentFrame();
	}

	@Then("^The value of the equivalent message text box should be \"(.*)\"$")
	public void check_value_of_equivalent_textbox(String expectedMsg) throws Throwable {
		switchToIFrame("option_varies.flexible_learner_popup.message_frame");

		String actualMsg = getText("option_varies.flexible_learner_popup.message_txt");
		Assert.assertEquals(expectedMsg, actualMsg);

		swichBackToParentFrame();
	}

	@Then("^The equivalent message \"(.*)\" should be bold$")
	public void equivalent_message_should_be_bold(String text) throws Throwable {
		switchToIFrame("option_varies.flexible_learner_popup.message_frame");

		String msg = String.format("The message [%s] is not bold as expected", text);
		WebElement boldText = waitForGetElementVisible("option_varies.flexible_learner_popup.message_bold", text);
		Assert.assertNotNull(msg, boldText);

		swichBackToParentFrame();
	}

	@Then("^The equivalent message \"(.*)\" should be underline$")
	public void equivalent_message_should_be_underline(String text) throws Throwable {
		switchToIFrame("option_varies.flexible_learner_popup.message_frame");

		String msg = String.format("The message [%s] is not underline as expected", text);
		WebElement underlineText = waitForGetElementVisible("option_varies.flexible_learner_popup.message_underline",
				text);
		Assert.assertNotNull(msg, underlineText);

		swichBackToParentFrame();
	}

	@Then("^The equivalent message text box should contain hyperlink \"(.*)\" for text \"(.*)\"$")
	public void check_hyperlink_of_equivalent_textbox_visible(String link, String text) throws Throwable {
		switchToIFrame("option_varies.flexible_learner_popup.message_frame");

		String msg = String.format("The hyperlink [%s] is not visible in the equivalent textbox [%s]", link, text);
		WebElement hyperlink = waitForGetElementVisible("option_varies.flexible_learner_popup.message_hyperlink", link,
				text);
		Assert.assertNotNull(msg, hyperlink);

		swichBackToParentFrame();
	}

	@Then("^The equivalent message text box should not contain hyperlink \"(.*)\" for text \"(.*)\"$")
	public void check_hyperlink_of_equivalent_textbox_invisible(String link, String text) throws Throwable {
		switchToIFrame("option_varies.flexible_learner_popup.message_frame");

		String msg = String.format("The hyperlink [%s] is not set in the equivalent textbox [%s]", link, text);
		WebElement hyperlink = waitForGetElementVisible("option_varies.flexible_learner_popup.message_hyperlink", link,
				text);
		Assert.assertNull(msg, hyperlink);

		swichBackToParentFrame();
	}

}

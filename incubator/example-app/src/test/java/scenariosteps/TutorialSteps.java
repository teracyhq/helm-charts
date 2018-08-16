package scenariosteps;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import iorad.page.PageCore;
import iorad.utils.RandomData;
import iorad.utils.TestLogger;

public class TutorialSteps extends PageCore {
	@Given("^I should be able to play the tutorial to the last step$")
	public void i_should_be_able_to_play_the_tutorial_to_the_last_step() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		while (waitForGetElementPresent("tutorials.play_tutorial.tutorial_iframe") != null) {
			TestLogger.info("Switch to iframe");
			switchToIFrame("tutorials.play_tutorial.tutorial_iframe");
		}
		click("tutorials.play_tutorial.icon_fullcover");
		click("tutorials.next_step_button");
		while (waitForGetElementPresent("tutorials.next_step_button") != null) {
			click("tutorials.next_step_button");
		}
	}

	@When("^I should see the number of steps of the tutorial$")
	public void i_should_see_the_number_of_steps_of_the_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Assert.assertTrue(waitForGetElements("tutorials.add_audio_close_button").size() > 0);
		Assert.assertTrue(waitForGetElements("tutorials.add_audio_test_list").size() > 0);
	}

	@When("^All tutorials in \"(.*)\" tab should be removed$")
	public void all_tutorials_should_be_removed_from_specific_tab(String strTabName) throws Throwable {
		// Select the tab
		click(strTabName);
		// The tutorials not present, I don't see the "..." icon anymore
		Assert.assertFalse("The tutorials still present", isPresent("tutorials.three_dot_icon"));
	}

	@When("^Clear all my tutorials$")
	public void clear_all_my_tutorials() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		if (waitForGetElementPresent("tutorials.my_tutorial_tab") != null) {
			click("tutorials.my_tutorial_tab");
			while (waitForGetElementPresent("tutorials.three_dot_icon") != null) {
				click("tutorials.three_dot_icon");
				click("tutorials.delete_tutorial_button");
				click("tutorials.confirm_yes");
			}
		}
	}

	@When("^Clear all my tutorials and shared tutorials$")
	public void clear_all_my_tutorials_and_shared_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		if (waitForGetElementPresent("tutorials.my_tutorial_tab") != null) {
			click("tutorials.my_tutorial_tab");
			while (waitForGetElementPresent("tutorials.three_dot_icon") != null) {
				click("tutorials.three_dot_icon");
				click("tutorials.delete_tutorial_button");
				click("tutorials.confirm_yes");
			}
		}

		if (waitForGetElementPresent("tutorials.shared_tab") != null) {
			click("tutorials.shared_tab");
			while (waitForGetElementPresent("tutorials.three_dot_icon") != null) {
				click("tutorials.three_dot_icon");
				click("tutorials.delete_tutorial_button");
				click("tutorials.confirm_yes");
			}
		}
	}

	@When("^Clear all my tutorials and shared tutorials and shared edit tutorials$")
	public void clear_all_my_tutorials_and_shared_tutorial_and_shared_edit_tutorial() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		if (waitForGetElementPresent("tutorials.my_tutorial_tab") != null) {
			click("tutorials.my_tutorial_tab");
			while (waitForGetElementPresent("tutorials.three_dot_icon") != null) {
				click("tutorials.three_dot_icon");
				click("tutorials.delete_tutorial_button");
				click("tutorials.confirm_yes");
			}
		}

		if (waitForGetElementPresent("tutorials.shared_tab") != null) {
			click("tutorials.shared_tab");
			while (waitForGetElementPresent("tutorials.three_dot_icon") != null) {
				click("tutorials.three_dot_icon");
				click("tutorials.delete_tutorial_button");
				click("tutorials.confirm_yes");
			}
		}

		if (waitForGetElementPresent("tutorials.share_edit_tab") != null) {
			click("tutorials.share_edit_tab");
			while (waitForGetElementPresent("tutorials.three_dot_icon") != null) {
				click("tutorials.three_dot_icon");
				click("tutorials.delete_tutorial_button");
				click("tutorials.confirm_yes");
			}
		}
	}

	@When("^I input emails at the Invite Share tab$")
	public void i_input_email_at_the_invite_share_tab(DataTable emailList) throws Throwable {
		RandomData randomData = new RandomData();
		List<Map<String, String>> emails = emailList.asMaps(String.class, String.class);

		for (Map<String, String> temp : emails) {
			String email = temp.get("Emails");
			email = randomData.getRandomString(email);
			// Input email
			sendKey("tutorials.tab_share_tutorial_pane_invite_input_email_txt", email);
			// Press Enter
			pressKey(waitForGetElementPresent("tutorials.tab_share_tutorial_pane_invite_input_email_txt"), Keys.ENTER);
		}
	}

	@When("^I clear email pending list$")
	public void i_clear_email_pending_list() throws Throwable {
		swichBackToMainFrame();
		if (isPresent("tutorials.tab_share_tutorial_tab_invite")) {
			click("tutorials.tab_share_tutorial_tab_invite");
			while (isPresent("tutorials.tab_share_tutorial_pane_invite_inputted_email_txt")) {
				TestLogger.info("Remove one pending email");
				mouseHover("tutorials.tab_share_tutorial_pane_invite_inputted_email_txt");
				click("tutorials.tab_share_tutorial_pane_invite_inputted_email_x_icon");
				click("tutorials.tab_share_tutorial_pane_invite_confirm_remove");
			}
			TestLogger.info("Remove all pending email");
		}
	}

	@When("^I search for \"(.*)\" tutorial$")
	public void i_search_for_tutorial(String tutorial) throws Throwable {
		waitForGetElementVisible("tutorials.search_tutorials");
		sendKey("tutorials.search_tutorials", tutorial);
		pause(2000);
	}

	@When("^I hover on email \"(.*)\" at the Assgin tab$")
	public void i_hover_on_email_at_assgin_tab(String email) throws Throwable {
		RandomData randomData = new RandomData();
		String value = randomData.getRandomString(email);
		mouseHover("tutorials.tab_share_tutorial_pane_assign_email_item", value);
		pause(2000);
	}

	@When("^I delete the email \"(.*)\" from the Assign tab$")
	public void i_delete_email_from_the_assgin_tab(String email) throws Throwable {
		RandomData randomData = new RandomData();
		email = randomData.getRandomString(email);
		if (isPresent("tutorials.tab_share_tutorial_pane_assign_email_item", email)) {
			mouseHover("tutorials.tab_share_tutorial_pane_assign_email_item", email);
			clickByJavascript("tutorials.tab_share_tutorial_pane_assign_email_item_delete_btn", email);
		}
	}

	@Then("^The tutorials should be sorted by \"(.*)\" in the \"(.*)\" order$")
	public void the_tutorials_should_be_sorted_by_name(String strVerifyOrderType, String strExpectedOrder)
			throws Throwable {
		final String DESCENDING = "descending";
		final String ASCENDING = "ascending";
		final String DESCENDING_FLAG = "list_lines_down";
		final String ASCENDING_FLAG = "list_lines";
		List<String> actualTextList = new ArrayList<>();
		List<WebElement> tutorialElementList = new ArrayList<>();
		String strClassAtribute = "";

		if (strVerifyOrderType.equalsIgnoreCase("shared_tab.tutorial_name")) {
			tutorialElementList = waitForGetElements("tutorials.shared_tab.tutorial_name");
			strClassAtribute = getAttribute("class", "tutorials.shared_tab.name_header");
		} else if (strVerifyOrderType.equalsIgnoreCase("shared_tab.shared_by")) {
			tutorialElementList = waitForGetElements("tutorials.shared_tab.tutorial_shared_by");
			strClassAtribute = getAttribute("class", "tutorials.shared_tab.shared_by_header");
		} else if (strVerifyOrderType.equalsIgnoreCase("shared_tab.status")) {
			tutorialElementList = waitForGetElements("tutorials.shared_tab.tutorial_status");
			strClassAtribute = getAttribute("class", "tutorials.shared_tab.status_header");
		} else if (strVerifyOrderType.equalsIgnoreCase("shared_tab.last_visit")) {
			tutorialElementList = waitForGetElements("tutorials.shared_tab.tutorial_last_visit");
			strClassAtribute = getAttribute("class", "tutorials.shared_tab.last_visit_header");
		} else {
			throw new Exception(String.format("Sorting by [%s] hasn't been implemented", strVerifyOrderType));
		}

		// Get list of tutorials in order
		for (WebElement tutorialElement : tutorialElementList) {
			String tutorial = tutorialElement.getAttribute("innerText").trim();
			actualTextList.add(tutorial);
		}

		// Get actual Sorting type based on the class atribute of header
		String strActualOrder = "";
		if (strClassAtribute.contains(DESCENDING_FLAG)) {
			strActualOrder = DESCENDING;
		} else if (strClassAtribute.contains(ASCENDING_FLAG)) {
			strActualOrder = ASCENDING;
		} else {
			throw new Exception("The tutorial lists isn't in order by state");
		}

		// Check sorting order of tutorial list
		if (strActualOrder.equals(strExpectedOrder) && strActualOrder.equals(ASCENDING)) {
			for (int i = 0; i < actualTextList.size() - 1; i++) {
				if (actualTextList.get(i).compareToIgnoreCase(actualTextList.get(i + 1)) > 0) {
					throw new Exception(String.format("The tutorial list isn't sorted in the [%s] order by [%s]",
							ASCENDING, strVerifyOrderType));
				}
			}
		}
		if (strActualOrder.equals(strExpectedOrder) && strActualOrder.equals(DESCENDING)) {
			for (int i = 0; i < actualTextList.size() - 1; i++) {
				if (actualTextList.get(i).compareToIgnoreCase(actualTextList.get(i + 1)) < 0) {
					throw new Exception(String.format("The tutorial list isn't sorted in the [%s] order by [%s]",
							DESCENDING, strVerifyOrderType));
				}
			}
		}
	}

	@Then("^My tutorials should be sorted by \"(.*)\" in the \"(.*)\" order$")
	public void my_tutorials_should_be_sorted_by_name(String strVerifyOrderType, String strExpectedOrder)
			throws Throwable {
		final String DESCENDING = "descending";
		final String ASCENDING = "ascending";
		final String DESCENDING_FLAG = "list_lines_down";
		final String ASCENDING_FLAG = "list_lines";
		List<String> actualTextList = new ArrayList<>();
		List<WebElement> tutorialElementList = new ArrayList<>();
		String strClassAtribute = "";

		// Sort by tutorial name
		if (strVerifyOrderType.equalsIgnoreCase("tutorials.my_tutorials.tutorial_name")) {
			tutorialElementList = waitForGetElements("tutorials.my_tutorials.tutorial_name");
			strClassAtribute = getAttribute("class", "tutorials.header_name");
		}
		// Sort by tutorial privacy
		else if (strVerifyOrderType.equalsIgnoreCase("tutorials.my_tutorials.tutorial_privacy")) {
			tutorialElementList = waitForGetElements("tutorials.my_tutorials.tutorial_privacy");
			strClassAtribute = getAttribute("class", "tutorials.header_privacy");
		}
		// Sort by Last edited date
		else if (strVerifyOrderType.equalsIgnoreCase("tutorials.my_tutorials.tutorial_last_edited_date")) {
			tutorialElementList = waitForGetElements("tutorials.my_tutorials.tutorial_last_edited_date");
			strClassAtribute = getAttribute("class", "tutorials.header_last_edit");
		}
		// Sort by Steps
		else if (strVerifyOrderType.equalsIgnoreCase("tutorials.my_tutorials.tutorial_steps")) {
			tutorialElementList = waitForGetElements("tutorials.my_tutorials.tutorial_steps");
			strClassAtribute = getAttribute("class", "tutorials.header_steps");
		}
		// Sort by Live mode
		else if (strVerifyOrderType.equalsIgnoreCase("tutorials.my_tutorials.tutorial_live_mode")) {
			tutorialElementList = waitForGetElements("tutorials.my_tutorials.tutorial_live_mode");
			strClassAtribute = getAttribute("class", "tutorials.header_live_mode");
		} else {
			throw new Exception(String.format("Sorting by [%s] hasn't been implemented", strVerifyOrderType));
		}

		// Get list of tutorials in order
		for (WebElement tutorialElement : tutorialElementList) {
			String tutorial = tutorialElement.getAttribute("innerText").trim();
			actualTextList.add(tutorial);
		}

		// Get actual Sorting type based on the class atribute of header
		String strActualOrder = "";
		if (strClassAtribute.contains(DESCENDING_FLAG)) {
			strActualOrder = DESCENDING;
		} else if (strClassAtribute.contains(ASCENDING_FLAG)) {
			strActualOrder = ASCENDING;
		} else {
			throw new Exception("The tutorial lists isn't in order by state");
		}

		// Check sorting order of tutorial list
		if (strActualOrder.equals(strExpectedOrder) && strActualOrder.equals(ASCENDING)) {
			for (int i = 0; i < actualTextList.size() - 1; i++) {
				if (strVerifyOrderType.equalsIgnoreCase("tutorials.my_tutorials.tutorial_steps")) {
					if (Integer.parseInt(actualTextList.get(i)) > Integer.parseInt(actualTextList.get(i + 1))) {
						throw new Exception(String.format("The tutorial list isn't sorted in the [%s] order by [%s]",
								ASCENDING, strVerifyOrderType));
					}
				} else if (actualTextList.get(i).compareTo(actualTextList.get(i + 1)) > 0) {
					throw new Exception(String.format("The tutorial list isn't sorted in the [%s] order by [%s]",
							ASCENDING, strVerifyOrderType));
				}
			}
		}
		if (strActualOrder.equals(strExpectedOrder) && strActualOrder.equals(DESCENDING)) {
			for (int i = 0; i < actualTextList.size() - 1; i++) {
				if (strVerifyOrderType.equalsIgnoreCase("tutorials.my_tutorials.tutorial_steps")) {
					if (Integer.parseInt(actualTextList.get(i)) < Integer.parseInt(actualTextList.get(i + 1))) {
						throw new Exception(String.format("The tutorial list isn't sorted in the [%s] order by [%s]",
								ASCENDING, strVerifyOrderType));
					}
				} else if (actualTextList.get(i).compareTo(actualTextList.get(i + 1)) < 0) {
					throw new Exception(String.format("The tutorial list isn't sorted in the [%s] order by [%s]",
							DESCENDING, strVerifyOrderType));
				}
			}
		}
	}

	@When("^I play tutorial completedly$")
	public void i_play_tutorial_completedly() throws Throwable {
		// Play the tutorial until finish
		do {

			click("tutorials.play_tutorial.click_button");
			TestLogger.info("Playing tutorial");
		} while (isPresent("tutorials.play_tutorial.click_button"));

		Assert.assertTrue("The tutorial hasn't been played fully", getTextOnPage("That's it. You're done."));
	}

	@When("^I play tutorial in the desktop mode from Tutorial Settings page$")
	public void i_play_tutorial_in_desktop_mode() throws Throwable {
		// Play the tutorial until finish
		while (isDisplay("tutorials.settings.view_desktop_mode.next_btn")) {
			click("tutorials.settings.view_desktop_mode.next_btn");
			TestLogger.info("Playing tutorial");
		}
		;

		Assert.assertTrue("The tutorial hasn't been played fully", getTextOnPage("That's it. You're done."));
		Assert.assertTrue("The tutorial hasn't been played fully", getTextOnPage("FINISHED"));
	}

	@When("^I play tutorial in the mobile mode from Tutorial Settings page$")
	public void i_play_tutorial_in_mobile_mode() throws Throwable {
		// Play the tutorial until finish
		while (isDisplay("tutorials.settings.view_mobile_mode.next_btn")) {
			click("tutorials.settings.view_mobile_mode.next_btn");
			TestLogger.info("Playing tutorial");
		}
		;

		Assert.assertTrue("The tutorial hasn't been played fully", getTextOnPage("FINISHED"));
	}

	@When("^I remove category from the tutorial settings page$")
	public void remove_category_from_settings_page() throws Throwable {
		while (isPresent("tutorials.settings.category_tag_popup.category_delete_btn")) {
			click("tutorials.settings.category_tag_popup.category_delete_btn");
		}
	}

	@When("^I remove tags from the tutorial settings page$")
	public void remove_tags_from_settings_page() throws Throwable {
		while (isPresent("tutorials.settings.category_tag_popup.tags_delete_btn")) {
			click("tutorials.settings.category_tag_popup.tags_delete_btn");
		}
	}

	@When("^I am at the first step$")
	public void move_to_first_step() throws Throwable {
		while (isPresent("tutorials.edit_tutorial.prev_step")) {
			click("tutorials.edit_tutorial.prev_step");
		}
	}

	@When("^I am at the last step$")
	public void move_to_last_step() throws Throwable {
		while (isPresent("tutorials.edit_tutorial.next_step")) {
			click("tutorials.edit_tutorial.next_step");
		}
	}

	@When("^I continue to delete the final step of tutorial$")
	public void delete_all_step() throws Throwable {
		while (!getText("tutorials.edit_tutorial.number_of_steps").equals("1")) {
			TestLogger.info("Current step is " + getText("tutorials.edit_tutorial.number_of_steps"));
			click("tutorials.edit_tutorial.delete_step");
		}
	}

	@When("^The background color of player should equal \"(.*)\"$")
	public void the_background_color_should_equal(String color) throws Throwable {

		String actualBackgroundColor = getCssValue("background-color", "tutorials.play_tutorial.header");
		String expectedBackgroundColor = convertColorFromHexToRgb(color);

		String message = String.format("The actual bacground color [%s] not equal expected background [%s]",
				actualBackgroundColor, expectedBackgroundColor);

		Assert.assertEquals(message, expectedBackgroundColor, actualBackgroundColor);
	}

	@When("^The background color of player should equal variable \"(.*)\"$")
	public void the_background_color_should_equal_variable(String var) throws Throwable {

		waitForPageToLoad();
		String actualBackgroundColor = getCssValue("background-color", "tutorials.play_tutorial.header");
		String expectedBackgroundColor = convertColorFromHexToRgb(listVar.get(var));

		String message = String.format("The actual bacground color [%s] not equal expected background [%s]",
				actualBackgroundColor, expectedBackgroundColor);

		Assert.assertEquals(message, expectedBackgroundColor, actualBackgroundColor);
	}

	// This method is only tested for a canvas element
	@When("^I store the color of canvas screenshot at offset (\\d+) and (\\d+) into variable \"(.*)\"$")
	public void store_color_into_variable(int x, int y, String var) throws Throwable {
		WebElement canvas = waitForGetElementPresent("tutorials.settings.view_desktop_mode.screenshot_canvas");
		String js = String.format("function rgbToHex(r, g, b) {" + "if (r > 255 || g > 255 || b > 255)"
				+ " throw \"Invalid color component\";" + "return ((r << 16) | (g << 8) | b).toString(16);}"
				+ "var p = arguments[0].getContext('2d').getImageData(%d, %d, 1, 1).data;"
				+ "return \"#\" + (\"000000\" + rgbToHex(p[0], p[1], p[2])).slice(-6)", x, y);

		String color = executeJS(canvas, js);
		TestLogger.info("+++++: " + color);
		listVar.put(var, color);

	}

	@When("^Clear all category and label base on element \"(.*)\"$")
	public void clear_category_label(String element) throws Throwable {
		if (isPresent("tutorial.left.edit_category")) {
			click("tutorial.left.edit_category");
			while (isPresent("tutorials.add_category_tag_modal.categories_tab.delete")) {
				hover("tutorials.add_category_tag_modal.categories_tab.delete");
				click("tutorials.add_category_tag_modal.categories_tab.delete");
			}
			click("tutorials.add_category_tag_modal.close_button");
		}
		if (isPresent("tutorial.left.edit_tag")) {
			click("tutorial.left.edit_tag");
			while (isPresent("tutorials.add_category_tag_modal.tag_tab.delete")) {
				hover("tutorials.add_category_tag_modal.tag_tab.delete");
				click("tutorials.add_category_tag_modal.tag_tab.delete");
			}
			click("tutorials.add_category_tag_modal.close_button");
		}
		while (isPresent(element)) {
			click(element);
		}
	}
}

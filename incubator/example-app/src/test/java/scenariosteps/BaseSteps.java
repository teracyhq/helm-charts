package scenariosteps;

import java.awt.HeadlessException;
import java.awt.Toolkit;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.commons.io.FileUtils;
import org.junit.Assert;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import com.cucumber.listener.Reporter;

import cucumber.api.Scenario;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import iorad.page.DateTime;
import iorad.page.ManageFile;
import iorad.page.PageCore;
import iorad.utils.RandomData;
import iorad.utils.TestLogger;

public class BaseSteps extends PageCore {
	public static boolean wantsToQuit = false;
	public static boolean tempQuit = false;

	@Before
	public void setUp() throws Exception {
		if (tempQuit) {
			System.exit(-1);
		}
		if (wantsToQuit) {
			tempQuit = true;
		} else {
			TestLogger.info("Test Started");
			TestLogger.info(" _____ _____ ____ _____   ____ _____  _    ____ _____ _____ ____ ");
			TestLogger.info("|_   _| ____/ ___|_   _| / ___|_   _|/ \\  |  _ \\_   _| ____|  _ \\");
			TestLogger.info("  | | |  _| \\___ \\ | |   \\___ \\ | | / _ \\ | |_) || | |  _| | | | |");
			TestLogger.info("  | | | |___ ___) || |    ___) || |/ ___ \\|  _ < | | | |___| |_| |");
			TestLogger.info("  |_| |_____|____/ |_|   |____/ |_/_/   \\_\\_| \\_\\|_| |_____|____/");
			openThePage();
			if (waitForGetElementPresent("home_page.got_it_btn") != null) {
				clickByJavascript("home_page.got_it_btn");
			}
		}
	}

	@After
	public void tearDown(Scenario scenario) {
		try {
			if (wantsToQuit == false) {
				File src = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
				Date date = new Date();
				String screenshotName = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(date) + ".png";
				File des = new File(".\\output\\" + screenshotName);
				FileUtils.copyFile(src, des);
				// scenario.embed(screenshot, "image/png");
				closeBrowser();
				if (!scenario.isFailed()) {
					TestLogger.info("Test Pass");
					TestLogger.info("        __    _____ _____ ____ _____   ____   _    ____  ____  _____ ____");
					TestLogger.info(" _     \\ \\  |_   _| ____/ ___|_   _| |  _ \\ / \\  / ___|/ ___|| ____|  _ \\");
					TestLogger.info("(_)_____| |   | | |  _| \\___ \\ | |   | |_) / _ \\ \\___ \\___ \\|  _| | | | |");
					TestLogger.info(" _|_____| |   | | | |___ ___) || |   |  __/ ___ \\ ___) |___) | |___| |_| |");
					TestLogger.info("(_)     | |   |_| |_____|____/ |_|   |_| /_/   \\_\\____/|____/|_____|____/ ");
					TestLogger.info("        /_/     ");
					closeBrowser();
				} else // if(scenario.getStatus().equalsIgnoreCase("failed"))
				{
					TestLogger.info("Test Fail");
					TestLogger.info("          __  _____ _____ ____ _____   _____ _    ___ _     _____ ____ ");
					TestLogger.info(" _       / / |_   _| ____/ ___|_   _| |  ___/ \\  |_ _| |   | ____|  _ \\ ");
					TestLogger.info("(_)_____| |    | | |  _| \\___ \\ | |   | |_ / _ \\  | || |   |  _| | | | |");
					TestLogger.info(" _|_____| |    | | | |___ ___) || |   |  _/ ___ \\ | || |___| |___| |_| |");
					TestLogger.info("(_)     | |    |_| |_____|____/ |_|   |_|/_/   \\_\\___|_____|_____|____/ ");
					TestLogger.info("         \\_\\                                                            ");
					TestLogger.info(scenario.toString());
					if (failfast) {
						wantsToQuit = scenario.isFailed();
					}
					Reporter.addScreenCaptureFromPath("file:///" + des.getAbsolutePath());

				}
			}
		} catch (WebDriverException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Given("^I reload page$")
	public void i_reload_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		driver.navigate().refresh();

	}

	@Given("^I navigate to url \"(.*)\"$")
	public void i_open_url(String url) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		driver.navigate().to(url);
		TestLogger.info("Navigated to the url: " + url);
	}

	@Given("^I navigate to the url stored in variable \"(.*)\"$")
	public void i_open_url_in_variable(String var) throws Throwable {
		String url = listVar.get(var);
		if (!url.startsWith("http")) {
			url = "http://" + url;
		}
		driver.navigate().to(url);
		waitForPageToLoad();
		TestLogger.info("Navigated to the url: " + url);
	}

	@Given("^Open browser with adding iorad extension$")
	public void open_browser_with_adding_iorad_extension() {
		// Write code here that turns the phrase above into concrete actions
		closeBrowser();
		openThePage(true);
	}

	@Given("^I am an anonymous user$")
	public void i_am_an_anonymous_user() throws Throwable {
		// Write code here that turns the phrase above into concrete actions

	}

	@Given("^I am as a logged-in user$")
	public void i_am_an_logged_user() throws Throwable {
		// Write code here that turns the phrase above into concrete actions

	}

	@Then("^The url should be \"(.*)\"$")
	public void the_url_should_be(String strExpectedUrl) throws Throwable {
		String strActualUrl = getCurrentUrl();
		String message = String.format("The actual url is [%s]. But expectation is [%s]", strActualUrl, strExpectedUrl);
		Assert.assertEquals(message, strActualUrl, strExpectedUrl);
	}

	@Then("^The url should contain \"(.*)\"$")
	public void the_url_should_contain(String strExpectedUrl) throws Throwable {
		String strActualUrl = getCurrentUrl();
		String message = String.format("The actual url is [%s]. But expectation is [%s]", strActualUrl, strExpectedUrl);
		Assert.assertTrue(message, strActualUrl.contains(strExpectedUrl));
	}

	@Then("^The page title should be \"(.*)\"$")
	public void the_page_title_should_be(String strExpectedTitle) throws Throwable {
		String strActualTitle = getPageTitle();
		String message = String.format("The actual page title is [%s]. But expectation is [%s]", strActualTitle,
				strExpectedTitle);
		Assert.assertEquals(message, strActualTitle, strExpectedTitle);
	}

	@Then("^The \"([^\"]*)\" should be disabled$")
	public void the_element_should_be_disabled(String element) throws Throwable {
		Assert.assertEquals(false, isEnabled(element));
	}

	@Then("^The \"([^\"]*)\" of \"([^\"]*)\" should be disabled$")
	public void the_element_should_be_disabled(String element, String param) throws Throwable {
		Assert.assertEquals(false, isEnabled(element, param));
	}

	@Then("^The \"([^\"]*)\" should be enabled$")
	public void the_element_should_be_enabled(String element) throws Throwable {
		pause(1000);
		Assert.assertEquals(element + " is disabled ", isEnabled(element), true);
	}

	@Then("^The \"([^\"]*)\" of \"([^\"]*)\" should be enabled$")
	public void the_element_should_be_enabled(String element, String param) throws Throwable {
		Assert.assertEquals(true, isEnabled(element, param));
	}

	@Then("^The \"([^\"]*)\" should be visible$")
	public void the_element_should_be_visible(String element) throws Throwable {
		Assert.assertTrue(String.format("The element [%s] not visible", element), isVisible(element));
	}

	@Then("^The \"([^\"]*)\" of \"([^\"]*)\" should be visible$")
	public void the_element_should_be_visible(String element, String param) throws Throwable {
		RandomData randomData = new RandomData();
		param = randomData.getRandomString(param);
		Assert.assertTrue(String.format("The element [%s] of [%s] not visible", element, param),
				isVisible(element, param));
	}

	@Then("^The \"([^\"]*)\" should be invisible$")
	public void the_element_should_be_invisible(String element) throws Throwable {
		pause(1000);
		Assert.assertFalse(String.format("The element [%s] not invisible", element), isVisible(element));
	}

	@Then("^The \"([^\"]*)\" of \"([^\"]*)\" should be invisible$")
	public void the_element_should_be_invisible(String element, String param) throws Throwable {
		pause(1000);
		Assert.assertFalse(String.format("The element [%s] of [%s] not invisible", element, param),
				isVisible(element, param));
	}

	@Then("^The \"([^\"]*)\" checkbox should be unchecked$")
	public void the_checkbox_should_be_unchecked_by_default(String element) throws Throwable {
		Assert.assertEquals(isSelected(element), false);
	}

	@Then("^The \"([^\"]*)\" checkbox should be checked$")
	public void the_checkbox_should_be_checked_by_default(String element) throws Throwable {
		Assert.assertEquals(isSelected(element), true);
	}

	@When("^I select \"([^\"]*)\" from the selection list \"([^\"]*)\"$")
	public void select_from_selection_list(String option, String element) throws Throwable {
		// Select the option
		waitForGetElementPresent(element, option).click();
		waitForPageToLoad();

	}

	@When("^I select by value \"([^\"]*)\" from the dropdown list \"([^\"]*)\"$")
	public void select_from_dropdown_list_by_value(String value, String element) throws Throwable {
		Select dropdown = new Select(waitForGetElementPresent(element));
		dropdown.selectByValue(value);
	}

	@When("^I select by visible text \"([^\"]*)\" from the dropdown list \"([^\"]*)\"$")
	public void select_from_dropdown_list_by_text(String text, String element) throws Throwable {
		Select dropdown = new Select(waitForGetElementPresent(element));
		dropdown.selectByVisibleText(text);
	}

	@Then("^The text of element \"(.*?)\" should be \"(.*?)\"$")
	public void the_text_element_should_be(String target, String value) throws Throwable {
		Assert.assertTrue(waitForGetElementPresent(target).getText() + " is not equal " + value,
				waitForGetElementPresent(target).getText().equals(value));
	}

	@Then("^The text of elements \"(.*?)\" should be \"(.*?)\"$")
	public void the_text_elements_should_be(String target, String value) throws Throwable {

		List<WebElement> elements = waitForGetElements(target);
		Assert.assertFalse(String.format("The elements [%s] not present", target), elements.isEmpty());

		for (WebElement element : elements) {
			String strActualText = element.getText();
			Assert.assertTrue(strActualText + " does not contain " + value, strActualText.equals(value));
		}
	}

	@Then("^The text of element \"(.*?)\" should not be \"(.*?)\"$")
	public void the_text_element_should_not_be(String target, String value) throws Throwable {
		Assert.assertFalse(waitForGetElementPresent(target).getText() + " is equal " + value,
				waitForGetElementPresent(target).getText().equals(value));
	}

	@Then("^The text of element \"(.*?)\" should contain \"(.*?)\"$")
	public void the_text_element_should_contain(String target, String value) throws Throwable {
		RandomData randomData = new RandomData();
		value = randomData.getRandomString(value);
		String strActualText = waitForGetElementPresent(target).getText();
		Assert.assertTrue(strActualText + " does not contain " + value, strActualText.contains(value));
	}

	@Then("^The text of element \"(.*?)\" should contain variable \"(.*?)\"$")
	public void the_text_element_should_contain_variable(String target, String var) throws Throwable {
		String strActualText = waitForGetElementPresent(target).getText();
		String value = listVar.get(var);
		Assert.assertTrue(strActualText + " does not contain " + value, strActualText.contains(value));
	}

	@Then("^The text of elements \"(.*?)\" should contain \"(.*?)\"$")
	public void the_text_elements_should_contain(String target, String value) throws Throwable {

		List<WebElement> elements = waitForGetElements(target);
		Assert.assertFalse(String.format("The elements [%s] not present", target), elements.isEmpty());

		for (WebElement element : elements) {
			String strActualText = element.getText();
			Assert.assertTrue(strActualText + " does not contain " + value, strActualText.contains(value));
		}
	}

	@Then("^The text of element \"(.*?)\" should not contain \"(.*?)\"$")
	public void the_text_element_should_not_contain(String target, String value) throws Throwable {
		Assert.assertFalse(waitForGetElementPresent(target).getText() + " contain " + value,
				waitForGetElementPresent(target).getText().contains(value));
	}

	@Then("^The attribute \"(.*?)\" of element \"(.*?)\" should contain \"(.*?)\"$")
	public void the_attribute_should_contain(String attr, String target, String value) throws Throwable {
		String strActualAttributeValue = waitForGetElementPresent(target).getAttribute(attr);
		String message = String.format("The attribute [%s] of element [%s] is [%s], it doesn't contain value [%s]",
				attr, target, strActualAttributeValue, value);
		Assert.assertTrue(message, strActualAttributeValue.contains(value));
	}

	@Then("^The attribute \"(.*?)\" of element \"(.*?)\" should equal variable \"(.*?)\"$")
	public void the_attribute_should_equal_variale(String attr, String target, String var) throws Throwable {
		String strActualAttributeValue = waitForGetElementPresent(target).getAttribute(attr);
		String value = listVar.get(var);
		String message = String.format("The attribute [%s] of element [%s] is [%s], it isn't equal value [%s]", attr,
				target, strActualAttributeValue, value);
		Assert.assertTrue(message, strActualAttributeValue.equals(value));
	}

	@Then("^The attribute \"(.*?)\" of element \"(.*?)\" should be \"(.*?)\"$")
	public void the_attribute_should_equal(String attr, String target, String value) throws Throwable {
		String strActualAttributeValue = waitForGetElementPresent(target).getAttribute(attr);
		String message = String.format("The attribute [%s] of element [%s] is [%s], it isn't equal value [%s]", attr,
				target, strActualAttributeValue, value);
		Assert.assertTrue(message, strActualAttributeValue.equals(value));
	}

	@Then("^The attribute \"(.*?)\" of element \"(.*?)\" should not contain \"(.*?)\"$")
	public void the_attribute_should_not_contain(String attr, String target, String value) throws Throwable {
		String strActualAttributeValue = waitForGetElementPresent(target).getAttribute(attr);
		String message = String.format("The attribute [%s] of element [%s] is [%s], it still contains value [%s]", attr,
				target, strActualAttributeValue, value);
		Assert.assertFalse(message, strActualAttributeValue.contains(value));
	}

	@Then("^The attribute \"(.*?)\" of element \"(.*?)\" should not be \"(.*?)\"$")
	public void the_attribute_should_not_equal(String attr, String target, String value) throws Throwable {
		String strActualAttributeValue = waitForGetElementPresent(target).getAttribute(attr);
		String message = String.format("The attribute [%s] of element [%s] is [%s], it still equal value [%s]", attr,
				target, strActualAttributeValue, value);
		Assert.assertFalse(message, strActualAttributeValue.equals(value));
	}

	@When("^I fill value \"([^\"]*)\" to \"([^\"]*)\" textbox$")
	public void i_fill_value_to_textbox(String text, String element) throws Throwable {
		sendKey(element, text);
	}

	@When("^I fill variable \"([^\"]*)\" to \"([^\"]*)\" textbox$")
	public void i_fill_variable_to_textbox(String var, String element) throws Throwable {
		sendKey(element, listVar.get(var));
	}

	@When("^(?:I click|I navigate to the) \"([^\"]*)\"$")
	public void i_click(String element) throws Throwable {
		click(element);
	}

	@When("^I click \"([^\"]*)\" by random offset$")
	public void i_click_by_offset(String element) throws Throwable {
		int x = (int) (Math.random() * 50 + 1);
		int y = (int) (Math.random() * 50 + 1);
		click(element, x, y);
	}

	@When("^I click on canvas \"([^\"]*)\" by offset (\\d+) and (\\d+)$")
	public void i_click_by_offset(String element, int x, int y) throws Throwable {
		clickOnCanvas(element, x, y);
		waitForPageToLoad();
	}

	@When("^I click on \"([^\"]*)\" and drag my mouse over by offset (\\d+) and (\\d+)$")
	public void i_click_on_and_drag_my_mouse_over_by_offset_and(String element, int x, int y) throws Throwable {
		clickAndMoveByOffset(element, x, y);
		waitForPageToLoad();
	}

	@When("^I click on \"(.*?)\" of \"(.*?)\"$")
	public void i_click(String element, String param) throws Throwable {
		RandomData randomData = new RandomData();
		param = randomData.getRandomString(param);
		click(element, param);
	}

	@When("^I click by javascript \"([^\"]*)\"$")
	public void click_on_the_using_javascript_in_time(String element) throws Throwable {
		clickByJavascript(element);
	}

	@When("^I switch to the second tab$")
	public void i_switch_to_second_tab() throws Throwable {
		Set<String> set = driver.getWindowHandles();
		driver.switchTo().window((String) set.toArray()[1]);
		waitForPageToLoad();
	}

	@When("^I switch to the first tab$")
	public void i_switch_to_first_tab() throws Throwable {
		Set<String> set = driver.getWindowHandles();
		// set.remove(base); // Can't run on ff with this
		driver.switchTo().window((String) set.toArray()[0]);
		waitForPageToLoad();
	}

	@When("^I click \"([^\"]*)\" and switch to the second tab$")
	public void i_click_switch_to_second_tab(String element) throws Throwable {
		click(element);
		// set.remove(base); // Can't run on ff with this
		for (String winHandle : driver.getWindowHandles()) {
			driver.switchTo().window(winHandle);
		}
		// driver.switchTo().window((String) set.toArray()[2]);
		TestLogger.info("current page is " + driver.getTitle());
		waitForPageToLoad();
	}

	@When("^I click \"([^\"]*)\" and switch to the first tab$")
	public void i_click_switch_to_first_tab(String element) throws Throwable {
		click(element);
		pause(2000);
		String base = driver.getWindowHandle();
		Set<String> set = driver.getWindowHandles();
		set.remove(base);
		driver.switchTo().window((String) set.toArray()[1]);
	}

	@When("^I uncheck \"([^\"]*)\"$")
	public void i_uncheck(String element) throws Throwable {
		if (isSelected(element))
			click(element);
	}

	@When("^I check \"([^\"]*)\"$")
	public void i_check(String element) throws Throwable {
		if (!isSelected(element)) {
			click(element);
		}
	}

	@When("^(?:I should see the|I should see the info|I should see the error message|I should see an informative message|I should see the message|I should see the nofification|I should see the notification) \"([^\"]*)\"$")
	public void i_should_see_the_message(String message) throws Throwable {
		Assert.assertTrue(getTextOnPage(message));
	}

	@When("^(?:I should not see the|I should not see the error message|I should not see an informative message|I should not see the message|I should not see the nofification|I should not see the notification) \"([^\"]*)\"$")
	public void i_should_not_see_the_message(String message) throws Throwable {
		Assert.assertFalse(getTextOnPage(message));
	}

	@When("^The text \"([^\"]*)\" should be shown$")
	public void the_message_should_be_shown(String message) throws Throwable {
		Assert.assertTrue(getTextOnPage(message));
	}

	@When("^(?:The element|I should see the) \"([^\"]*)\" (?:should be shown|item)$")
	public void the_element_should_be_shown(String element) throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent(element));
	}

	@When("^(?:The element|I should not see the) \"([^\"]*)\" (?:should not be shown|item)$")
	public void the_element_should_not_be_shown(String element) throws Throwable {
		Assert.assertNull(waitForGetElementPresent(element));
	}

	@When("^(?:The element|I should see the) \"([^\"]*)\" of \"([^\"]*)\" (?:should be shown|item)$")
	public void the_element_should_be_shown2(String element, String param) throws Throwable {
		RandomData randomData = new RandomData();
		String value = randomData.getRandomString(param);
		Assert.assertNotNull(waitForGetElementPresent(element, value));
	}

	@When("^(?:The element|I should not see the) \"([^\"]*)\" of \"([^\"]*)\" (?:should not be shown|item)$")
	public void the_element_should_not_be_shown2(String element, String param) throws Throwable {
		RandomData randomData = new RandomData();
		String value = randomData.getRandomString(param);
		Assert.assertNull(waitForGetElementPresent(element, value));
	}

	@When("^I move the mouse to another (?:location|place)$")
	public void i_move_the_mouse_to_another_location() throws Throwable {
		click("body");
	}

	@Then("^I should be (?:back|redirected) to the \"([^\"]*)\"(?: page| screen)?$")
	public void i_should_be_redirected_to_page(String arg1) throws Throwable {
		waitForUrlContains(arg1);
		String currentUrl = driver.getCurrentUrl().toLowerCase().trim();
		String expectedUrl = (baseUrl.substring(baseUrl.indexOf("://") + 3)
				+ ("/" + arg1.replace(" ", "").toLowerCase()).replace("//", "/")).trim();
		TestLogger.info("currentUrl is " + currentUrl);
		TestLogger.info("expectedUrl is " + expectedUrl);
		Assert.assertEquals(currentUrl + " does not contain " + expectedUrl, currentUrl.contains(expectedUrl), true);

	}

	@Then("^I should be redirected to the \"([^\"]*)\" page in new tab$")
	public void i_should_be_redirected_to_page_in_new_tab(String arg1) throws Throwable {
		String base = driver.getWindowHandle();
		boolean check = false;
		int count = 0;
		while (!check) {
			try {
				Set<String> winHandle = driver.getWindowHandles();
				if (winHandle.size() > 1) {
					check = true;
					winHandle.remove(base);
					driver.switchTo().window((String) winHandle.toArray()[0]);
					pause(2000);
					TestLogger.info(driver.getCurrentUrl());
					TestLogger.info(arg1);
					Assert.assertEquals(driver.getCurrentUrl() + "does not contain " + (arg1.toLowerCase()).trim(),
							driver.getCurrentUrl().toLowerCase().trim().contains((arg1.toLowerCase()).trim()), true);
					// close the window and switch back to the base tab
					driver.close();
					driver.switchTo().window(base);
				}
				pause(1000);
				count++;
				if (count > timeout) {
					TestLogger.error("Can not switch to new tab");
				}
			} catch (Exception e) {
			}
		}
	}

	@Then("^I close other tabs$")
	public void i_close_other_tabs() throws Throwable {
		String current = driver.getWindowHandle();

		for (String handle : driver.getWindowHandles()) {
			if (!handle.equals(current)) {
				driver.switchTo().window(handle);
				driver.close();
			}
		}

		driver.switchTo().window(current);
		pause(2000);
	}

	@When("^I switch to \"(.*)\" window$")
	public void i_switch_to_window(String title) throws Throwable {
		// switchTabandCloseOthers(title);
		switchTab(title);
	}

	@Given("^(?:I go to|I am at the|I am at) \"([^\"]*)\"(?: page)?$")
	public void i_go_to(String arg1) throws Throwable {
		if (!arg1.equals("/"))
			driver.get((baseUrl + arg1).toLowerCase());
		else
			driver.get(baseUrl);
		waitForPageToLoad();
		pause(2000);
	}

	@When("^I close the browser$")
	public void i_close_the_browser() throws Throwable {
		driver.close();
	}

	@When("^I return to the web$")
	public void i_open_the_browser() throws Throwable {
		((JavascriptExecutor) driver).executeScript("window.open()");
		for (String winHandle : driver.getWindowHandles()) {
			driver.switchTo().window(winHandle);
		}

	}

	@When("^[S|s]witch to \"([^\"]*)\" frame$")
	public void swich_to_frame(String iframeName) throws Throwable {
		switchToIFrame(iframeName);
		pause(2000);
	}

	@When("^[S|s]witch back to parent frame$")
	public void swich_back_to_parent_frame() throws Throwable {
		swichBackToParentFrame();
	}

	@When("^[S|s]witch back to main frame$")
	public void swich_back_to_main_frame() throws Throwable {
		swichBackToMainFrame();
	}

	@When("^I press Enter$")
	public void i_press_enter() throws Throwable {
		pressEnterKey();
	}

	@When("^[s|S]tore the number of element \"([^\"]*)\" in variable \"([^\"]*)\"$")
	public void store_the_number_of_element_in_variable(String element, String var) {
		String value = "0";
		if (waitForGetElements(element) == null)
			value = "0";
		else {
			value = String.valueOf(waitForGetElements(element).size());
		}
		TestLogger.info(value);
		listVar.put(var, value);
		TestLogger.info("the number of element is: " + listVar.get(var));
	}

	@When("^[s|S]tore the text of element \"([^\"]*)\" in variable \"([^\"]*)\"$")
	public void store_the_text_of_element_in_variable(String element, String var) {
		String value = waitForGetElementPresent(element).getText();
		TestLogger.info(value);
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@When("^[s|S]tore the number in the text of element \"([^\"]*)\" in variable \"([^\"]*)\"$")
	public void store_the_number_in_the_text_of_element_in_variable(String element, String var) {
		String value = waitForGetElementPresent(element).getText().replaceAll("[^0-9.]", "");
		TestLogger.info(value);
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@When("^[s|S]tore the current date in variable \"([^\"]*)\"$")
	public void store_the_current_date(String var) {
		Date date = new Date();
		String value = new SimpleDateFormat("yyyy-MM-dd").format(date);
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@When("^[s|S]tore the current date of next year in variable \"([^\"]*)\"$")
	public void store_the_current_date_of_next_year(String var) {
		DateTime dt = new DateTime();
		String value = dt.getDayOfNextYear("yyyy-MM-dd", 1);
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@When("^The text of element \"([^\"]*)\" should be equal value of variable \"([^\"]*)\"$")
	public void text_element_equal_variable(String element, String var) {
		String value = waitForGetElementPresent(element).getText();
		Assert.assertEquals(value + " is not equal " + listVar.get(var), value, listVar.get(var));
	}

	@When("^[s|S]tore the text \"([^\"]*)\" in variable \"([^\"]*)\"$")
	public void store_the_text_in_variable(String text, String var) {
		RandomData randomData = new RandomData();
		String value = randomData.getRandomString(text);
		TestLogger.info(value);
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@When("^[s|S]tore the value of element \"([^\"]*)\" in variable \"([^\"]*)\"$")
	public void store_the_value_of_element_in_variable(String element, String var) {
		String value = waitForGetElementPresent(element).getAttribute("value");
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@When("^[s|S]tore the status of checkbox element \"([^\"]*)\" in variable \"([^\"]*)\"$")
	public void store_the_status_of_checkbox_element_in_variable(String element, String var) {
		String value = waitForGetElementPresent(element).getAttribute("checked");
		if (value == null)
			;
		value = "null";
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@Then("^The variable \"([^\"]*)\" should be equal to variable \"([^\"]*)\"$")
	public void the_variable1_equal_variable2(String var1, String var2) {
		TestLogger.info("var1 is " + listVar.get(var1));
		TestLogger.info("var2 is " + listVar.get(var2));
		if (isNumeric(listVar.get(var1)) && isNumeric(listVar.get(var2)))
			Assert.assertEquals(
					Double.valueOf(listVar.get(var1)) + " is not equal " + Double.valueOf(listVar.get(var2)),
					Double.valueOf(listVar.get(var1)), Double.valueOf(listVar.get(var2)));
		else
			Assert.assertEquals(listVar.get(var1) + " is not equal " + listVar.get(var2), listVar.get(var1),
					listVar.get(var2));
	}

	@Then("^The variable \"([^\"]*)\" should be equal to variable \"([^\"]*)\" plus \"([^\"]*)\"$")
	public void the_variable1_equal_variable2_plus(String var1, String var2, String plus) {
		TestLogger.info("var1 is " + listVar.get(var1));
		TestLogger.info("var2 is " + listVar.get(var2));
		if (isNumeric(listVar.get(var1)) && isNumeric(listVar.get(var2))) {
			Double temp = Double.valueOf(listVar.get(var2)) + Double.valueOf(plus);
			Assert.assertEquals(Double.valueOf(listVar.get(var1)) + " is not equal " + temp,
					Double.valueOf(listVar.get(var1)), temp);
		} else
			Assert.assertEquals(listVar.get(var1) + " is not equal " + listVar.get(var2), listVar.get(var1),
					listVar.get(var2) + plus);
	}

	@Then("^The variable \"([^\"]*)\" should not be equal to variable \"([^\"]*)\"$")
	public void the_variable1_not_equal_variable2(String var1, String var2) {
		TestLogger.info("var1 is " + listVar.get(var1));
		TestLogger.info("var2 is " + listVar.get(var2));
		if (isNumeric(listVar.get(var1)) && isNumeric(listVar.get(var2)))
			Assert.assertNotEquals(
					Double.valueOf(listVar.get(var1)) + " is not equal " + Double.valueOf(listVar.get(var2)),
					Double.valueOf(listVar.get(var1)), Double.valueOf(listVar.get(var2)));
		else
			Assert.assertNotEquals(listVar.get(var1) + " is not equal " + listVar.get(var2), listVar.get(var1),
					listVar.get(var2));
	}

	@Then("^The copied text of clipboard should be equal to variable \"([^\"]*)\"$")
	public void the_text_of_clipboard_should_equal_variable(String var)
			throws HeadlessException, UnsupportedFlavorException, IOException {
		String strCopiedText = (String) Toolkit.getDefaultToolkit().getSystemClipboard()
				.getData(DataFlavor.stringFlavor);
		String strExpectedValue = listVar.get(var);
		String message = String.format("The copied text is [%s], but the expected text is [%s]", strCopiedText,
				strExpectedValue);
		Assert.assertEquals(message, strExpectedValue, strCopiedText);
	}

	@Then("^Store the copied text of clipboard into variable \"([^\"]*)\"$")
	public void store_the_text_of_clipboard_into_variable(String var)
			throws HeadlessException, UnsupportedFlavorException, IOException {
		String strCopiedText = (String) Toolkit.getDefaultToolkit().getSystemClipboard()
				.getData(DataFlavor.stringFlavor);
		listVar.put(var, strCopiedText);
	}

	@When("^I fill value \"([^\"]*)\" to \"([^\"]*)\" textbox and store value into variable \"([^\"]*)\"$")
	public void enter_into_the_field_with_value_and_store_variable(String value, String element, String var) {
		value = sendKey(element, value);
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@When("^[u|U]pload file \"([^\"]*)\"$")
	public void upload_file_using_javascript(String pathFile) throws InterruptedException {
		ManageFile manageFileAction = new ManageFile();
		manageFileAction.uploadFileUsingJavascript(pathFile);
	}

	@When("^[u|U]pload file \"([^\"]*)\" at the element \"(.*)\"$")
	public void upload_file_using_javascript(String pathFile, String target) throws InterruptedException {
		ManageFile manageFileAction = new ManageFile();
		manageFileAction.uploadFileUsingJavascript(target, pathFile);
	}

	@When("^I hover the mouse on the \"([^\"]*)\"$")
	public void i_hover_the_mouse_on(String element) {
		hover(element);
	}

	@When("^[W|w]ait for (\\d+) seconds$")
	public void wait_for_seconds(int time) throws Throwable {
		pause(time * 1000);
	}

	@When("^I haven't added the iorad chrome extension$")
	public void i_have_not_added_the_iorad_chrome_extension() throws Throwable {
		Assert.assertNull(waitForGetElementPresent("homepage.capture_button"));
	}

	@When("^I have added the iorad chrome extension$")
	public void i_have_added_the_iorad_chrome_extension() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("homepage.capture_button"));
	}

	@When("^I scroll down$")
	public void i_scroll_down() throws Throwable {
		scrollDown();
	}

	@When("^I scroll up$")
	public void i_scroll_up() throws Throwable {
		scrollUp();
	}

	@Then("^[t|T]he variable \"([^\"]*)\" should be equal variable \"([^\"]*)\" minus variable \"([^\"]*)\"$")
	public void the_variable_should_be_equal_variable_minus(String var1, String var2, String var3) throws Throwable {
		TestLogger.info("var1 is " + listVar.get(var1));
		TestLogger.info("var2 is " + listVar.get(var2));
		TestLogger.info("var2 is " + listVar.get(var3));
		Assert.assertEquals(
				listVar.get(var1) + " is not equal " + Double.valueOf(listVar.get(var2)) + " - "
						+ Double.valueOf(listVar.get(var3)),
				listVar.get(var1), Double.valueOf(listVar.get(var2)) - Double.valueOf(listVar.get(var3)));
	}

	@Then("^[t|T]he variable \"([^\"]*)\" should be equal variable \"([^\"]*)\" plus variable \"([^\"]*)\"$")
	public void the_variable_should_be_equal_variable_plus(String var1, String var2, String var3) throws Throwable {
		TestLogger.info("var1 is " + listVar.get(var1));
		TestLogger.info("var2 is " + listVar.get(var2));
		TestLogger.info("var2 is " + listVar.get(var3));
		if (isNumeric(listVar.get(var1)) && isNumeric(listVar.get(var2)))
			Assert.assertEquals(
					listVar.get(var1) + " is not equal " + Double.valueOf(listVar.get(var2)) + " + "
							+ Double.valueOf(listVar.get(var3)),
					listVar.get(var1), Double.valueOf(listVar.get(var2)) + Double.valueOf(listVar.get(var3)));
		else
			Assert.assertEquals(listVar.get(var1) + " is not equal " + listVar.get(var2) + " + " + listVar.get(var3),
					listVar.get(var1), listVar.get(var2) + listVar.get(var3));
	}

	@SuppressWarnings("deprecation")
	@Then("^[t|T]he variable \"([^\"]*)\" should be equal variable \"([^\"]*)\" plus \"([^\"]*)\"$")
	public void the_variable_should_be_equal_variable_plus_value(String var1, String var2, String str)
			throws Throwable {
		TestLogger.info("var1 is " + listVar.get(var1));
		TestLogger.info("var2 is " + listVar.get(var2));
		if (isNumeric(listVar.get(var1)) && isNumeric(listVar.get(var2))) {
			Integer expected = Integer.valueOf(listVar.get(var1));
			Integer actual = Integer.valueOf(listVar.get(var2)) + Integer.valueOf(str);
			Assert.assertEquals(listVar.get(var1) + " is not equal " + listVar.get(var2) + " + " + str, expected,
					actual);
		} else {
			double expected = Double.valueOf(listVar.get(var1));
			double actual = Double.valueOf(listVar.get(var2)) + Double.valueOf(str);
			Assert.assertEquals(listVar.get(var1) + " is not equal " + listVar.get(var2) + " + " + str, expected,
					actual);
		}

	}

	@Then("^[t|T]he variable \"([^\"]*)\" should be smaller than variable \"([^\"]*)\"$")
	public void the_variable_should_be_smaller_than_variable(String var1, String var2) throws Throwable {
		TestLogger.info("var1 is " + listVar.get(var1));
		TestLogger.info("var2 is " + listVar.get(var2));
		Assert.assertTrue(Double.valueOf(listVar.get(var1)) + "<" + Double.valueOf(listVar.get(var2)),
				Double.valueOf(listVar.get(var1)) < Double.valueOf(listVar.get(var2)));
	}

	@Then("^Store result of \"([^\"]*)\" plus variable \"([^\"]*)\" into variable \"([^\"]*)\"$")
	public void store_result_of_plus_variables(String var1, String str, String var2) throws Throwable {
		TestLogger.info("var1 is " + listVar.get(var1));
		TestLogger.info("str is " + str);
		String value = listVar.get(var1) + str;
		listVar.put(var2, value);
		TestLogger.info("var2 is " + listVar.get(var2));
	}

	@Then("^[t|T]he variable \"([^\"]*)\" should be equal \"([^\"]*)\"$")
	public void the_variable_should_be_equal(String var1, String param) throws Throwable {
		if (isNumeric(listVar.get(var1)) && isNumeric(param))
			Assert.assertEquals(Double.valueOf(listVar.get(var1)) + " is not equal " + Double.valueOf(param),
					Double.valueOf(listVar.get(var1)), Double.valueOf(param));
		else
			Assert.assertEquals(listVar.get(var1) + " is not equal " + param, listVar.get(var1), param);
	}
	
	@Then("^[t|T]he variable \"([^\"]*)\" should not be equal \"([^\"]*)\"$")
	public void the_variable_should_not_be_equal(String var1, String param) throws Throwable {
		if (isNumeric(listVar.get(var1)) && isNumeric(param))
			Assert.assertNotEquals(Double.valueOf(listVar.get(var1)) + " is equal " + Double.valueOf(param),
					Double.valueOf(listVar.get(var1)), Double.valueOf(param));
		else
			Assert.assertNotEquals(listVar.get(var1) + " is equal " + param, listVar.get(var1), param);
	}

	@When("^I back page$")
	public void back_page() {
		driver.navigate().back();
	}

	@When("^I open a new tab$")
	public void i_open_new_tab() {
		// driver.findElement(By.tagName("body")).sendKeys(Keys.chord(Keys.CONTROL,"t"));
		String a = "window.open('about:blank','_blank');";
		((JavascriptExecutor) driver).executeScript(a);
	}

	@When("^I navigate to url with url is value of variable \"([^\"]*)\"$")
	public void navigate_url(String arg1) {
		driver.get((listVar.get(arg1)));
		waitForPageToLoad();
	}

	@When("^File PDF \"(.*)\" should exists$")
	public void pdf_file_should_be_exist(String var1) {
		ManageFile manageFile = new ManageFile();
		String pathFile = System.getProperty("user.dir") + File.separator + listVar.get(var1) + ".pdf";
		Assert.assertTrue("File is not exist", manageFile.isFileExist(pathFile));
		manageFile.deleteFile(pathFile);
	}
	
	@When("^File zip \"(.*)\" should exists$")
	public void zip_file_should_be_exist(String var1) {
		ManageFile manageFile = new ManageFile();
		String pathFile = System.getProperty("user.dir") + File.separator + listVar.get(var1) + ".zip";
		Assert.assertTrue("File is not exist", manageFile.isFileExist(pathFile));
		manageFile.deleteFile(pathFile);
	}
}

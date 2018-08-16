package scenariosteps;

import org.junit.Assert;
import org.openqa.selenium.JavascriptExecutor;

import cucumber.api.java.en.When;
import iorad.page.PageCore;
import iorad.utils.RandomData;
import iorad.utils.TestLogger;

public class GmailSteps extends PageCore {
	@When("^Open gmail with user \"([^\"]*)\" and password \"([^\"]*)\"(?: again|)$")
	public void open_gmail_with_user_pass(String email, String pass) throws Throwable {
		((JavascriptExecutor) driver).executeScript("window.open()");
		for (String winHandle : driver.getWindowHandles()) {
			driver.switchTo().window(winHandle);
		}
		TestLogger.info(isUsingServerMail);
		TestLogger.info(serverMail);
		if (isUsingServerMail) {
			driver.navigate().to(serverMail);
			driver.manage().window().maximize();
			click("servermail.first_mail");
		} else {

			driver.navigate().to("https://gmail.com");
			driver.manage().window().maximize();

			// login to mail
			if (waitForGetElementPresent("gmail.gmail_user_textbox") == null) {
				if (waitForGetElementPresent("gmail.gmail_sign_in_link") != null)
					click("gmail.gmail_sign_in_link");
				else {
					click("gmail.gmail_sign_in_diff_account");
					click("gmail.gmail_add_account");
				}
			}
			sendKey("gmail.gmail_user_textbox", email);
			pause(1);
			click("gmail.gmail_next_enter_pass_button");
			waitForGetElementPresent("gmail.gmail_pass_textbox");
			pause(1);
			sendKey("gmail.gmail_pass_textbox", pass);
			click("gmail.gmail_sign_in_button");
			click("gmail.gmail_inbox");
			click("gmail.gmail_first_email");
			if (waitForGetElementVisible("gmail.gmail_dot_icon") != null)
				click("gmail.gmail_dot_icon");
		}
	}
	
	@When("^I click on mail with title \"([^\"]*)\" in gmail$")
	public void click_on_title_mail(String title) throws Throwable {
		click(title);
	}

	@When("^The message \"([^\"]*)\" should be shown in gmail$")
	public void the_message_should_be_shown(String message) throws Throwable {
		if (isUsingServerMail) {
			switchToIFrame("servermail.iframe");
		} else {
			for (String winHandle : driver.getWindowHandles()) {
				driver.switchTo().window(winHandle);
			}
		}
		Assert.assertTrue(getTextOnPage(message));
	}
	
	@When("^The element \"([^\"]*)\" should be shown in gmail$")
	public void the_element_should_be_shown(String element) throws Throwable {
		if (isUsingServerMail) {
			switchToIFrame("servermail.iframe");
		} else {
			for (String winHandle : driver.getWindowHandles()) {
				driver.switchTo().window(winHandle);
			}
		}
		Assert.assertNotNull(waitForGetElementPresent(element));
	}

	@When("^The element \"([^\"]*)\" should not be shown in gmail$")
	public void the_element_should_not_be_shown(String element) throws Throwable {
		if (isUsingServerMail) {
			switchToIFrame("servermail.iframe");
			
		} else {
			for (String winHandle : driver.getWindowHandles()) {
				driver.switchTo().window(winHandle);
			}
		}
		Assert.assertNull(waitForGetElementPresent(element));
	}

	@When("^Login to gmail with user \"([^\"]*)\" and password \"([^\"]*)\"$")
	public void login_to_gmail_with_user_pass(String email, String pass) throws Throwable {
		String winHandleBefore = driver.getWindowHandle();
		for (String winHandle : driver.getWindowHandles()) {
			driver.switchTo().window(winHandle);
		}
		sendKey("gmail.gmail_user_textbox", email);
		if (waitForGetElementPresent("gmail.gmail_next_enter_pass_button") != null)
			click("gmail.gmail_next_enter_pass_button");
		sendKey("gmail.gmail_pass_textbox", pass);
		click("gmail.gmail_sign_in_button");
		pause(10);
		for (String winHandle : driver.getWindowHandles()) {
			driver.switchTo().window(winHandle);
		}
		if (waitForGetElementPresent("gmail.confirm_login") != null){
			click("gmail.confirm_login");
			sendKey("gmail.city_txt", "gmail.city_login");
			click("gmail.gmail_next_enter_pass_button");
		}
		// Switch back to original browser (first window)
		driver.switchTo().window(winHandleBefore);

	}

	@When("^The first email title contains message \"([^\"]*)\"$")
	public void the_first_email_title_contains_message(String message) throws Throwable {
		// Get actual email from CommonData
		RandomData randomData = new RandomData();
		message = randomData.getRandomString(message);
		
		if(isUsingServerMail) {
			String strActualMsg = getText("servermail.first_email_title");
			if(!strActualMsg.contains(message)) {
				String error = String.format("The first email title [%s] doesn't not contain expected message [%s]", strActualMsg, message);
				TestLogger.error(error);
				throw new Exception(error);
			}
			else {
				String msg = String.format("The first email title [%s] contains expected message [%s]", strActualMsg, message);
				TestLogger.info(msg);
			}
		}
		else {
			throw new Exception("This step hasn't been implemented for gmail!!!");
		}

	}
	
	@When("^I clear email inbox$")
	public void clear_mail_inbox() throws Throwable {
		
		if(isUsingServerMail) {
			
			waitForGetElementPresent("servermail.clear_inbox_link").click();
			waitForElementNotPresent("servermail.first_email_title");
			
		}
		else {
			throw new Exception("This step hasn't been implemented for gmail!!!");
		}

	}
}

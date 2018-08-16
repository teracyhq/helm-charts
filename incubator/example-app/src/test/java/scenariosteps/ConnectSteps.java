package scenariosteps;

import org.openqa.selenium.JavascriptExecutor;

import cucumber.api.java.en.When;
import iorad.page.IoradBase;
import iorad.utils.RandomData;
import iorad.utils.TestLogger;

public class ConnectSteps extends IoradBase {
	@When("^Get valid connect your website domain and store in variable \"([^\"]*)\"$")
	public void get_valid_connect_domain(String var) throws Throwable {
		// get uid of current user
		openLeftMenuPanel();
		click("left_menu.connect");
		click("iorad_connect.connect_your_website_button");
		sendKey("iorad_connect_website.domain_textbox", "iorad_connect_website.valid_domain");
		click("iorad_connect_website.connect_your_website_button");
		String uid = waitForGetElementPresent("iorad_connect_website.wiget_code_textarea").getText()
				.replaceAll("[^0-9.]", "").replace(".", "");
		click("iorad_connect_website.cancel_button");
		RandomData randomData = new RandomData();
		String url=uid+"."+randomData.getRandomString("iorad_connect_website.valid_domain");
		listVar.put(var, url);
		TestLogger.info("valid connect your website domain is " + listVar.get(url));
	}

	@When("^Open website to change the embeded widget code to paste variable \"([^\"]*)\"$")
	public void free_open_website_to_paste_widget_code(String var) throws Throwable {
		String winHandleBefore = driver.getWindowHandle();
		((JavascriptExecutor) driver).executeScript("window.open()");
		for (String winHandle : driver.getWindowHandles()) {
			driver.switchTo().window(winHandle);
		}
		driver.navigate().to("http://inlims.com/onefilecms.php");
		driver.manage().window().maximize();
		sendKey("inlims.username_textbox", "username");
		sendKey("inlims.password_textbox", "password");
		click("inlims.enter_button");
		click("inlims.indexphp_link");
		String oldTextArea = waitForGetElementPresent("inlims.textarea").getText();
		Integer firstIndex = oldTextArea.indexOf("<script");
		Integer lastIndex = oldTextArea.indexOf("</script>';");
		TestLogger.info(oldTextArea.substring(firstIndex, lastIndex + 9));
		String oldContent = oldTextArea.substring(firstIndex, lastIndex + 9).trim();
		String newContent = waitForGetElementPresent("inlims.textarea").getText().replace(oldContent, listVar.get(var));
		waitForGetElementPresent("inlims.textarea").clear();
		waitForGetElementPresent("inlims.textarea").sendKeys(newContent);
		click("inlims.save_file_button");
		// Switch back to original browser (first window)
		driver.switchTo().window(winHandleBefore);
	}

	@When("^Disconnect website$")
	public void disconnect_website() {
		TestLogger.info("Disconnect website");
		if (waitForGetElementPresent("iorad_connect_website.edit_button") != null) {
			click("iorad_connect_website.edit_button");
			click("iorad_connect_website.disconnect_widget");
		}

	}

	@When("^Open the iorad widget$")
	public void open_widget() {
		if (waitForGetElementPresent("iorad_connect_website.arrow_widget_icon") != null) {
			click("iorad_connect_website.arrow_widget_icon");
		}

	}

	@When("^Close the iorad widget$")
	public void close_widget() {
		if (waitForGetElementPresent("iorad_connect_website.close_widget_button") != null) {
			click("iorad_connect_website.close_widget_button");
		}

	}

	@When("^[s|S]tore valid domain in variable \"([^\"]*)\"$")
	public void store_valid_domain_in_variable(String var) {
		// Write code here that turns the phrase above into concrete actions
		openLeftMenuPanel();
		click("left_menu.capture");
		String curUrl = driver.getCurrentUrl();
		String uid = "";
		if (curUrl.indexOf("#") >= 0) {
			uid = curUrl.substring(curUrl.indexOf("uid=") + 4, curUrl.indexOf("#"));
		} else {
			uid = curUrl.substring(curUrl.indexOf("uid=") + 4);
		}
		redirectToUrl(baseUrl + "/api/actScheduledDowngradePlan?test=manualRun&userIds=" + uid);
		pause(3);
		redirectToUrl(baseUrl);
		listVar.put(var,
				uid + "." + baseUrl.replace("http://", "").replace("https://", "").replace(".", "00") + ".inlims.com");
		TestLogger.info(listVar.get(var));
	}
}

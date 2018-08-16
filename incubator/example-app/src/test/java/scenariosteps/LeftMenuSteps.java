package scenariosteps;

import org.junit.Assert;

import cucumber.api.java.en.When;
import iorad.page.IoradBase;
import iorad.utils.RandomData;
import iorad.utils.TestLogger;

public class LeftMenuSteps extends IoradBase{
	@When("^I click on the \"([^\"]*)\" (?:button from the slide out menu|on the left panel)$")
	public void i_click_from_the_slide_out_menu(String element) throws Throwable {
		openLeftMenuPanel();
		click(element);
	}
	
	@When("^My public name should be \"([^\"]*)\"$")
	public void my_public_name_should_be(String arg1) throws Throwable {
	    // Write code here that turns the phrase above into concrete actions
		openLeftMenuPanel();
		RandomData randomData = new RandomData();
		openLeftMenuPanel();
		TestLogger.info("fullname is "+waitForGetElementPresent("left_menu.fullname").getText());
		Assert.assertEquals((waitForGetElementPresent("left_menu.fullname").getText())+" is not equal "+randomData.getRandomString(arg1),(waitForGetElementPresent("left_menu.fullname").getText()),randomData.getRandomString(arg1));
	}
}

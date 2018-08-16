package scenariosteps;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.junit.Assert;

import cucumber.api.java.en.Then;
import iorad.page.PageCore;
import iorad.utils.TestLogger;

public class AccountMenuSteps extends PageCore{
	@Then("^I should be in Live Plan$")
	public void i_should_be_in_live_plan() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.live_plan"));
	}
	
	@Then("^I should be in Live - Annual Plan$")
	public void i_should_be_in_live_annual_plan() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.live_annual_plan"));
	}
	
	@Then("^I should be in Premium Private Plan$")
	public void i_should_be_in_premium_private_plan() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.premium_private_plan"));
	}

	@Then("^I should be in Free Plan$")
	public void i_should_be_in_free_plan() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.free_plan"));
	}

	@Then("^I should see the plan price as \\$(?:0)$")
	public void i_should_see_the_plan_price_as_$() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.free_plan_price_0"));
	}
	@Then("^I should see the plan price I have to pay$")
	public void i_should_see_the_plan_price_i_have_to_pay_$() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.price_plan"));
	}
	@Then("^I should see my current plan info$")
	public void i_should_see_my_current_plan_info_$() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.plan_info"));
	}
	@Then("^I should see the creator number$")
	public void i_should_see_the_creator_number() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.creator_number"));
	}
	
	@Then("^I should see the info Team member - no charge$")
	public void i_should_see_the_info_team_member_no_charge() throws Throwable {
		Assert.assertNotNull(waitForGetElementPresent("my_plan.creator_number"));
	}
	
	@Then("^Store the anniversary date information from account page in variable \"([^\"]*)\"$")
	public void store_new_annivesary_date_account_page(String var) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String value = waitForGetElementPresent("my_plan.anniveary_info").getText();
		value = value.substring(value.lastIndexOf("on") + 3);
		Date date = new SimpleDateFormat("yyyy-MM-dd").parse(value);
		value = new SimpleDateFormat("yyyy-MM-dd").format(date);
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}
	
	@Then("^I should be redirected to the leave team confirmation page$")
	public void i_should_be_redirected_to_the_leave_team_confirmation_page() throws Throwable {
		
		String expectText1 = "Are you sure you want to leave the team?";
		String expectText2 = "You will be converted to the free public plan immediately.";
		String expectText3 = "All your tutorials will be transferred to the admin.";
		// The messages are correct
		Assert.assertTrue(getTextOnPage(expectText1));
		Assert.assertTrue(getTextOnPage(expectText2));
		Assert.assertTrue(getTextOnPage(expectText3));
		// Confirm password
		Assert.assertNotNull(waitForGetElementVisible("my_account.confirm_password"));
		// Yes, I'm sure
		Assert.assertNotNull(waitForGetElementVisible("my_account.agree_button"));
		// Cancel
		Assert.assertNotNull(waitForGetElementVisible("my_account.cancel_button"));
		
	}
	
	// Only accept 7 days/ 14 days/ 1 month as parameters
	@Then("^The trial ends Date for trial plan \"(.*)\" should be correct$")
	public void trial_end_date_should_correct(String trialPlanType) throws Throwable {
		int trialDay = 0;
		
		if (trialPlanType.contains("7 days")) {
			trialDay = 7;
		}
		else if (trialPlanType.contains("14 days")) {
			trialDay = 14;
		}
		else if (trialPlanType.contains("1 month")) {
			trialDay = 30;
		}
		else {
			throw new Exception("Check the parameter, please!");
		}
		
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DATE, trialDay);
		Date trialEndsDate = c.getTime();
		
		String trialEndsDateMessage  = "Trial ends on " + new SimpleDateFormat("MMMMM dd, yyyy").format(trialEndsDate);
		String error = String.format("The trial plan for [%s], but the trial ends date is [%s]", trialPlanType, trialEndsDateMessage);
		Assert.assertTrue(error, getTextOnPage(trialEndsDateMessage));
	}
	
}


package scenariosteps;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.junit.Assert;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import iorad.page.DateTime;
import iorad.page.IoradBase;
import iorad.utils.RandomData;
import iorad.utils.TestLogger;

public class CheckoutSteps extends IoradBase {
	@When("^I switch to new plan$")
	public void i_switch_to_new_plan() throws Throwable {
		if (waitForGetElementPresent("checkout.switch_to_new_plan") != null)
			click("checkout.switch_to_new_plan");
	}

	@When("^The \"Amount Due\" should be equal to \\[\"New annual subscription\" - \"Current plan prorated credit\"\\]$")
	public void the_should_be_equal_to_New_annual_subscription_Current_plan_prorated_credit() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String newannualsubscriptioninfo = waitForGetElementPresent("checkout.new_annual_subscription_amount")
				.getText();
		String currentplanproratedcreditinfo = waitForGetElementPresent("checkout.current_plan_prorated_credit_info")
				.getText();
		String amountdueinfo1 = waitForGetElementPresent("checkout.amount_due_info_1").getText();
		String amountdueinfo2 = "0." + waitForGetElementPresent("checkout.amount_due_info_2").getText();
		Double amountdueinfo = Double.valueOf(amountdueinfo1) + Double.valueOf(amountdueinfo2);
		DecimalFormat df = new DecimalFormat("###.##");
		Double temp = Double.valueOf(
				df.format(Double.valueOf(newannualsubscriptioninfo) - Double.valueOf(currentplanproratedcreditinfo)));
		Assert.assertEquals(amountdueinfo + "is not equal " + temp, amountdueinfo, temp);
	}

	@When("^I should see the info about \"Next invoice of \\[New annual subscription\\] is due on\" variable \"([^\"]*)\"$")
	public void i_should_see_the_info_about_next_invoice_of_new_annual_subscription(String varDate) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String actualText="";
		String newannualsubscriptioninfo = waitForGetElementPresent("checkout.new_annual_subscription_amount")
				.getText();
		DateFormat formatter = new SimpleDateFormat("MMMM dd, yyyy");
		Date date = formatter.parse(listVar.get(varDate));
		String expectText = "Next invoice of $" + newannualsubscriptioninfo + " is due on " + formatter.format(date);
		TestLogger.info(expectText);
		if (waitForGetElementPresent("checkout.notification_message") != null) {
			actualText = (waitForGetElementPresent("checkout.notification_message")).getText();
			Assert.assertEquals(actualText + " is not qual " + expectText, expectText, actualText);
		}
		else
			Assert.assertTrue(getTextOnPage(expectText));
	}

	@When("^(?:I should see the notify|I should see the message) \"Your plan changes will be effective on\" variable \"([^\"]*)\"$")
	public void i_should_see_the_info_about_effective_of_new_plan(String varDate) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String actualText="";
		DateFormat formatter = new SimpleDateFormat("MMMM dd, yyyy");
		Date date = formatter.parse(listVar.get(varDate));
		String expectText = "Your plan changes will be effective on " + formatter.format(date);
		TestLogger.info(expectText);
		if (waitForGetElementPresent("checkout.notification_message") != null) {
			actualText = (waitForGetElementPresent("checkout.notification_message")).getText();
			Assert.assertEquals(actualText + " is not qual " + expectText, expectText, actualText);
		}
		else
			Assert.assertTrue(getTextOnPage(expectText));
	}

	@When("^The notification \"You will be converted to the Free Public Plan on\" variable \"([^\"]*)\" should be shown$")
	public void the_notification_you_will_be_converted_to_the_free_public_plan(String varDate) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String actualText="";
		DateFormat formatter = new SimpleDateFormat("MMMM dd, yyyy");
		Date date = formatter.parse(listVar.get(varDate));
		String expectText = "You will be converted to the Free Public Plan on " + formatter.format(date);
		TestLogger.info(expectText);
		if (waitForGetElementPresent("checkout.notification_message") != null) {
			actualText = (waitForGetElementPresent("checkout.notification_message")).getText();
			Assert.assertEquals(actualText + " is not qual " + expectText, expectText, actualText);
		}
		else
			Assert.assertTrue(getTextOnPage(expectText));
	}

	@When("^The anniversary date should be today$")
	public void the_anniversary_date_should_be_today() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		DateTime dateTime = new DateTime();
		String value = waitForGetElementPresent("checkout.current_annivesary_info").getText();
		TestLogger.info(value);
		String expected_value = "";
		Boolean subcriptionType = waitForGetElementPresent("checkout.checked_subcription_type").getAttribute("id")
				.toLowerCase().contains("yearly") ? true : false;
		TestLogger.info("current subcription type is "
				+ waitForGetElementPresent("checkout.checked_subcription_type").getAttribute("id").toLowerCase());
		if (subcriptionType == true) {
			expected_value = dateTime.getDayOfNextYear("MMMM dd, yyyy", 1);
		} else {
			expected_value = dateTime.getDayOfNextMonth("MMMM dd, yyyy", 1);
		}
		String actual_value = value.substring(value.lastIndexOf("on") + 3);
		Assert.assertEquals(expected_value + " is not equal " + actual_value, expected_value, actual_value);
	}

	@When("^I should see the info about activation info of plan$")
	public void i_should_see_the_info_about_activation_plan() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String expectStr = "Your new plan will become active on ";
		Assert.assertTrue(getTextOnPage(expectStr));
	}

	@Then("^The \"([^\"]*)\" should be \\$(\\d+)\\.(\\d+)$")
	public void the_should_be_$(String element, int arg2, int arg3) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		if (arg3 == 0)
			Assert.assertNotNull((waitForGetElementPresent(element, String.valueOf(arg2), "00")));
		else
			Assert.assertNotNull((waitForGetElementPresent(element, String.valueOf(arg2), String.valueOf(arg3))));
	}

	@Then("^Store the anniversary date information from checkout page in variable \"([^\"]*)\"$")
	public void store_new_annivesary_date_checkout_page(String var) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String value = waitForGetElementPresent("checkout.new_annivesary_info").getText();
		value = value.substring(value.lastIndexOf("on") + 3);
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date = formatter.parse(listVar.get(value));
		value = formatter.format(date);
		listVar.put(var, value);
		TestLogger.info(listVar.get(var));
	}

	@Then("^I should see the (?:\"New annual subscription\"|\"New monthly subscription\") info$")
	public void i_should_see_the_new_annual_subscription_info() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		RandomData randomData = new RandomData();
		Integer expectedPrice = 0;
		Integer numCreator = Integer.valueOf(waitForGetElementPresent("checkout.number_of_creator").getText());
		Integer originalMonthlyPrice, addOneCreatorMonthlyPrice, saveNumberMonth;
		String spanType = "";
		if (waitForGetElementPresent("checkout.plan_type_info") != null) {
			spanType = waitForGetElementPresent("checkout.plan_type_info").getText().toLowerCase();
		} else {
			spanType = waitForGetElementPresent("checkout.checkout_form.plan_type_info").getText().toLowerCase();
		}
		if (spanType.contains("private")) {
			originalMonthlyPrice = Integer
					.valueOf(randomData.getRandomString("checkout.original_monthtly_price_private"));
			addOneCreatorMonthlyPrice = Integer
					.valueOf(randomData.getRandomString("checkout.add_one_creator_monthly_price_private"));
			saveNumberMonth = Integer.valueOf(randomData.getRandomString("checkout.save_number_month_private"));
			numCreator = numCreator - 1;

		} else if (spanType.contains("premium")) {
			originalMonthlyPrice = Integer
					.valueOf(randomData.getRandomString("checkout.original_monthtly_price_premium"));
			addOneCreatorMonthlyPrice = Integer
					.valueOf(randomData.getRandomString("checkout.add_one_creator_monthly_price_premium"));
			saveNumberMonth = Integer.valueOf(randomData.getRandomString("checkout.save_number_month_premium"));
			numCreator = numCreator - 2;

		} else {// if(spanType.contains("live")) {
			originalMonthlyPrice = Integer.valueOf(randomData.getRandomString("checkout.original_monthtly_price_live"));
			addOneCreatorMonthlyPrice = Integer
					.valueOf(randomData.getRandomString("checkout.add_one_creator_monthly_price_live"));
			saveNumberMonth = Integer.valueOf(randomData.getRandomString("checkout.save_number_month_live"));
			numCreator = numCreator - 4;

		}

		Integer actualPrice = Integer
				.valueOf((waitForGetElementPresent("checkout.new_annual_subscription_amount").getText().substring(
						waitForGetElementPresent("checkout.new_annual_subscription_amount").getText().indexOf("$")
								+ 1)));
		if (waitForGetElementPresent("checkout.yearly").getAttribute("class").contains("checked"))
			expectedPrice = (originalMonthlyPrice + (addOneCreatorMonthlyPrice * numCreator)) * (12 - saveNumberMonth);
		else
			expectedPrice = (originalMonthlyPrice + (addOneCreatorMonthlyPrice * (numCreator)));
		Assert.assertEquals(actualPrice + " is not qual " + expectedPrice, expectedPrice, actualPrice);
	}

	@When("^I get new subscription and store in variable \"([^\"]*)\"$")
	public void get_new_subscription(String amountVar) throws Throwable {
		String amount = waitForGetElementPresent("checkout.new_annual_subscription_amount").getText();
		listVar.put(amountVar, amount);
		TestLogger.info("new subscription is " + listVar.get(amountVar));
	}

	@When("^The \"Balance due right now\" should be equal to the price of \"New annual / monthly subscription - Current subscription credit\"$")
	public void check_balance_due_right_now() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Double currentSubcriptionAmount = Double
				.valueOf((waitForGetElementPresent("checkout.current_subcription_credit_amount").getText().substring(
						waitForGetElementPresent("checkout.current_subcription_credit_amount").getText().indexOf("$")
								+ 1)));
		Double annualMonthlyAmount = Double
				.valueOf((waitForGetElementPresent("checkout.new_annual_subscription_amount").getText().substring(
						waitForGetElementPresent("checkout.new_annual_subscription_amount").getText().indexOf("$")
								+ 1)));
		Double actualAmount = Double.valueOf((waitForGetElementPresent("checkout.balance_amount").getText()
				.substring(waitForGetElementPresent("checkout.balance_amount").getText().indexOf("$") + 1)));
		Double expectAmount = annualMonthlyAmount - currentSubcriptionAmount;
		Assert.assertEquals(actualAmount + " is not qual " + expectAmount, expectAmount, actualAmount);
	}

	@When("^I should see the info about \"Next invoice of xxxx is due on Month dd yyyy\"$")
	public void i_should_see_current_subscription_credit_info() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Boolean subcriptionType = waitForGetElementPresent("checkout.checked_subcription_type").getAttribute("id")
				.toLowerCase().contains("yearly") ? true : false;
		TestLogger.info("current subcription type is "
				+ waitForGetElementPresent("checkout.checked_subcription_type").getAttribute("id").toLowerCase());
		String nextInvoiceDate = "";
		DateTime dateTime = new DateTime();
		if (subcriptionType == true) {
			nextInvoiceDate = dateTime.getDayOfNextYear("MMMM dd, yyyy", 1);
		} else {
			nextInvoiceDate = dateTime.getDayOfNextMonth("MMMM dd, yyyy", 1);
		}
		String annualMonthlyAmount = waitForGetElementPresent("checkout.new_annual_subscription_amount").getText();
		String expected = "Next invoice of " + annualMonthlyAmount + " is due on " + nextInvoiceDate;
		String actual = waitForGetElementPresent("checkout.annivesary_info_after_button_checkout").getText();
		Assert.assertEquals(actual + " is not qual " + expected, expected, actual);
	}

	@Then("^The \"Balance due right now\" should be \\$(\\d+)$")
	public void the_should_be_$(int amount) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		Integer actualAmount = Integer.valueOf((waitForGetElementPresent("checkout.balance_amount").getText()
				.substring(waitForGetElementPresent("checkout.balance_amount").getText().indexOf("$") + 1)));
		Integer expectAmount = Integer.valueOf(amount);
		Assert.assertEquals(actualAmount + " is not qual " + expectAmount, expectAmount, actualAmount);
	}

	@When("^I get checkout date and store in variable \"([^\"]*)\"$")
	public void get_checkout_date(String dateVar) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		// get uid of current user
		openLeftMenuPanel();
		click("left_menu.account");
		click("my_plan.my_plan_link");
		Boolean subcriptionType = waitForGetElementPresent("checkout.checked_subcription_type").getAttribute("id")
				.toLowerCase().contains("yearly") ? true : false;
		TestLogger.info("current subcription type is "
				+ waitForGetElementPresent("checkout.checked_subcription_type").getAttribute("id").toLowerCase());
		SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");
		String nextInvoice = waitForGetElementPresent("checkout.plan_information").getText();
		if (nextInvoice.isEmpty() || nextInvoice == "") {
			if (subcriptionType == true)// yearly
			{
				click("billing_information.billing_information_link");
				String dateStr = waitForGetElementPresent("checkout.transaction_list.first_transaction").getText();
				dateStr = dateStr.substring(dateStr.indexOf("on") + 3, dateStr.indexOf(",") + 6);
				TestLogger.info("current checkout date is " + dateStr);

				Date date = formatter.parse(dateStr);
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.YEAR, 1);
				Date nextYear = cal.getTime();
				listVar.put(dateVar, formatter.format(nextYear));
				TestLogger.info("next checkout date is " + listVar.get(dateVar));
			} else// monthly
			{
				String dateStr = waitForGetElementPresent("checkout.plan_information").getText();
				dateStr = dateStr.substring(dateStr.indexOf("on") + 3);
				TestLogger.info("current checkout date is " + dateStr);
				listVar.put(dateVar, dateStr);
				TestLogger.info("next checkout date is " + listVar.get(dateStr));
			}
		} else {
			String dateStr = waitForGetElementPresent("checkout.plan_information").getText();
			dateStr = dateStr.substring(dateStr.indexOf("on") + 3);
			if (dateStr.contains("on"))
				dateStr = dateStr.substring(dateStr.indexOf("on") + 3);
			TestLogger.info("current checkout date is " + dateStr);
			listVar.put(dateVar, dateStr);
			TestLogger.info("next checkout date is " + listVar.get(dateStr));
		}
	}

	@When("^I run schedule task$")
	public void run_schedule_task() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		// get uid of current user
		openLeftMenuPanel();
		click("left_menu.connect");
		click("iorad_connect.connect_your_website_button");
		sendKey("iorad_connect_website.domain_textbox", "iorad_connect_website.valid_domain");
		click("iorad_connect_website.connect_your_website_button");
		String uid = waitForGetElementPresent("iorad_connect_website.wiget_code_textarea").getText()
				.replaceAll("[^0-9.]", "").replace(".", "");

		// logout from current user
		openLeftMenuPanel();
		click("left_menu.logout");

		// login as admin
		sendKey("login.email", "adminuser");
		sendKey("login.password", "adminpassword");
		click("login.login_button");
		pause(1000);
		// run schedulte task
		TestLogger.info("link to run schedule task is: " + baseUrl
				+ "/api/actScheduledDowngradePlan?test=manualRun&userIds=" + uid);
		try {
			driver.get(baseUrl + "/api/actScheduledDowngradePlan?test=manualRun&userIds=" + uid);
		} catch (Exception e) {
			driver.navigate().refresh();
		}
		// logout from current user
		openLeftMenuPanel();
		click("left_menu.logout");
	}

	@Then("^Store the number of creator in variable \"([^\"]*)\"$")
	public void store_the_number_of_creator(String var) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String numCreator = waitForGetElementPresent("checkout.number_of_creator").getText();
		listVar.put(var, numCreator);
		TestLogger.info("number of creator is " + listVar.get(var));
	}

	@Then("^Store the status of checkbox yearly in variable \"([^\"]*)\"$")
	public void store_the_status_of_checkbox_yearly(String var) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String status = waitForGetElementPresent("checkout.yearly").getAttribute("class");
		TestLogger.info(status);
		status = (status.isEmpty() || status == null || status == "" || !status.contains("checked")) ? ""
				:"checked";
		listVar.put(var, status);
		TestLogger.info("status of checkbox yearly is: "+listVar.get(var));
	}

	@Then("^Store the status of checkbox monthly in variable \"([^\"]*)\"$")
	public void store_the_status_of_checkbox_monthly(String var) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String status = waitForGetElementPresent("checkout.monthly").getAttribute("class");
		TestLogger.info(status);
		status = (status.isEmpty() || status == null || status == "" || !status.contains("checked")) ? ""
				: "checked";
		listVar.put(var, status);
		TestLogger.info("status of checkbox monthly is: "+listVar.get(var));
	}

	@When("^I should be redirected to the confirmation page$")
	public void i_should_be_redirected_to_the_confirmation_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String expectText = "Cancelling your premium membership?";
		Assert.assertTrue(getTextOnPage(expectText));
	}

	@Then("^My plan should be changed into free$")
	public void my_plan_should_be_changed_into_free() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		openLeftMenuPanel();
		click("left_menu.account");
		Assert.assertTrue(getTextOnPage("Free"));
		click("checkout.three_dot_icon");
		Assert.assertNull(waitForGetElementPresent("checkout.downgrade_plan_to_iorad_free_link"));
		Assert.assertNull(waitForGetElementPresent("checkout.awaiting_downgrade_link"));
	}

	@Then("^I should see the nofification \"([^\"]*)\" \"([^\"]*)\"$")
	public void i_should_see_the_nofification(String arg1, String var) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String expectText = arg1 + " " + listVar.get(var);
		String actualText = "";
		if (waitForGetElementPresent("checkout.notification_message") != null)
			actualText = (waitForGetElementPresent("checkout.notification_message")).getText();
		else
			actualText = (waitForGetElementPresent("checkout.next_invoice_message")).getText();
		Assert.assertEquals(actualText + " is not qual " + expectText, expectText, actualText);
	}

	@Then("^I should see the nofification \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\"$")
	public void i_should_see_the_nofification(String arg1, String var1, String arg2, String var2, String arg3,
			String var3) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		String expectText = "";
		Boolean subcriptionType = waitForGetElementPresent("checkout.checked_subcription_type").getAttribute("id")
				.toLowerCase().contains("yearly") ? true : false;
		TestLogger.info("current subcription type is "
				+ waitForGetElementPresent("checkout.checked_subcription_type").getAttribute("id").toLowerCase());
		if (subcriptionType) {
			expectText = arg1 + " " + listVar.get(var1) + "/yr" + " " + arg2 + " " + listVar.get(var2) + " " + arg3
					+ " " + listVar.get(var3).substring(0, 3) + "." + listVar.get(var3).substring(4);
		} else {
			expectText = arg1 + " " + listVar.get(var1) + "/mo" + arg2 + " " + listVar.get(var2) + " " + arg3 + " "
					+ listVar.get(var3).substring(0, 3) + "." + listVar.get(var3).substring(4);
		}
		String actualText = (waitForGetElementPresent("checkout.notification_message")).getText();
		Assert.assertEquals(actualText + " is not qual " + expectText, expectText, actualText);
	}

	@When("^The Private Plan should be selected$")
	public void private_plan_should_be_selected() throws Throwable {
		Assert.assertTrue(getTextOnPage("Private Plan Checkout"));
	}

	@When("^The Premium Plan should be selected$")
	public void premium_plan_should_be_selected() throws Throwable {
		Assert.assertTrue(getTextOnPage("Premium Plan Checkout"));
	}

	@When("^The Live Plan should be selected$")
	public void live_plan_should_be_selected() throws Throwable {
		Assert.assertTrue(getTextOnPage("Live Plan Checkout"));
	}

}

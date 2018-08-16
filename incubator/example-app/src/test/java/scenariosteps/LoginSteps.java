package scenariosteps;

import java.util.Date;

import org.junit.Assert;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import iorad.page.PageCore;
import iorad.utils.RandomData;

public class LoginSteps extends PageCore {
	/**
	 * input email and password to login form
	 * 
	 * @param email
	 * @param password
	 */
	public void inputEmailAndPassword(String email, String password) {
		sendKey("login.email", email);
		sendKey("login.password", password);
		pause(1000);
		click("login.login_button");
	}
	
	@Given("(?:^I am a logged in user$|^I log in as a free user$|^I am logged-in as a free verified user$)")
	public void i_am_a_logged_in_user() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		if (waitForGetElementPresent("login.login_button") != null) {
			inputEmailAndPassword("freeverifieduser", "validpassword");
		}
	}

	@Then("^I should be logged out and redirected to the home page$")
	public void i_should_be_logged_out_and_redirected_to_the_home_page() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		click("left_menu.left_menu_icon");
		Assert.assertNotNull(waitForGetElementPresent("left_menu.login"));
	}

	@Given("^I am logged-in as a team owner$")
	public void i_am_a_logged_in_as_team_owner() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		if (waitForGetElementPresent("login.login_button") != null) {
			inputEmailAndPassword("teamowneruser1", "validpassword");
			waitForElementNotPresent("login.login_button");
		}
	}

	@Given("^I am logged-in as a unverified user$")
	public void i_am_a_logged_in_as_unverified_user() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		if (waitForGetElementPresent("login.login_button") != null) {
			inputEmailAndPassword("unverifieduser", "validpassword");
		}
	}

	@Given("^I am logged-in as a team member$")
	public void i_am_a_logged_in_as_team_member_user() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		if (waitForGetElementPresent("login.login_button") != null) {
			inputEmailAndPassword("teammemberuser", "validpassword");
		}
	}

	@Given("(?:^I am logged-in as a premium individual user$|^I log in as a premium user$)")
	public void i_am_a_logged_in_as_premium_individual_user() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		if (waitForGetElementPresent("login.login_button") != null) {
			inputEmailAndPassword("premiumindividualuser1", "validpassword");
		}
	}

	@Given("^I am logged-in as a locked user")
	public void i_am_a_logged_in_as_locked_user() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		if (waitForGetElementPresent("login.login_button") != null) {
			inputEmailAndPassword("lockeduser", "validpassword");
		}
	}

	@Given("^I am a logged-in as an admin$")
	public void i_am_a_logged_in_as_an_admin() throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		if (waitForGetElementPresent("login.login_button") != null) {
			inputEmailAndPassword("adminuser", "adminpassword");
		}
	}

	@Given("^I logged in iroad with my gmail with user \"([^\"]*)\" and password \"([^\"]*)\"$")
	public void i_logged_in_iroad_with_my_gmail(String email, String pass) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		if (waitForGetElementPresent("login.login_button") != null) {
			click("login.login_with_google_button");
			for (String winHandle : driver.getWindowHandles()) {
				driver.switchTo().window(winHandle);
			}
			// login to mail
			if (waitForGetElementPresent("gmail.gmail_user_textbox") == null) {
				if (waitForGetElementPresent("gmail.gmail_sign_in_link") != null)
					click("gmail.gmail_sign_in_link");
				else {
					click("gmail.gmail_sign_in_diff_account");
				}
			}
			sendKey("gmail.gmail_user_textbox", email);
			if (waitForGetElementPresent("gmail.gmail_next_enter_pass_button") != null)
				click("gmail.gmail_next_enter_pass_button");
			sendKey("gmail.gmail_pass_textbox", pass);
			click("gmail.gmail_password_next");
			pause(5000);
			for (String winHandle : driver.getWindowHandles()) {
				driver.switchTo().window(winHandle);
			}
		}
	}

	@Given("^I logged in iroad with user \"([^\"]*)\" and password \"([^\"]*)\"$")
	public void i_logged_in_iroad(String email, String pass) throws Throwable {
		// Write code here that turns the phrase above into concrete actions
		redirectToUrl(baseUrl + "/login");
		inputEmailAndPassword(email, pass);
		waitForElementNotPresent("login.login_button");
	}
	
	@Given("^I signup an anynomous user and store in variable \"([^\"]*)\"$")
	public void i_signup_an_user(String emailVar) throws Throwable {
		// Generate random email
		String email = String.format("autotest.%s@gmail.com", String.valueOf((new Date().getTime())/1000));
		String password = new RandomData().getRandomString("validpassword");
		listVar.put(emailVar, email);
		if(getCurrentUrl().contains("/login") || getCurrentUrl().contains("/signup")) {
			click("signup.signup_tab");
		}
		else {
			click("left_menu.left_menu_icon");
			click("left_menu.signup");
		}
		sendKey("signup.public_name", "auto test");
		sendKey("signup.email", email);
		sendKey("signup.password_signup", password);
		pause(1000);
		click("signup.terms");
		click("signup.signup_button");
		waitForElementNotPresent("signup.signup_button");
		waitForPageToLoad();
	}
	
	@Given("^I generate an anynomous user and store in variable \"([^\"]*)\"$")
	public void i_generate_an_user(String emailVar) throws Throwable {
		// Generate random email
		String email = String.format("autotest.%s@gmail.com", String.valueOf((new Date().getTime())/1000));
		listVar.put(emailVar, email);
	}
}

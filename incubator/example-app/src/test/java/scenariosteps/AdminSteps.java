package scenariosteps;

import org.junit.Assert;

import cucumber.api.java.en.When;
import iorad.page.PageCore;
import iorad.utils.TestLogger;

public class AdminSteps extends PageCore {


	@When("^I enable the plan feature \"(.*)\"$")
	public void enable_plan_feature(String feature) throws Throwable {
		
		while(! getAttribute("class", "admin.edit_plan.feature_tab.plan_feature", feature).contains("on")) {
			click("admin.edit_plan.feature_tab.plan_feature", feature);
		}
		
	}
	
	@When("^I disable the plan feature \"(.*)\"$")
	public void disable_plan_feature(String feature) throws Throwable {
		
		while(getAttribute("class", "admin.edit_plan.feature_tab.plan_feature", feature).contains("on")) {
			click("admin.edit_plan.feature_tab.plan_feature", feature);
		}
		
	}
	
	@When("^I select free plan type \"(.*)\"$")
	public void select_free_plan_type(String freePlanType) throws Throwable {
		
		if(!getText("admin.edit_plan.setting_tab.selected_free_plan").equals(freePlanType)) {
			clickByJavascript("admin.edit_plan.setting_tab.free_plan_control");
			clickByJavascript("admin.edit_plan.setting_tab.free_plan_options", freePlanType);
			Assert.assertTrue(getText("admin.edit_plan.setting_tab.selected_free_plan").equals(freePlanType));
		}
		
	}
	
	@When("^I select view settings plan type \"(.*)\"$")
	public void select_view_settings_plan_type(String viewSettingsType) throws Throwable {
		
		if(!getText("admin.edit_plan.setting_tab.selected_view_settings").equals(viewSettingsType)) {
			click("admin.edit_plan.setting_tab.view_settings_control");
			click("admin.edit_plan.setting_tab.view_settings_options", viewSettingsType);
			Assert.assertTrue(getText("admin.edit_plan.setting_tab.selected_view_settings").equals(viewSettingsType));
		}
		
	}
	// The fixed data below is used for many test cases. Don't try to change it.
	@When("^I create a plan named  \"(.*)\"$")
	public void create_trial_plan_with_cc(String planName) throws Throwable {
		// Create a new plan by clicking on the Plans link from menu
		if(! isPresent("admin.plans.action_btn", planName)) {
			
			click("admin.plans.plans_menu_link");
			// Input plan's name
			sendKey("admin.new_plan.plan_name", planName);
			// Select plan type
			selectDdlByText("admin.new_plan.plan_type", "Special");
			// Basic price
			sendKey("admin.new_plan.basic_price", "1");
			// Per user price
			sendKey("admin.new_plan.per_user_price", "1");
			// Minimum user
			sendKey("admin.new_plan.min_user", "1");
			// Maximum user
			sendKey("admin.new_plan.max_user", "10");
			// Private modules
			sendKey("admin.new_plan.private_module", "10");
			// Themes
			sendKey("admin.new_plan.themes", "1");
			// Free trial period
			selectCheckbox("admin.new_plan.trial_period", true);
			// Set Public plan
			selectCheckbox("admin.new_plan.is_public_plan", true);
			// Redeem count
			sendKey("admin.new_plan.redeem_count", "1");
			// Submit
			click("admin.new_plan.create_plan_btn");
		}
		else {
			TestLogger.info(String.format("The plan [%s] is existing", planName));
		}
		
	}
	
}

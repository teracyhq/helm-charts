package scenariosteps;

import cucumber.api.java.en.When;
import iorad.page.DialogAndAlert;

public class DialogAndAlertSteps extends DialogAndAlert{
	@When("^I accept alert$")
	public void accept_alert() throws Throwable {
		acceptAlert();
	}
}

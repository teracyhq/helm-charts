package iorad.page;

import org.openqa.selenium.NoAlertPresentException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class DialogAndAlert extends PageCore{
	/**
	 * get message from alert popup, then accept alert
	 * @param element
	 * @return
	 */
	public String getAlertMessageThenAccept(){
		waitForAlert();
		String retMsg=getAlert().getText();
		getAlert().accept();
		return retMsg;
	}

	/**
	 * get message from alert popup, then dismiss alert
	 * @param element
	 * @return
	 */
	public String getAlertMessageThenDismiss(){
		waitForAlert();
		String retMsg=getAlert().getText();
		getAlert().dismiss();
		return retMsg;
	}
	
	/**
	 * Accept Alert
	 * @return
	 */
	public String verifyAndAcceptAlertWithoutClickElement() {
		waitForAlert();
		String retMsg=getAlert().getText();
		getAlert().accept();
		return retMsg;
	}
	
	/**
	 * Accept Alert
	 * @return
	 */
	public String verifyAndDismissAlertWithoutClickElement() {
		waitForAlert();
		String retMsg=getAlert().getText();
		getAlert().dismiss();
		return retMsg;
	}
	
	/**
	 * Accept Alert
	 * @param element
	 */
	public void acceptAlert() {
        getAlert().accept();
	}
	
	/**
	 * Dismiss Alert
	 * @param element
	 */
	public void dismissAlert() {
		waitForAlert();
		getAlert().dismiss();
	}

	/**
	 * Enter text to alert
	 * @param element
	 * @param text
	 */
	public void enterTextToAlert(String text) {
		waitForAlert();
		getAlert().sendKeys(text);
		getAlert().accept();
	}

	/**
	 * Wait for alert
	 */
	private void waitForAlert(){
		new WebDriverWait(driver, 60)
        .ignoring(NoAlertPresentException.class)
        .until(ExpectedConditions.alertIsPresent());
	}
	
	/**
	 * verify alert present or not
	 * @return
	 */
	public boolean isAlertPresent(){
	    boolean foundAlert = false;
	    WebDriverWait wait = new WebDriverWait(driver, 60 /*timeout in seconds*/);
	    try {
	        wait.until(ExpectedConditions.alertIsPresent());
	        foundAlert = true;
	    } catch (TimeoutException eTO) {
	        foundAlert = false;
	    }
	    return foundAlert;
	}

}

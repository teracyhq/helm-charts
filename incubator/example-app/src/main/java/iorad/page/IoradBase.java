package iorad.page;

public class IoradBase extends PageCore{
	/**
	 * open left menu panel
	 */
	public void openLeftMenuPanel(){
		if(waitForGetElementPresent("//*[contains(@class,'x undefined')]")==null){
			click("left_menu.left_menu_icon");
		}
	}
}

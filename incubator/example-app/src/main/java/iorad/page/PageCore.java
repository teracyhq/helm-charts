package iorad.page;

import java.awt.Color;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.ClipboardOwner;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.junit.Assert;
import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.Platform;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.interactions.Action;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import iorad.utils.LocatorMap;
import iorad.utils.PropertiesUtil;
import iorad.utils.RandomData;
import iorad.utils.TestLogger;

public class PageCore implements ClipboardOwner {
	protected static int WAIT_INTERVAL = 1000; // milliseconds
	public static Properties config;
	public static Properties elements;
	public static WebDriver driver;
	public static String browserName;
	public static String browserVersion;
	public static String platform;
	public static String baseUrl;
	public static Integer timeout;
	public static String hubUrl;
	public static Boolean failfast;
	public static String serverMail;
	public static Boolean isUsingServerMail;
	String defaultWindow = "";
	public static HashMap<String, String> listVar = new HashMap<String, String>();

	/**
	 * set capabilities for chrome
	 * 
	 * @param opIsAddExtention
	 *            When opIsAddExtention = true --> install iorad extension on chrome
	 *            (firefox is not supported)
	 * @return
	 */
	public DesiredCapabilities setChromeProfile(Boolean... opIsAddExtention) {
		Boolean isAddExtention = opIsAddExtention.length > 0 ? opIsAddExtention[0] : false;
		String pathToExtension = getConfig("iorad.extension.path");
		TestLogger.info(pathToExtension);
		String pathFile=System.getProperty("user.dir");
		HashMap<String, Object> chromePrefs = new HashMap<String, Object>();
		chromePrefs.put("profile.default_content_settings.popups", 0);
		chromePrefs.put("download.default_directory", pathFile);
		ChromeOptions options = new ChromeOptions();
		options.setExperimentalOption("prefs", chromePrefs);
		options.addArguments("--disable-notifications");
		if (isAddExtention) {
			options.addArguments("load-extension=" + pathToExtension);
			// options.addExtensions(new File(pathToExtension));
		}
		DesiredCapabilities capabilities = DesiredCapabilities.chrome();
		if (platform != null && platform != "") {
			if (platform.equalsIgnoreCase("linux")) {
				options.addArguments(Collections.singletonList("--window-position=0,0"));
				options.addArguments(Collections.singletonList("--window-size=1366,768"));
				options.addArguments("disable-infobars");
			} else {
				options.addArguments(Collections.singletonList("--start-maximized"));
			}
			capabilities.setPlatform(Platform.fromString(platform));
		}
		capabilities.setBrowserName(browserName);
		capabilities.setCapability(ChromeOptions.CAPABILITY, options);
		return capabilities;
	}

	/**
	 * set capabilities for firefox
	 * 
	 * @param opIsAddExtention
	 *            When opIsAddExtention = true --> install iorad extension on chrome
	 *            (firefox is not supported)
	 * @return
	 */
	public DesiredCapabilities setFirefoxProfile(Boolean... opIsAddExtention) {
		Boolean isAddExtention = opIsAddExtention.length > 0 ? opIsAddExtention[0] : false;
		String pathToExtension = getConfig("iorad.extension.path");
		TestLogger.info(pathToExtension);
		FirefoxProfile profile = new FirefoxProfile();
		String pathFile=System.getProperty("user.dir");
		if (isAddExtention)
			profile.addExtension(new File(pathToExtension));
		DesiredCapabilities capabilities = DesiredCapabilities.firefox();
		TestLogger.info("Save file to " + pathFile);
		profile.setPreference("browser.download.manager.showWhenStarting", false);
		profile.setPreference("browser.download.dir", pathFile);
		profile.setPreference("browser.download.folderList", 2);
		profile.setPreference("browser.helperApps.neverAsk.saveToDisk", "application/x-xpinstall;" +
				"application/x-zip;application/x-zip-compressed;application/x-winzip;application/zip;" +
				"gzip/document;multipart/x-zip;application/x-gunzip;application/x-gzip;application/x-gzip-compressed;" +
				"application/x-bzip;application/gzipped;application/gzip-compressed;application/gzip" +
				"application/octet-stream" +
				";application/pdf;application/msword;text/plain;" +
				"application/octet;text/calendar;text/x-vcalendar;text/Calendar;" +
				"text/x-vCalendar;image/jpeg;image/jpg;image/jp_;application/jpg;" +
				"application/x-jpg;image/pjpeg;image/pipeg;image/vnd.swiftview-jpeg;image/x-xbitmap;image/png;application/xml;text/xml;text/icalendar;");

		profile.setPreference("plugin.disable_full_page_plugin_for_types", "application/pdf");
		profile.setPreference("pref.downloads.disable_button.edit_actions", true);
		profile.setPreference("pdfjs.disabled", true); 
		profile.setPreference("browser.helperApps.alwaysAsk.force", false);
		// If you are using selenium 3 and test Firefox versions below version
		// 48
		if (browserVersion != null && Integer.parseInt(browserVersion) < 48) {
			capabilities.setCapability(FirefoxDriver.PROFILE, false);
		} else {
			capabilities.setCapability(FirefoxDriver.PROFILE, profile);
		}
		return capabilities;
	}

	/**
	 * set capabilities for IE
	 * 
	 * @return
	 */
	public DesiredCapabilities setIeProfile() {
		DesiredCapabilities capabilities = DesiredCapabilities.internetExplorer();
//		capabilities.setPlatform(Platform.fromString(getConfig("platform")));
//		capabilities.setBrowserName(browserName);
//		capabilities.setCapability(InternetExplorerDriver.REQUIRE_WINDOW_FOCUS, true);
		return capabilities;
	}

	/**
	 * open browser with option adding iorad extension or not
	 * 
	 * @param opIsAddExtention
	 *            When opIsAddExtention = true --> install iorad extension on chrome
	 *            (firefox is not supported)
	 */
	@SuppressWarnings("deprecation")
	public void openThePage(Boolean... opIsAddExtention) {
		elements = LocatorMap.loadingObjectPropertiesFromPackage("elements");
		config = PropertiesUtil.loadConfigSys();
		timeout = Integer.valueOf(getConfig("timeout"));
		hubUrl = getConfig("hub_url");
		failfast = Boolean.valueOf(getConfig("failfast"));
		serverMail = getConfig("servermail");
		isUsingServerMail = Boolean.valueOf(getConfig("isusingservermail"));
		if (hubUrl != null) {
			driver = getRemoteWebDriver(hubUrl, opIsAddExtention);
		} else {
			browserName = getConfig("browser_name");
			switch (browserName.toLowerCase()) {
			case "ie":
				if (System.getProperty("webdriver.ie.driver") == null) {
					System.setProperty("webdriver.ie.driver", config.getProperty("webdriver.ie.driver"));
				}
				driver = new InternetExplorerDriver(setIeProfile());
				break;
			case "chrome":
				if (System.getProperty("webdriver.chrome.driver") == null) {
					System.setProperty("webdriver.chrome.driver", config.getProperty("webdriver.chrome.driver"));
				}
				driver = new ChromeDriver(setChromeProfile(opIsAddExtention));
				break;
			// case "phantomjs":
			// if (System.getProperty("webdriver.phantomjs.driver") == null) {
			// System.setProperty("webdriver.phantomjs.driver",
			// config.getProperty("webdriver.phantomjs.driver"));
			// }
			// System.setProperty("phantomjs.binary.path",
			// System.getProperty("webdriver.phantomjs.driver"));
			// driver = new PhantomJSDriver();
			// browserName = "phantomjs";
			// break;
			case "firefox":
			default: // firefox older than 47
				if (System.getProperty("webdriver.gecko.driver") == null) {
					System.setProperty("webdriver.gecko.driver", config.getProperty("webdriver.gecko.driver"));
				}
				driver = new FirefoxDriver(setFirefoxProfile(opIsAddExtention));
				break;
			}
		}
		// driver.manage().window().maximize();
		// driver.manage().window().setSize(new Dimension(1920, 1080));
		baseUrl = getConfig("base_url");
		driver.navigate().to(baseUrl);
		waitForPageToLoad();
		driver.manage().window().maximize();
	}

	/**
	 * get remotdriver: use for selenium grid
	 * 
	 * @param seleniumHubUrl
	 *            get remotedriver: use for selenium grid
	 * @param opIsAddExtention
	 * @return
	 */
	private WebDriver getRemoteWebDriver(String seleniumHubUrl, Boolean... opIsAddExtention) {
		String pathToExtension = getConfig("iorad.extension.path");
		TestLogger.info(pathToExtension);
		DesiredCapabilities capabilities = new DesiredCapabilities();
		browserName = getConfig("browser_name");
		browserVersion = getConfig("browser_version");
		platform = getConfig("platform");
		if (browserVersion != null) {
			capabilities.setVersion(browserVersion);
		}
		if (platform == null) {
			platform = "";
		}
		// Chrome specifics
		if (browserName.equalsIgnoreCase("chrome")) {
			TestLogger.info("Running with chrome");
			capabilities = setChromeProfile(opIsAddExtention);
		}

		// Firefox specifics
		if (browserName.equalsIgnoreCase("firefox")) {
			TestLogger.info("Running with firefox");
			capabilities = setFirefoxProfile(opIsAddExtention);
		}
		capabilities.setPlatform(Platform.fromString(getConfig("platform")));
		capabilities.setBrowserName(browserName);
		try {
			driver = new RemoteWebDriver(new URL(seleniumHubUrl), capabilities);
			driver.manage().window().maximize(); // Always maximize firefox on
													// windows
			// On LINUX/FIREFOX the "driver.manage().window().maximize()" option
			// does not expand browser window to max screen size. Always set a
			// window size.
			if (platform.equalsIgnoreCase("linux") && browserName.equalsIgnoreCase("firefox")) {
				driver.manage().window().setSize(new Dimension(1920, 1080));
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		return driver;
	}

	/**
	 * redirect to url
	 * 
	 * @param url
	 */
	public void redirectToUrl(String url) {
		TestLogger.info(LocatorMap.getActualValueFromElementList(url));
		driver.get(LocatorMap.getActualValueFromElementList(url));
		waitForPageToLoad();
		TestLogger.info(LocatorMap.getActualValueFromElementList(url));
	}

	/**
	 * wait for page loading
	 */
	public void waitForPageToLoad() {
		String pageLoadStatus = null;
		int count = 1;
		do {
			JavascriptExecutor js = (JavascriptExecutor) driver;
			pageLoadStatus = (String) js.executeScript("return document.readyState");
			TestLogger.info(".");
			pause(1000);
			count++;
			if (count == 30) {
				driver.navigate().refresh();
			}
		} while (!pageLoadStatus.equals("complete"));
		TestLogger.info("Page Loaded.");
	}

	/**
	 * Gets system config else config.properties
	 *
	 * @param key
	 *            config key
	 * @return config value
	 */
	static public String getConfig(String key) {
		Properties config = PropertiesUtil.loadConfigSys();
		String retConfig = (System.getProperty(key) != null ? System.getProperty(key) : config.getProperty(key));
		TestLogger.info(key + ": " + retConfig);
		return retConfig;
	}

	/**
	 * close browserName
	 */
	public void closeBrowser() {
		driver.quit();
	}

	/**
	 * Get the CurrentUrl
	 */
	public String getCurrentUrl() {
		return driver.getCurrentUrl();
	}
	
	/**
	 * Get the page title
	 */
	public String getPageTitle() {
		return driver.getTitle();
	}

	/**
	 * get locator from string
	 * 
	 * @param locator
	 * @return
	 */
	public By getObject(String locator) {
		By by = null;
		try {
			if (locator.startsWith("id=")) {
				locator = locator.substring(3);
				by = By.id(locator);
			} else if (locator.startsWith("name=")) {
				locator = locator.substring(5);
				by = By.name(locator);
			} else if (locator.startsWith("css=")) {
				locator = locator.substring(4);
				by = By.cssSelector(locator);
			} else if (locator.startsWith("linkText=")) {
				locator = locator.substring(9);
				by = By.linkText(locator);
			} else if (locator.startsWith("xpath=")) {
				locator = locator.substring(6);
				by = By.xpath(locator);
			} else if (locator.startsWith("cssSelector=")) {
				locator = locator.substring(12);
				by = By.xpath(locator);
			} else if (locator.startsWith("partialLinkText=")) {
				locator = locator.substring(16);
				by = By.xpath(locator);
			} else if (locator.startsWith("tagName=")) {
				locator = locator.substring(8);
				by = By.xpath(locator);
			} else {
				by = By.xpath(locator);
			}

			return by;
		} catch (Exception e) {
			e.getMessage();
		}

		return null;
	}

	/**
	 * wait
	 * 
	 * @param millis
	 */
	public void pause(long millis) {
		try {
			Thread.sleep(millis);
		} catch (InterruptedException e) {
			// eat the exception
		}
	}

	/**
	 * wait for element not present
	 * 
	 * @param target
	 * @param param
	 */
	public void waitForElementNotPresent(String target, String... param) {
		String locator = null;
		locator = LocatorMap.getActualValueFromElementList(target.replace(" ", "").toLowerCase()).toString();
		if (param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				TestLogger.info(target + ": " + locator);
				locator = locator.replace("$param" + String.valueOf(i + 1), param[i]);
			}
		}
		Boolean isPresent = true;
		for (int tick = 0; tick < timeout; tick++) {
			List<WebElement> elems = driver.findElements(getObject(locator));
			if (elems.isEmpty()) {
				isPresent = false;
				break;
			}
			pause(WAIT_INTERVAL);
		}
		TestLogger.info(isPresent.toString());
		Assert.assertTrue("Timeout after " + timeout * WAIT_INTERVAL + "ms waiting for element not present: "
				+ getObject(locator), (isPresent == false));
	}

	/**
	 * get element
	 * 
	 * @param target
	 * @param param
	 * @return null if element is not present
	 */
	public WebElement waitForGetElementPresent(String target, String... param) {
		String locator = null;
		WebElement elem = null;
		locator = LocatorMap.getActualValueFromElementList(target.replace(" ", "").toLowerCase()).toString();
		if (param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				TestLogger.info(target + ": " + locator);
				locator = locator.replace("$param" + String.valueOf(i + 1), param[i]);
			}
		}
		TestLogger.info(target + ": " + locator);
		for (int tick = 0; tick < timeout; tick++) {
			List<WebElement> elems = driver.findElements(getObject(locator));
			if (elems.size() > 0) {
				elem = driver.findElement(getObject(locator));
				break;
			}
			pause(WAIT_INTERVAL);
		}
		if (elem != null)
			return elem;
		else {
			TestLogger.info("Timeout after " + timeout * WAIT_INTERVAL + "ms waiting for element present: "
					+ getObject(locator));
			return null;
		}
	}

	/**
	 * get visiblity of element
	 * 
	 * @param target
	 * @param param
	 * @return null if element is not visible
	 */
	public WebElement waitForGetElementVisible(String target, String... param) {
		String locator = null;
		locator = LocatorMap.getActualValueFromElementList(target.replace(" ", "").toLowerCase()).toString();
		if (param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				TestLogger.info(target + ": " + locator);
				locator = locator.replace("$param" + String.valueOf(i + 1), param[i]);
			}
		}
		TestLogger.info(target + ": " + locator);
		List<WebElement> elements = waitForGetElements(target, param);
		if(elements.size() >= 1) {
			for(WebElement e : elements) {
				if(e.isDisplayed()) {
					return e;
				}
			}
		}
		TestLogger.warn("Element not visible " + getObject(locator));
		return null;
	}

	/**
	 * get clickable element
	 * 
	 * @param target
	 * @param param
	 * @return null if element is not clickable
	 */
	public WebElement waitForClickableElement(String target, String... param) {
		String locator = null;
		locator = LocatorMap.getActualValueFromElementList(target.replace(" ", "").toLowerCase()).toString();
		if (param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				TestLogger.info(target + ": " + locator);
				locator = locator.replace("$param" + String.valueOf(i + 1), param[i]);
			}
		}
		TestLogger.info(target + ": " + locator);
		try {
			WebDriverWait wait = new WebDriverWait(driver, timeout);
			wait.until(ExpectedConditions.elementToBeClickable(getObject(locator)));
			return driver.findElement(getObject(locator));
		} catch (Exception e) {
			e.getMessage();
		}
		TestLogger.warn("Can not find element " + getObject(locator));
		return null;
	}

	/**
	 * get element list
	 * 
	 * @param target
	 * @param param
	 * @return null if element is not present
	 */
	public List<WebElement> waitForGetElements(String target, String... param) {
		String locator = null;
		locator = LocatorMap.getActualValueFromElementList(target.replace(" ", "").toLowerCase()).toString();
		if (param.length > 0) {
			for (int i = 0; i < param.length; i++) {
				TestLogger.info(target + ": " + locator);
				locator = locator.replace("$param" + String.valueOf(i + 1), param[i]);
			}
		}
		TestLogger.info(target + ": " + locator);
		waitForGetElementPresent(target, param);
		try {
			return driver.findElements(getObject(locator));
		} catch (Exception e) {
			e.getMessage();
		}
		TestLogger.warn("Can not find element " + getObject(locator));
		return null;
	}
	
	/**
	 * Wait for url contain expected msg
	 * 
	 * @param target
	 * @param param
	 * @return null if element is not present
	 */
	public void waitForUrlContains(String text) {
		try {
			WebDriverWait wait = new WebDriverWait(driver, timeout);
			wait.until(ExpectedConditions.urlContains(text));
		} catch (Exception e) {
			e.getMessage();
		}
	}

	/**
	 * get text on page
	 * 
	 * @param text
	 * @return null if text is not vivible
	 */
	public Boolean getTextOnPage(String text) {
		TestLogger.info(text + ": " + LocatorMap.getActualValueFromElementList(text).toString());
		TestLogger.info("//*[contains(text(), \"" + LocatorMap.getActualValueFromElementList(text).toString() + "\")]");
		try {
			WebDriverWait wait = new WebDriverWait(driver, timeout);
			wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath(
					"//*[contains(., \"" + LocatorMap.getActualValueFromElementList(text).toString() + "\")]")));
			return true;
		} catch (Exception e) {
			e.getMessage();
		}
		TestLogger.warn("Can not find text " + LocatorMap.getActualValueFromElementList(text).toString());
		return false;
	}

	/**
	 * get text of an Element
	 * 
	 * @param target
	 * @return String
	 * @throws Exception
	 */
	public String getText(String target, String... params) throws Exception {
		WebElement onElement = waitForGetElementPresent(target, params);

		if (onElement != null) {
			String text = onElement.getText();
			String msg = String.format("The element [%s] has text [%s]", target, text);
			TestLogger.info(msg);
			return text;
		} else {
			String error = String.format("The element [%s] not present", target);
			TestLogger.warn(error);
			throw new Exception(error);
		}

	}
	
	/**
	 * execute a javascript
	 */
	public String executeJS(WebElement e, String js) {
		return ((JavascriptExecutor) driver).executeScript(js, e).toString();
	}

	/**
	 * click by javascript
	 */
	public void clickByJavascript(String element, String... param) {
		WebElement onElement = waitForGetElementPresent(element, param);
		((JavascriptExecutor) driver).executeScript("arguments[0].click();", onElement);
	}

	/**
	 * click on element
	 * 
	 * @param target
	 */
	public void click(String target, String... param) {
		int i = 0;
		do {
			
			try {
				WebElement onElement = waitForGetElementPresent(target, param);
				if (platform != null && platform != "")
					if (platform.toLowerCase().contains("linux") && onElement.isDisplayed())
						TestLogger.info("Current platform is linux");
					else
						((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", onElement);
				else
					((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", onElement);
				if (!onElement.isDisplayed() || !onElement.isEnabled()) {
					TestLogger.info("click by javascript");
					clickByJavascript(target, param);
				} else {
					TestLogger.info("Click normally");
					focus(onElement);
					Actions actions = new Actions(driver);
					actions.moveToElement(onElement).click(onElement).perform();
				}
				pause(2000);
				return;
				
			} catch (StaleElementReferenceException e) {
				pause(1000);
				i ++;
			}
			
		}while(i < 30);

	}
	
	/**
	 * click on element
	 * 
	 * @param target
	 */
	public void click(String target, int x, int y) {
		int i = 0;
		do {
			
			try {
				WebElement onElement = waitForGetElementVisible(target);
				Actions actions = new Actions(driver);
				actions.moveToElement(onElement, x, y).click().build().perform();
				return;
			} catch (StaleElementReferenceException e) {
				pause(1000);
				i ++;
			}
			
		}while(i < 30);

	}
	

	/**
	 * click on a canvas element
	 * 
	 * @param target
	 */
	public void clickOnCanvas(String target, int x, int y) {
		int i = 0;
		do {
			
			try {
				WebElement onElement = waitForGetElementVisible(target);
				String click = String.format("var evt = new MouseEvent('click', {bubbles: true, clientX: %d, clientY: %d});" +
												"arguments[0].dispatchEvent(evt);", x, y);
				((JavascriptExecutor) driver).executeScript(click, onElement);
				return;
			} catch (StaleElementReferenceException e) {
				pause(1000);
				i ++;
			}
			
		}while(i < 30);
	}
	
	/**
	 * 
	 * @param target
	 * @param x
	 * @param y
	 */
	public void clickAndMoveByOffset(String target, int x, int y) {
		WebElement onElement = waitForGetElementVisible(target);
		Actions action = new Actions(driver);
		action.clickAndHold(onElement).moveByOffset(x,y).release().build().perform();
	}

	
	/**
	 * double click on element
	 * 
	 * @param target
	 */
	public void doubleClick(String target, String... param) {
		waitForPageToLoad();
		WebElement onElement = waitForGetElementPresent(target, param);
		Actions actions = new Actions(driver);
		actions.doubleClick(onElement).perform();

	}

	/**
	 * send text into textbox
	 * 
	 * @param target
	 * @param text
	 */
	public String sendKey(String target, String text) {
		RandomData randomData = new RandomData();
		text = randomData.getRandomString(text);
		
		int i = 0;
		do {
			try {
				WebElement elem = waitForGetElementPresent(target);
				scrollIntoView(elem);
				elem.clear();;
				elem.sendKeys(text);
				waitForPageToLoad();
				return text;
			}
			catch(StaleElementReferenceException e) {
				pause(1000);
				i++;
			}
		}while(i< 5);
		return "";
	}
	
	public void hover(String element) {
		WebElement moveToElement = waitForGetElementPresent(element);
		Actions builder = new Actions(driver);
		Action dragAndDrop = builder.moveToElement(moveToElement).release(moveToElement).build();
		dragAndDrop.perform();
	}
	
	/**
	 * Select dropdown list by value
	 * 
	 * @param element
	 * @param value
	 */
	public void selectDdlByValue(String element, String value) throws Throwable {
		Select dropdown = new Select(waitForGetElementPresent(element));
		dropdown.selectByValue(value);
	}
	
	/**
	 * Select dropdown list by visible text
	 * 
	 * @param element
	 * @param value
	 */
	public void selectDdlByText(String element, String text) throws Throwable {
		Select dropdown = new Select(waitForGetElementPresent(element));
		dropdown.selectByVisibleText(text);
	}

	/**
	 * Tick/ Untick the checkbox
	 * 
	 * @param element
	 */
	public void selectCheckbox(String element, Boolean isChecked) throws Throwable {
		
		if (!isSelected(element) && isChecked) {
			click(element);
		}
			
		else if (isSelected(element) && !isChecked) {
			click(element);
		}
	}
	
	/**
	 * mouse hover on element
	 * 
	 * @param target
	 */
	public void mouseHover(String target, String... param) {
		WebElement onElement = waitForGetElementPresent(target, param);
		Actions action = new Actions(driver);
		action.moveToElement(onElement).build().perform();
	}

	/**
	 * Get actual string after processing randomdata
	 * 
	 * @param text
	 * @return
	 */
	public String getActualString(String text) {
		RandomData randomData = new RandomData();
		text = randomData.getRandomString(text);
		return text;
	}

	/**
	 * verify element is enable to click or not
	 * 
	 * @param target
	 * @return
	 */
	public boolean isEnabled(String target, String... param) {
		if (waitForGetElementPresent(target, param) == null)
			return false;
		return waitForGetElementPresent(target, param).isEnabled();
	}

	/**
	 * verify checkbox element is checked or not
	 * 
	 * @param target
	 * @return
	 */
	public boolean isSelected(String target) {
		if (waitForGetElementPresent(target) == null)
			return false;
		return waitForGetElementPresent(target).isSelected();
	}

	/**
	 * verify element is displayed or not
	 * 
	 * @param target
	 * @return
	 */
	public boolean isDisplay(String target) {
		if (waitForGetElementPresent(target) == null)
			return false;
		return waitForGetElementPresent(target).isDisplayed();
	}

	/**
	 * verify element is present or not
	 * 
	 * @param target
	 * @return
	 */
	public boolean isPresent(String target, String... param) {
		return (waitForGetElementPresent(target, param) != null);
	}

	/**
	 * verify element is present or not
	 * 
	 * @param target
	 * @return
	 */
	public boolean isVisible(String target, String... param) {
		return (waitForGetElementVisible(target, param) != null);
	}

	/**
	 * verify element is present or not
	 * 
	 * @param target
	 * @return
	 */
	public boolean isEnable(String target, String... param) {
		return waitForGetElementPresent(target, param).isEnabled();
	}

	/**
	 * get attribute of element
	 * 
	 * @param att
	 * @param target
	 * @param param
	 * @return
	 */
	public String getAttribute(String att, String target, String... param) {
		return waitForGetElementPresent(target, param).getAttribute(att);
	}
	
	/**
	 * get css value of element
	 * 
	 * @param css
	 * @param target
	 * @param param
	 * @return
	 */
	public String getCssValue(String css, String target, String... param) {
		return waitForGetElementPresent(target, param).getCssValue(css);
	}

	/**
	 * switch to iframe
	 * 
	 * @param iframeName
	 */
	public void switchToIFrame(String iframeName) {
		WebElement webElement = waitForGetElementPresent(iframeName);
		driver.switchTo().frame(webElement);
		pause(2000);
	}

	/**
	 * switch back to paren frame
	 */
	public void swichBackToParentFrame() {
		driver.switchTo().parentFrame();
	}

	/**
	 * switch back to main frame
	 */
	public void swichBackToMainFrame() {
		driver.switchTo().defaultContent();
	}

	/**
	 * verify if inputData is number or not
	 * 
	 * @param inputData
	 * @return
	 */
	public boolean isNumeric(String inputData) {
		return inputData.matches("[-+]?\\d+(\\.\\d+)?");
	}
	
	/**
	 * Focus on element
	 */
	public void focus(WebElement onElement) {
		((JavascriptExecutor) driver).executeScript("arguments[0].focus();", onElement);
	}
	
	/**
	 * Focus on element
	 */
	public void focus(String target) {
		WebElement webElement = waitForGetElementPresent(target);
		((JavascriptExecutor) driver).executeScript("arguments[0].focus;", webElement);
	}
	
	/**
	 * scroll into view
	 */
	public void scrollIntoView(WebElement onElement) {
		((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", onElement);
	}
	
	/**
	 * scroll into view
	 */
	public void scrollIntoView(String target) {
		WebElement webElement = waitForGetElementPresent(target);
		((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", webElement);
	}
	
	
	/**
	 * scroll up
	 */
	public void scrollUp() {
		((JavascriptExecutor) driver).executeScript("window.scrollTo(0, 0)");
	}

	/**
	 * scroll down
	 */
	public void scrollDown() {
		((JavascriptExecutor) driver).executeScript("window.scrollTo(0, document.body.scrollHeight)");
	}

	/**
	 * get alert popup and switch to this alert
	 * 
	 * @return
	 */
	public Alert getAlert() {
		return driver.switchTo().alert();
	}

	/**
	 * runJquery
	 * 
	 * @param jquery
	 * @return
	 */
	public String runJquery(String jquery) {
		JavascriptExecutor jse = (JavascriptExecutor) driver;
		TestLogger.info(jquery);
		return jse.executeScript(jquery).toString();
	}

	/**
	 * switch to windows base on title and close it
	 * 
	 * @param driver
	 * @param windowTitle
	 * @return
	 */
	public void switchTabandClose(String title) {
		Set<String> windows = driver.getWindowHandles();
		String mainwindow = driver.getWindowHandle();

		for (String handle : windows) {
			driver.switchTo().window(handle);
			TestLogger.info("switched to " + driver.getTitle() + "  Window");
			String pagetitle = driver.getTitle();
			if (pagetitle.toLowerCase().contains(title.toLowerCase())) {
				driver.close();
				TestLogger.info("Closed the  '" + pagetitle + "' Tab now ...");
			}
		}
		driver.switchTo().window(mainwindow);
	}

	/**
	 * switch to windows base on title and close others tab
	 * 
	 * @param driver
	 * @param windowTitle
	 * @return
	 */
	public void switchTabandCloseOthers(String title) {
		for (String handle : driver.getWindowHandles()) {
			driver.switchTo().window(handle);
			String currentTitle = driver.getTitle();
			if (currentTitle.contains(title)) {
				break;
			} else {
				driver.close();
			}

		}
	}

	/**
	 * switch to windows base on title and close it
	 * 
	 * @param driver
	 * @param windowTitle
	 * @return
	 */
	public void switchTab(String title) {
		pause(2000);
		title=LocatorMap.getActualValueFromElementList(title).toLowerCase();
		TestLogger.info("I want to switch to window "+title);
		for (String winHandle : driver.getWindowHandles()) {
			driver.switchTo().window(winHandle);
			String currTitle=driver.getTitle();
			TestLogger.info("Switched to window "+currTitle);
			if (currTitle.toLowerCase().contains(title)) {
				TestLogger.info(String.format("The current window is %s", currTitle));
				break;
			}
		}
	}

	/**
	 * Place a String on the clipboard, and make this class the owner of the
	 * Clipboard's contents.
	 */
	public void setClipboardContents(String aString) {
		RandomData randomData = new RandomData();
		String text = randomData.getRandomString(aString);
		StringSelection stringSelection = new StringSelection(text);
		Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
		clipboard.setContents(stringSelection, this);
	}

	/**
	 * Get the String residing on the clipboard.
	 *
	 * @return any text found on the Clipboard; if none found, return an empty
	 *         String.
	 */
	public String getClipboardContents() {
		String result = "";
		Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
		// odd: the Object param of getContents is not currently used
		Transferable contents = clipboard.getContents(null);
		boolean hasTransferableText = (contents != null) && contents.isDataFlavorSupported(DataFlavor.stringFlavor);
		if (hasTransferableText) {
			try {
				result = (String) contents.getTransferData(DataFlavor.stringFlavor);
			} catch (UnsupportedFlavorException | IOException ex) {
				System.out.println(ex);
				ex.printStackTrace();
			}
		}
		return result;
	}

	@Override
	public void lostOwnership(Clipboard clipboard, Transferable contents) {
		// TODO Auto-generated method stub

	}
	/**
	 * press enter key
	 */
	public void pressEnterKey() {
		Actions action = new Actions(driver);
		action.sendKeys(Keys.ENTER);
		action.perform();
		action.release();
	}
	
	/**
	 * convert a hex color to rgb format
	 */
	public String convertColorFromHexToRgb(String colorHex) {
		
		Color color = Color.decode(colorHex);
		
		String rgb = String.format("rgba(%d, %d, %d, 1)", color.getRed(), color.getGreen(), color.getBlue());
		return rgb;
		
	}
	
	/**
	 * press enter key
	 */
	public void pressKey(WebElement element, Keys key) {
		element.sendKeys(key);
	}
}

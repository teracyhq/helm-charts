package iorad.page;

import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;

import iorad.utils.TestLogger;

public class ManageFile extends PageCore{

	/**
	 * upload file using robot
	 * @param fileLocation
	 */
	public void uploadFileUsingRobot(String fileLocation) {
		try {
			//Setting clip board with file location
			setClipboardContents(fileLocation);
			//native key strokes for CTRL, V and ENTER keys
			Robot robot = new Robot();

			robot.keyPress(KeyEvent.VK_CONTROL);
			robot.keyPress(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_CONTROL);
			Thread.sleep(3000);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
		} catch (Exception exp) {
			exp.printStackTrace();
		}
	}

	/**
	 * upload file using javascript
	 * @param element
	 * @param fileLocation
	 * @throws InterruptedException
	 */
	public void uploadFileUsingJavascript(String fileLocation) throws InterruptedException{
		TestLogger.info("Attach a file");
		String fs = File.separator;
		WebElement elem=waitForGetElementPresent("//*[@type='file']");
		fileLocation=System.getProperty("user.dir")+fileLocation.replace("/", fs).replace("\\", fs);
		TestLogger.info(fileLocation);
		((JavascriptExecutor) driver).executeScript("arguments[0].style.display = 'block';", elem);
		elem.sendKeys(fileLocation);
		Thread.sleep(5000);
	}
	
	/**
	 * upload file using javascript
	 * @param element
	 * @param fileLocation
	 * @throws InterruptedException
	 */
	public void uploadFileUsingJavascript(String element, String fileLocation) throws InterruptedException{
		TestLogger.info("Attach a file");
		String fs = File.separator;
		WebElement elem=waitForGetElementPresent(element);
		fileLocation=System.getProperty("user.dir")+fileLocation.replace("/", fs).replace("\\", fs);
		TestLogger.info(fileLocation);
		((JavascriptExecutor) driver).executeScript("arguments[0].style.display = 'block';", elem);
		elem.sendKeys(fileLocation);
		Thread.sleep(5000);
	}

	/**
	 * get height of image
	 * @param path
	 * @return
	 */
	public Integer getImageWidth(String path) {
		String fs = File.separator;
		path=System.getProperty("user.dir")+path.replace("/", fs).replace("\\", fs);
		BufferedImage readImage = null;
		Integer height=null;
		try {
			readImage = ImageIO.read(new File(path));
			height = readImage.getHeight();
		} catch (Exception e) {
			readImage = null;
		}
		return height;
	}

	/**
	 * get width of image
	 * @param path
	 * @return
	 */
	public Integer getImageHeight(String path) {
		String fs = File.separator;
		path=System.getProperty("user.dir")+path.replace("/", fs).replace("\\", fs);
		BufferedImage readImage = null;
		Integer width=null;
		try {
			readImage = ImageIO.read(new File(path));
			width = readImage.getWidth();
		} catch (Exception e) {
			readImage = null;
		}
		return width;
	}
	
	/**
	 * verify file is exist or not
	 * 
	 * @param path
	 * @return
	 */
	public Boolean isFileExist(String path) {
		File f = new File(path);
		if (f.exists()) {
			TestLogger.info("File existed");
			return true;
		} else {
			TestLogger.info("File not found!");
			return false;
		}
	}
	
	/**
	 * delete folder or file
	 * 
	 * @param inputFile
	 */
	public void deleteFile(String inputFile) {
		try {
			File file = new File(inputFile);
			if (file.isDirectory()) {
				for (File f : file.listFiles()) {
					deleteFile(f.toString());
				}
			} else {
				file.delete();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}

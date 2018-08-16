package iorad.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Properties;

public class LocatorMap {
	static Properties properties;
	static String fseparator = File.separator;
	
	/**
	 * Get locator string from element properties
	 * @param ElementName
	 * @return
	 * @throws Exception
	 */
	public static String getLocatorString(String ElementName) throws Exception {
		//Read value using the logical name as Key
		String locator = properties.getProperty(ElementName);
		return locator.substring(locator.indexOf("=")+1);
	}

	/**
	 * Get locator string from element properties
	 * @param ElementName
	 * @return
	 * @throws Exception
	 */
	public static String getActualValueFromElementList(String ElementName) {
		//Read value using the logical name as Key
		String locator = properties.getProperty(ElementName);
		if(locator!=null && !locator.isEmpty()){
			return locator;
		}
		else
			return ElementName;
	}

	/**
	 * loading locator element from package
	 * @param objectRepos
	 * @return
	 * @throws IOException
	 */
	public static Properties loadingObjectPropertiesFromPackage(String objectRepos){
		BufferedReader fs = null;
		properties = new Properties();
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource(objectRepos);
		try {
			File folder = new File(url.toURI());
			if (folder.isDirectory()) {
				File[] files = folder.listFiles();
				for (File file : files) {
					fs = new BufferedReader(
				            new InputStreamReader(
				                       new FileInputStream(file), "UTF8"));
					properties.load(fs);					
				}
			}
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return properties;
	}
}

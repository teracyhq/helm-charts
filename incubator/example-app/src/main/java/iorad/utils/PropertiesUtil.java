package iorad.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropertiesUtil {
	public static final String config_path = "/config.properties";
	
	/**
	 * load config properties file
	 * @return
	 */
	public static Properties loadConfigSys(){
		String fs = File.separator;
		FileInputStream is = null;
		try {
			is = new FileInputStream((System.getProperty("user.dir") + config_path).replace("/", fs).replace("\\", fs));
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Properties pros = new Properties();
		try {
			pros.load(is);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pros;
	}
}

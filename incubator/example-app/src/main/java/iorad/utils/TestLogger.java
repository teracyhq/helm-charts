package iorad.utils;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

public class TestLogger {
	public static void log(String message, Level level) {
		Throwable t = new Throwable(); 
		String logMessage = message;
		StackTraceElement[] elements = t.getStackTrace();
		Logger logger = Logger.getLogger(TestLogger.class.getName());
		String Filename = elements[2].getFileName();
		String sClassName = Filename.substring(0, Filename.length() - 5);//remove .java
		String sMethodName = elements[2].getMethodName();
		logMessage = String.format("[%-10s][%s] %s", sClassName, sMethodName, message);
		logger.log(level, logMessage);
	}

	public static void trace(Object message) {
		log(String.valueOf(message), Level.TRACE);
	}

	public static void debug(Object message) {
		log(String.valueOf(message), Level.DEBUG);
	}

	public static void info(Object message) {
		log(String.valueOf(message), Level.INFO);
	}

	public static void warn(Object message) {
		log(String.valueOf(message), Level.WARN);
	}

	public static void error(Object message) {
		log(String.valueOf(message), Level.ERROR);
	}
}

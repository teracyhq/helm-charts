package iorad.utils;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

public class FileUtil {
	public static final String NEW_LINE_SEPARATOR = "\n";

	/**
	 * delete a folder
	 * 
	 * @param inputPath
	 * @throws IOException
	 */
	public static void deleteDirectory(String inputPath) throws IOException {
		File file = new File(inputPath);
		if (file.exists()) {
			TestLogger.info("Delete folder " + inputPath);
			FileUtils.forceDelete(new File(inputPath));
		}
		else
			TestLogger.info("Not found file "+inputPath);
	}

	/**
	 * delete file with special prefix name
	 * 
	 * @param path
	 * @param prefix
	 * @return
	 */
	public static void deleteFilesForPathByPrefix(String inputFile, String prefix) {
		try {
			File file = new File(inputFile);
			if (file.isDirectory()) {
				for (File f : file.listFiles()) {
					TestLogger.info(f.getAbsoluteFile());
					if (f.getName().startsWith(prefix)){
						TestLogger.info("Delete file " + f.getAbsolutePath());
						deleteFile(f.toString());
					}
				}
			} else {
				if (file.getName().startsWith(prefix)){
					file.delete();
				}	
				TestLogger.info(file.getAbsoluteFile());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * delete folder or file
	 * 
	 * @param inputFile
	 */
	public static void deleteFile(String inputFile) {
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

	/**
	 * write file
	 * 
	 * @param inputStr
	 * @param outputFile
	 */
	public static void writeFile(String inputStr, String outputFile) {
		FileWriter fileWriter = null;
		try {
			fileWriter = new FileWriter(outputFile);
			fileWriter.append(inputStr);
			fileWriter.append(NEW_LINE_SEPARATOR);
			fileWriter.flush();
			fileWriter.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * create new directory
	 * 
	 * @param pathDir
	 */
	public static void createDirectory(String pathDir) {
		File file = new File(pathDir);
		if (!file.exists()) {
			TestLogger.info("Create folder " + file);
			file.mkdir();
		}
	}

	/**
	 * copy one file to other folder
	 * 
	 * @param sourceFile
	 * @param destPath
	 */
	public static void copyFile(String sourceFile, String destPath) {
		File source = new File(sourceFile);
		File dest = new File(destPath);
		try {
			FileUtils.copyFileToDirectory(source, dest);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * get number of file in one folder
	 * 
	 * @param dirPath
	 * @return
	 */
	public static int getTotalFiles(String dirPath) {
		File directory = new File(dirPath);
		int count = 0;
		for (File file : directory.listFiles()) {
			if (file.isDirectory()) {
				count += getTotalFiles(file.getAbsolutePath());
			} else
				count++;
		}
		return count;
	}
}

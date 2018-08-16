package iorad.utils;

import java.io.File;

import iorad.page.PageCore;

public class SplitTestRunner {
	/**
	 * split test into multi testrunner
	 * @param pathFeature
	 * @param pathTestRunner
	 */
	public void splitTest(String pathFeature, String pathTestRunner) {
		int numThread = Integer.valueOf(PageCore.getConfig("thread_number"));
		int numFilePerPackage = FileUtil.getTotalFiles(pathFeature) /numThread;
		TestLogger.info("Number of file are in 1 package is " + numFilePerPackage);
		String source = "";
		try {
			int numbFolder = 1;
			FileUtil.createDirectory(pathTestRunner + "/testrunner" + String.valueOf(numbFolder));
			File dirFeature = new File(pathFeature);
			int temp = 1;
			for (File subDir : dirFeature.listFiles()) {
				if (subDir.isDirectory()) {
					for (File file : subDir.listFiles()) {
						if (file.isDirectory()) {
							for (File f : file.listFiles()) {
								source = f.getAbsolutePath();
								FileUtil.copyFile(source, pathTestRunner + "/testrunner" + String.valueOf(numbFolder));
								temp++;
								if (temp == numFilePerPackage + 1) {
									temp = 1;
									numbFolder++;
									if (numbFolder <= numThread)
										FileUtil.createDirectory(pathTestRunner + "/testrunner" + String.valueOf(numbFolder));
									else
										numbFolder=numThread;
								}
							}
						} else {
							source = file.getAbsolutePath();
							FileUtil.copyFile(source, pathTestRunner + "/testrunner" + String.valueOf(numbFolder));
							temp++;
							if (temp == numFilePerPackage + 1) {
								temp = 1;
								numbFolder++;
								if (numbFolder <= numThread)
									FileUtil.createDirectory(pathTestRunner + "/testrunner" + String.valueOf(numbFolder));
								else
									numbFolder=numThread;
							}
						}
					}
				} else {
					source = subDir.getAbsolutePath();
					FileUtil.copyFile(source, pathTestRunner + "/testrunner" + String.valueOf(numbFolder));
					temp++;
					if (temp == numFilePerPackage + 1) {
						temp = 1;
						numbFolder++;
						if (numbFolder <= numThread)
							FileUtil.createDirectory(pathTestRunner + "/testrunner" + String.valueOf(numbFolder));
						else
							numbFolder=numThread;
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

package runner;import java.io.File;

import org.junit.AfterClass;
import org.junit.runner.RunWith;

import com.cucumber.listener.Reporter;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
@RunWith(Cucumber.class)
@CucumberOptions(
features={"src/test/resources/features/"},
glue="scenariosteps",
tags = {"~@wip","~@pending"},
plugin={"junit:target/testrunner1/cucumber.xml"
		,"html:target/testunner1"
		,"json:target/testrunner1/cucumber.json"
		,"com.cucumber.listener.ExtentCucumberFormatter:output/report.html"}
)
public class TestRunner {
	@AfterClass
    public static void teardown() {
        Reporter.loadXMLConfig(new File("extent-config.xml"));
        Reporter.setSystemInfo("user", System.getProperty("user.name"));
    }
}

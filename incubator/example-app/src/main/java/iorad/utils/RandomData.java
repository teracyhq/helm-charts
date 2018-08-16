package iorad.utils;

import java.util.Random;

public class RandomData {
	/**
	 * get a list of random numbers
	 * @return random numbers
	 */
	public String getRandomNumber(Integer number) {
		char[] chars = "123456789".toCharArray();
		StringBuilder sb = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < number; i++) {
			char c = chars[random.nextInt(chars.length)];
			sb.append(c);
		}
		return sb.toString();
	}

	/**
	 * get random special string
	 * @return random string
	 */
	public String getRandomSpecialString(Integer number){
		String temp="~!@#$%^&*()_+{}:\"<>?`-=[]\\;'./,";
		char[] chars = temp.toCharArray();
		StringBuilder sb = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < number; i++) {
			char c = chars[random.nextInt(chars.length)];
			sb.append(c);
		}
		return sb.toString();
	}
	
	/**
	 * get random latin string
	 * @return random string
	 */
	public String getRandomLatinString(Integer number){
		char[] chars = "abcdefghijklmnopqrstuvwxyz".toCharArray();
		StringBuilder sb = new StringBuilder();
		Random random = new Random();
		for (int i = 0; i < number; i++) {
			char c = chars[random.nextInt(chars.length)];
			sb.append(c);
		}
		return sb.toString();
	}
	
	/**
	 * Process Random cucumber input
	 * ${} – everything inside will be parsed, strings are comma separated
             numerical value – create random alphanumeric string
       ! – use the string as it is
       N – random numbers
       S – random alphanumeric uppercase latin string
       s – random alphanumeric lowercase latin string
       C – random special string
       {!auto,S10,!test}
	 * @param value
	 * @return
	 */
	public String getRandomString(String value){
		String retValue="";
		value=LocatorMap.getActualValueFromElementList(value);
		if(value.trim().startsWith("{")){
			Integer lenght=value.split(":").length;
			Integer index=1;
			for(String sub:value.split(":")){
				String temp = sub.substring(sub.indexOf("{")+1,sub.indexOf("}"));
				for (String parts: temp.split(",")){
					parts=parts.trim();
					if(parts.toUpperCase().startsWith("N")){
						retValue=retValue+getRandomNumber(Integer.valueOf(parts.substring(1)));
					}
					if(parts.startsWith("S")){
						retValue=retValue+getRandomLatinString(Integer.valueOf(parts.substring(1))).toUpperCase();
					}
					if(parts.startsWith("s"))
						retValue=retValue+getRandomLatinString(Integer.valueOf(parts.substring(1))).toLowerCase();
					if(parts.toUpperCase().startsWith("C"))
						retValue=retValue+getRandomSpecialString(Integer.valueOf(parts.substring(1)));
					if(parts.startsWith("!"))
						retValue=retValue+parts.substring(1);
				}
				if(index<lenght)
					retValue=retValue+",";
				index++;
			}
		}
		else
			retValue=value;
		TestLogger.info(value+" = " + retValue);
		return retValue;
	}
}

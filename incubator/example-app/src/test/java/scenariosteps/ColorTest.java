package scenariosteps;

import java.awt.Color;

public class ColorTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(convertColorFromHexToRgb("#ffffff"));
	}
	
	public static String convertColorFromHexToRgb(String colorHex) {
		
		Color color = Color.decode(colorHex);
		
		String rgb = String.format("rgba(%d, %d, %d, %d)", color.getAlpha(), color.getRed(), color.getGreen(), color.getBlue());
		return rgb;
	}

}

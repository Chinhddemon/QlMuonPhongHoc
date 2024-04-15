package qlmph.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Converter {
	
	public static String datetimeToString(Date datetime) {
		if(datetime == null) return "";
		String format = "yyyy-MM-dd'T'HH:mm";
		return new SimpleDateFormat(format).format(datetime);
	}
	public static Date stringToDatetime(String datetime) {
		if(datetime == null) return null;
		String format = "yyyy-MM-dd'T'HH:mm";
		try {
			return new SimpleDateFormat(format).parse(datetime);
		} catch (Exception e) {
			return null;
		}
	}
	public static String intToStringNchar(int number, int n) {
		if(number == 0) return "";
		int mod = 1; for(int i = 0; i < n; i++) {mod *= 10;}
		return String.format("%0" + n  + "d",  number%mod);
	}
	public static String byteToString2char(byte number) {
		if(number == (byte) 255) return "";
		return String.format("%02d", number);
	}
}

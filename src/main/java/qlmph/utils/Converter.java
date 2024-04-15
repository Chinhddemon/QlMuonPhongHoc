package qlmph.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Converter {

    public static String datetimeToString(Date datetime) {
        if (datetime == null)
            return "";
        String format = "yyyy-MM-dd'T'HH:mm";
        return new SimpleDateFormat(format).format(datetime);
    }

    public static Date stringToDatetime(String datetime) {
        if (datetime == null)
            return null;
        String format = "yyyy-MM-dd'T'HH:mm";
        try {
            return new SimpleDateFormat(format).parse(datetime);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Date stringToDate(String date) {
        if (date == null)
            return null;
        String format = "yyyy-MM-dd";
        try {
            return new SimpleDateFormat(format).parse(date);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String intToStringNchar(int number, int n) {
        if (number == 0)
            return "";
        int mod = 1;
        for (int i = 0; i < n; i++) {
            mod *= 10;
        }
        return String.format("%0" + n + "d", number % mod);
    }

    public static String shortToString2char(short number) {
        if (number == 255)
            return "255";
        return String.format("%02d", number);
    }
}

package qlmph.utils;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
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

    public static LocalDateTime stringToLocalDateTime(String datetime) {
        if (datetime == null)
            return null;
        return LocalDateTime.parse(datetime);
    }

    public static String localDateTimeToString(LocalDateTime datetime) {
        if (datetime == null)
            return "";
        return datetime.toString();
    }

    public static String intToStringNchar(int number, int n) {
        if(number == 0) {
            new Exception("Dữ liệu rỗng.").printStackTrace();
        }
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

    public static void main(String [] args) {
        System.out.println(stringToLocalDateTime("2021-05-20T12:00:00"));
        System.out.println(localDateTimeToString(LocalDateTime.now()));
    }
}

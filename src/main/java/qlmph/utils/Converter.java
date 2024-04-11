package qlmph.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Converter {
    
    public static String DateToString(Date Date) {
        if(Date == null) return "";
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        return formatter.format(Date);
    }
    public static String DateTimeToString(Date Date) {
        if(Date == null) return "";
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm dd/MM/yyyy ");
        return formatter.format(Date);
    }
    public static Date StringToDate(String Date) {
        if(Date == null || Date.equals("")) return null;
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        try {
            return formatter.parse(Date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static Date StringToDateTime(String Date) {
        if(Date == null || Date.equals("")) return null;
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm dd/MM/yyyy ");
        try {
            return formatter.parse(Date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static String intToStringNchar(int number, int n) {
        if(number == 0) return "";
        return String.format("%0" + n + "d", number);
    }
    public static String byteToString2char(byte number) {
        if(number == 0) return "";
        return String.format("%02d", number);
    }
}

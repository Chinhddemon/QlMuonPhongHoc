package qlmph.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Converter {
    
    public static String DateToString(Date Date) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        return formatter.format(Date);
    }
    public static String DateTimeToString(Date Date) {
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm dd/MM/yyyy ");
        return formatter.format(Date);
    }
    public static Date StringToDate(String Date) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        try {
            return formatter.parse(Date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static Date StringToDateTime(String Date) {
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm dd/MM/yyyy ");
        try {
            return formatter.parse(Date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

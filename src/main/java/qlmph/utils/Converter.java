 package qlmph.utils;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Converter {

    public static String toString(Timestamp timestamp) {
        LocalDateTime dateTime = timestamp.toLocalDateTime();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
        return dateTime.format(formatter);
    }
    public static Timestamp toTimestamp(String dateTimeString, String format) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
        LocalDateTime dateTime = LocalDateTime.parse(dateTimeString, formatter);
        return Timestamp.valueOf(dateTime);
    }
    
    public static String toString(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        return dateFormat.format(date);
    }
    public static Date toDate(String dateString) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            java.util.Date parsedDate = dateFormat.parse(dateString);
            return new Date(parsedDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static int toInt(String string) {
        int number = IsNull.Int;
        try {
            number = Integer.parseInt(string);
            System.out.println("Số nguyên: " + number);
        } catch (NumberFormatException e) {
            System.out.println("Chuyển đổi sang số nguyên không thành công.");
        }
        return number;
    }
    public static String toString8Char(int number) {
        if(number==-1) return null;
        return String.format("%08d", number);
    }
}

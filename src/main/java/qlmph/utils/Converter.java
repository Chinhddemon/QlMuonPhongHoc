 package qlmph.utils;

import java.util.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Converter {

    //lang.String-sql.Timestamp
    public static String timestampToString(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm dd/MM/yyyy");
        return dateFormat.format(timestamp);
    }
    public static Timestamp stringToTimestamp(String dateString, String format) {
        Date date = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(format);
        date = dateFormat.parse(dateString);
        } catch ( ParseException e ){
            e.printStackTrace();
        }
        return new Timestamp(date.getTime());
    }
    
    //lang.String-sql.Date
    public static String dateToString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); // Khởi tạo đối tượng SimpleDateFormat với định dạng cho chuỗi kết quả
        return sdf.format(date); // Chuyển đổi Date thành chuỗi String và trả về
    }
    public static Date stringToDate(String dateString, String format) {
        Date utilDate = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(format);
            utilDate = dateFormat.parse(dateString);
        } catch ( ParseException e ){
            e.printStackTrace();
        }
        
        return new Date(utilDate.getTime());
    }
}

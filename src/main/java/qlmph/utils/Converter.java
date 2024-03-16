package qlmph.utils;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Converter {
    public static String timestampToString(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm dd/MM/yyyy");
        return dateFormat.format(timestamp);
    }
    public static String dateToString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy"); // Khởi tạo đối tượng SimpleDateFormat với định dạng cho chuỗi kết quả
        return sdf.format(date); // Chuyển đổi Date thành chuỗi String và trả về
    }
}

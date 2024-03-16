package qlmph.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class handleDataType {
        public static String timestampToString(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm dd/MM/yyyy");
        return dateFormat.format(timestamp);
    }
}

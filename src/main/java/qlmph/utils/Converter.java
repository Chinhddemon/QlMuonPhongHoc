package qlmph.utils;

public class Converter {
    
    public static String intToStringNchar(int number, int n) {
        if(number == 0) return "";
        return String.format("%0" + n + "d", number);
    }
    public static String byteToString2char(byte number) {
        if(number == 0) return "";
        return String.format("%02d", number);
    }
}

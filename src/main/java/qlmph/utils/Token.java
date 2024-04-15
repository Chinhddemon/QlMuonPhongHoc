package qlmph.utils;


import java.util.Random;

public class Token {
    public static String createRandom() {
        // Tạo một số nguyên ngẫu nhiên từ 1 đến 999999
        int randomNumber = new Random().nextInt(999999) + 1;

        // Chuyển đổi số nguyên thành chuỗi 6 ký tự
        String randomString = String.format("%06d", randomNumber);
        
        return randomString;
    }
}

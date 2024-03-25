package qlmph.utils;

public class UUIDEncoderDecoder {

    // Mã hóa UUID thành UID
    public static int encode(String uuid) {
        String uuidString = uuid.replaceAll("-", ""); // Loại bỏ dấu gạch ngang
        int uid = 0;
        
        // Mã hóa mỗi nhóm 4 chữ số của UUID
        // for (int i = 0; i < uuidString.length(); i += 4) {
        //     String group = uuidString.substring(i, i + 4);
        //     uid = uid * 10 + encodeGroup(group);
        // }
        
        // Mã hóa nhóm chữ số lần lượt 3, 2, 3, 8, 4, 3, 4, 5 của UUID 
        uid = uid * 10 + encodeGroup(uuidString.substring(0, 3));
        uid = uid * 10 + encodeGroup(uuidString.substring(3, 5));
        uid = uid * 10 + encodeGroup(uuidString.substring(5, 8));
        uid = uid * 10 + encodeGroup(uuidString.substring(8, 16));
        uid = uid * 10 + encodeGroup(uuidString.substring(16, 20));
        uid = uid * 10 + encodeGroup(uuidString.substring(20, 23));
        uid = uid * 10 + encodeGroup(uuidString.substring(23, 27));
        uid = uid * 10 + encodeGroup(uuidString.substring(27, 32));
        
        return uid;
    }   

    // Ánh xạ từ hex character sang integer
    private static int hexCharToInt(char c) {
        if (c >= '0' && c <= '9') {
            return c - '0';
        } else {
            return c - 'a' + 10; // Chuyển ký tự hex 'a'-'f' sang 10-15
        }
    }

    // Mã hóa một nhóm 4 chữ số của UUID thành một chữ số của UID
    private static int encodeGroup(String group) {
        int result = 0;
        // Chuyển đổi mỗi ký tự hex sang integer và tích lũy vào kết quả
        for (int i = 0; i < group.length(); i++) {
            result += hexCharToInt(group.charAt(i));
        }
        return result % 10; // Lấy phần dư để thu được chữ số duy nhất (0-9)
    }
    
    public static void main(String[] args) {
        System.out.println(encode("c3b48b4a-3d9e-49cc-877e-d65e6a1e336b"));
    }
}

package qlmph.utils;

public class ValidateObject {

    public static boolean isNullOrEmpty(Object obj) {
        return obj == null || obj.toString().trim().isEmpty();
    }
    public static void main (String[] args) {
        String test = "";
        String test2 = new String();
        String test3 = new String("");
        String test4 = new String(test3);
        System.out.println(isNullOrEmpty(test));
        System.out.println(isNullOrEmpty(test2));
        System.out.println(isNullOrEmpty(test3));
        System.out.println(isNullOrEmpty(test4));
    }
}
package qlmph.utils;

public class ValidateObject {

    public static boolean isNullOrEmpty(Object obj) {
        if(obj instanceof String) {
            return obj == null || obj.toString().trim().isEmpty();
        }
        else return obj == null;
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
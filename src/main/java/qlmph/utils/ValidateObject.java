package qlmph.utils;

import java.util.List;

public class ValidateObject {

    public static boolean isNullOrEmpty(Object obj) {
        if (obj instanceof String) {
            return obj == null || obj.toString().trim().isEmpty();
        }
        if(obj instanceof Integer) {
            return obj == null || (int)obj == 0;
        }
        if(obj instanceof Long) {
            return obj == null || (long)obj == 0;
        }
        if(obj instanceof Double) {
            return obj == null || (double)obj == 0;
        }
        if(obj instanceof Float) {
            return obj == null || (float)obj == 0;
        }
        if(obj instanceof Boolean) {
            return obj == null || (boolean)obj == false;
        }
        if(obj instanceof Short) {
            return obj == null || (short)obj == 0;
        }
        if(obj instanceof Byte) {
            return obj == null || (byte)obj == 0;
        }
        if(obj instanceof Character) {
            return obj == null || (char)obj == 0;
        }
        if(obj instanceof List<?>) {
            return obj == null || ((List<?>)obj).isEmpty();
        }
        if(obj instanceof Object[]) {
            return obj == null || ((Object[])obj).length == 0;
        }
        return obj == null;
    }

    public static boolean isNotNullOrEmpty(Object obj) {
        return !isNullOrEmpty(obj);
    } 

    public static boolean allNullOrEmpty(Object... obj) {
        for (Object o : obj) {
            if (!isNullOrEmpty(o)) {
                return false;
            }
        }
        return true;
    }

    public static boolean allNotNullOrEmpty(Object... obj) {
        for (Object o : obj) {
            if (isNullOrEmpty(o)) {
                return false;
            }
        }
        return true;
    }

    public static boolean exsistNullOrEmpty(Object... obj) {
        for (Object o : obj) {
            if (isNullOrEmpty(o)) {
                return true;
            }
        }
        return false;
    }

    public static boolean exsistNotNullOrEmpty(Object... obj) {
        for (Object o : obj) {
            if (!isNullOrEmpty(o)) {
                return true;
            }
        }
        return false;
    }

    public static void main(String[] args) {
        Object test = null;
        String test2 = "12";
        String test3 = new String("221");
        String test4 = new String(test3);
        System.out.println(isNullOrEmpty(test));
        System.out.println(isNullOrEmpty(test2));
        System.out.println(isNullOrEmpty(test3));
        System.out.println(isNullOrEmpty(test4));
        System.out.println(allNullOrEmpty(test, test2, test3, test4));
        System.out.println(allNotNullOrEmpty(test, test2, test3, test4));
        System.out.println(exsistNullOrEmpty(test, test2, test3, test4));
        System.out.println(exsistNotNullOrEmpty(test, test2, test3, test4));
        System.out.println(!ValidateObject.allNullOrEmpty(test, test2, test3, test4)
        && !ValidateObject.allNotNullOrEmpty(test, test2, test3, test4));
    }
}
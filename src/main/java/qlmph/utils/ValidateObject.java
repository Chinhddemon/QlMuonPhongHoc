package qlmph.utils;

public class ValidateObject {

    public static boolean isNullOrEmpty(Object obj) {
        if (obj instanceof String) {
            return obj == null || obj.toString().trim().isEmpty();
        }
        return obj == null;
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
        String test = "";
        String test2 = new String();
        String test3 = new String("");
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
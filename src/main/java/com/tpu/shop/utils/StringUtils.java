package com.tpu.shop.utils;

public class StringUtils {
    public static boolean checkString(String s){
        if (s == null || s.isEmpty() || s.trim().length() == 0){
            return false;
        }
        return true;
    }
}

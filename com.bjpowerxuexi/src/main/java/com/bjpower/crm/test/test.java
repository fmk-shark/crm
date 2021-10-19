package com.bjpower.crm.test;

import com.bjpower.crm.utils.DateTimeUtil;
import com.bjpower.crm.utils.MD5Util;

public class test {
    public static void main(String[] args) {
        String guoqudetime = "2021-10-18 22:41:10";
        String currenttime = DateTimeUtil.getSysTime();
        int count = guoqudetime.compareTo(currenttime);
        System.out.println(count);
        String s = "wodiaonimade123@";
        s = MD5Util.getMD5(s);
        System.out.println(s);
    }
}

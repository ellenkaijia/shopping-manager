package com.manager.constant;

public class ConsoleConstants {
    public final static String SESSION_USER_KEY = "user"; // session登录用户的key
    public final static String COOKIE_USER_NAME = "userName";
    public final static String COOKIE_USER_PWD = "userPwd";
    public static final String DEFAULT_CHARSET = "utf-8";  // 默认编码utf-8
    public static final int RESULT_CODE_SUCCESS = 1; // 后台成功代码1，其他值或空都视为失败 
    public static final int RESULT_CODE_FAILED = -99; // 后台失败代码-99，只要是负数页面JS就会判断操作失败
}

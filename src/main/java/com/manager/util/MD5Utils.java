package com.manager.util;

import java.io.File;
import java.io.FileOutputStream;
import java.security.MessageDigest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.manager.constant.ConsoleConstants;

public class MD5Utils {
	
	private static Logger log = LoggerFactory.getLogger(MD5Utils.class);

    private static final String hexDigits[] = { "0", "1", "2", "3", "4", "5","6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };
    
    private static String byteToHexString(byte b) {
        int n = b;
        if (n < 0)
            n += 256;
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }
    
    
    public static String byteArrayToHexString(byte b[]) {
        StringBuffer resultSb = new StringBuffer();
        for (int i = 0; i < b.length; i++)
            resultSb.append(byteToHexString(b[i]));

        return resultSb.toString();
    }
    
    public static String MD5Encode(String origin) {
        String resultString = null;
        try {
            resultString = new String(origin);
            MessageDigest md = MessageDigest.getInstance("MD5");
            resultString = byteArrayToHexString(md.digest(resultString.getBytes(ConsoleConstants.DEFAULT_CHARSET)));
        } catch (Exception e) {
        	log.error(e.getMessage(),e);
        }
        return resultString;
    }
    
    /**获取文件大小，字节。*/
    public static Long getFileSize(String inputFile) throws Exception{
    	File file = new File(inputFile);
    	if(file==null || !file.exists() || file.isDirectory()){
    		throw new Exception(file+"不是文件或文件不存在");
    	}
    	return file.length();
    }
    
    //写文件，支持中文字符，在linux redhad下测试过
	public static void writeFile(String filePath , String content , boolean model) {
		try {
			File file = new File(filePath);
			if (!file.exists()){
				file.createNewFile();
			}
			FileOutputStream out = new FileOutputStream(file, model); // 如果追加方式用true
			out.write(content.getBytes("utf-8"));// 注意需要转换对应的字符集
			out.close();
		} catch (Exception e) {
			log.error(e.getMessage(),e);
		}
	}
	
	public static void main(String[] args){
	}
    
}
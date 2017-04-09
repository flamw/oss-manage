package com.flame.util;
import java.security.MessageDigest;

public class Md5Util {
	




    public final static String METHOD_GET="GET";
    public final static String METHOD_PUT="PUT";
    public final static String METHOD_DELETE="DELETE";
    public final static String METHOD_POST="POST";
    private static final char[] HEX_DIGITS = { '0', '1', '2', '3', '4', '5',
            '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };


    //md5加密
    public static String getMd5(String origin){
        String result="";
        try{
            result= Md5Util.encodeByMD5(origin, "gb2312");
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
    
  //md5加密
    public static String findMd5(String origin,String encode){
        String result="";
        try{
            result= Md5Util.encodeByMD5(origin, encode);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
	  /**
     * encode By MD5
     *
     * @param str
     * @param encode
     * @return String
     */
    public static String encodeByMD5(String str,String encode) {
        if (str == null) {
            return null;
        }
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.update(str.getBytes(encode));
            return getFormattedText(messageDigest.digest());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
    
	private static String getFormattedText(byte[] bytes) {
        int len = bytes.length;
        StringBuilder buf = new StringBuilder(len * 2);
        // 把密文转换成十六进制的字符串形式
        for (int j = 0; j < len; j++) { 			buf.append(HEX_DIGITS[(bytes[j] >> 4) & 0x0f]);
            buf.append(HEX_DIGITS[bytes[j] & 0x0f]);
        }
        return buf.toString();
    }
}

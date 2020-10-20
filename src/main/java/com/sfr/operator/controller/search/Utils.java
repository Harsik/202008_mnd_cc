package com.sfr.operator.controller.search;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.Enumeration;
import java.util.Locale;
import java.util.ResourceBundle;

public class Utils {
	
	/*------------------------------------------------------
	 * CharSet 확인 함수
	 * @param str_kr : 입력값
	-------------------------------------------------------*/
	public String charSet(String str_kr) throws UnsupportedEncodingException{
	    String charset[] = {"euc-kr", "ksc5601", "iso-8859-1", "8859_1", "ascii", "UTF-8"};
	        
		String temp = "";
	    
	    for(int i=0; i<charset.length ; i++){
	        for(int j=0 ; j<charset.length ; j++){
	            if(i==j) continue;
	            temp += charset[i]+" : "+charset[j]+" :"+new String(str_kr.getBytes(charset[i]),charset[j])+"<br>";
	        }
	    }
	    return temp;
	}

	/*------------------------------------------------------
	 * 한글 처리를 위한 함수
	 * @param src : 입력값
	 * @return 문자열 
	-------------------------------------------------------*/
	public String toHan(String src){
		String sRet = src;
		try {
			sRet = new String(src.getBytes("8859_1"),"UTF-8");
		} catch (Exception e) {
		}
		return sRet;
	}	

	/*------------------------------------------------------
	 * 검색 쿼리 만드는 함수
	 * @param query : 입력값(검색어)
	 * @param range : all, title, writer, body...(제목, 작성자, 본문등...)
	 * @return 문자열
	-------------------------------------------------------*/
	public String MakeQuery(String query, String range)
	{
		String sRet = query;
		
		
		if(range.compareTo("")!=0 && range.compareTo("all")!=0){
			sRet = "(("+sRet+")<in>"+range+")";
		}else{
			sRet = "("+query+")";
		}
		return sRet; 
	}
	 
	 /*------------------------------------------------------
	  * 문자열 Null 처리
	  * @param s 입력값
	  * @param value 초기값
	  * @return 문자열
	 -------------------------------------------------------*/
	 public static String interpret (String s, String value)
	{
		if (s == null)
		{
			return value;
		}
		if(s.trim().equals(""))
		{
			return value;
		}
		return s;
	}

	 /*------------------------------------------------------
	  * 특수문자 제거(정규표현식) 
	  * @param str 입력값
	  * @return 문자열
	 -------------------------------------------------------*/
	 public static String StringReplace(String str){
		
	    String str_imsi   = ""; 
	    //String[] filter_word = {"\\.","\\?","\\/","\\~","\\!","\\@","\\#","\\$","\\%","\\^","\\&","\\*","\\(","\\)","\\_","\\+","\\=","\\|","\\\\","\\}","\\]","\\{","\\[","\\\"","\\'","\\:","\\;","\\<","\\,","\\>","\\.","\\?","\\/"};
	    //String[] filter_word = {"\\.","\\?","\\/","\\~","\\!","\\@","\\#","\\$","\\%","\\^","\\&","\\_","\\=","\\|","\\\\","\\}","\\]","\\{","\\[","\\\"","\\'","\\:","\\;","\\<","\\,","\\>","\\.","\\?","\\/"};
	    String[] filter_word = {"\\.","\\?","\\/","\\~","\\!","\\$","\\%","\\^","\\&","\\_","\\=","\\|","\\\\","\\}","\\]","\\{","\\[","\\\"","\\'","\\:","\\;","\\<","\\,","\\>","\\.","\\?","\\/"};
	    for(int i=0;i<filter_word.length;i++){
	        str_imsi = str.replaceAll(filter_word[i]," ");
	        str = str_imsi.trim();
	    }    
		return str;
	}

	 /*------------------------------------------------------
	  * 특수문자 제거(인기검색어용) 
	  * @param str 입력값
	  * @return 문자열
	 -------------------------------------------------------*/
	 public static String StringReplace_Ranking(String str){
		
	    String str_imsi   = ""; 
	    String[] filter_word = {"\\.","\\?","\\/","\\~","\\!","\\@","\\#","\\$","\\%","\\^","\\&","\\_","\\+","\\=","\\|","\\\\","\\}","\\]","\\{","\\[","\\\"","\\'","\\:","\\;","\\<","\\,","\\>","\\.","\\?","\\/","\\(","\\)","\\*"};
	    for(int i=0;i<filter_word.length;i++){
	        str_imsi = str.replaceAll(filter_word[i]," ");
	        str = str_imsi.trim();
	    }    
		return str;
	}

	 /*------------------------------------------------------
	  * 천단위 콤마 처리 
	  * @param data 입력값
	  * @return 문자열
	 -------------------------------------------------------*/
	 public static String replaceComma(int data){
		 DecimalFormat df = new DecimalFormat("#,###");
		 
		 return (String)df.format(data);
	 }
	 
	 

	 /*------------------------------------------------------
	  * 긴문자 자르기
	  * strValue : 치환할 문자열
	  * cutLine : 자를 문자수
	  * trail : 꼬리말
	 -------------------------------------------------------*/
	 public String cropString (String strValue, int cutLine, String trail)
	 {
	   String tempStrValue = "";
	   String lenStrValue = "";
	   if (strValue != null) 
	   {
	     tempStrValue = strValue;
	     try 
	     {
	       lenStrValue = new String(tempStrValue.getBytes("euc-kr"),"8859_1");
	     } 
	     catch(Exception e) 
	     {
	     }
	     int nStringLen = 0, nByteLen = 0;
	     char charPoint;
	     if(lenStrValue.length() > cutLine) 
	     {
	       while (nByteLen + 1 < cutLine) 
	       {
	         charPoint = tempStrValue.charAt(nStringLen);
	         nStringLen++;
	         if (charPoint > 127) 
	         { 
	           nByteLen = nByteLen + 2;
	         }
	         else { 
	           nByteLen++;
	         }
	       }
	       tempStrValue = tempStrValue.substring(0, nStringLen) + trail;
	     }
	   }
	   return tempStrValue;
	 }
	 
	 /*------------------------------------------------------
	  * 프로퍼티 가져오기
	  * sProp : 프로퍼티 이름
	  * key : 가져올 변수명
	 -------------------------------------------------------*/
	 public static String getProp(String sProp, String key) 
		{
				String value = "";
				ResourceBundle rb = ResourceBundle.getBundle(sProp, Locale.KOREAN);
				Enumeration Enum = rb.getKeys();
		
				while (Enum.hasMoreElements()) 
				{
					if (Enum.nextElement().equals(key)) {
						value = rb.getString(key);
						break;
					}
				}
				return value;
		}

}

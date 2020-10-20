package com.sfr.common;

import java.security.MessageDigest;

public class SHA256Util {
	
	public static void main(String[] args){
		System.out.println("admin : "+encrypt("admin"));  //8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
		System.out.println("admin1 : "+encrypt("admin1"));  //25f43b1486ad95a1398e3eeb3d83bc4010015fcc9bedb35b432e00298d5021f7
		System.out.println("admin2 : "+encrypt("admin2"));  //1c142b2d01aa34e9a36bde480645a57fd69e14155dacfab5a3f9257b77fdc8d8
	}
	
    public static String encrypt(String planText) {
        try{
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(planText.getBytes());
            byte byteData[] = md.digest();

            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
            }

            StringBuffer hexString = new StringBuffer();
            for (int i=0;i<byteData.length;i++) {
                String hex=Integer.toHexString(0xff & byteData[i]);
                if(hex.length()==1){
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();
        }catch(Exception e){
//            e.printStackTrace();
            throw new RuntimeException();
        }
    }
}

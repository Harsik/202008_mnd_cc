package com.sfr.operator.controller.search;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Test {
/*	public static void main(String[] args) {

		String query = "LHS";
		query = query.replace(" ", "*");
		query = query.replace("(", "");
		query = query.replace(")", "");

		String regex_en = "[^a-zA-Z]";

		String query_en = null;
		query_en = query.replaceAll(regex_en, "");

		query = query.replaceAll(query_en, "");

		String rexInt = query;

		rexInt = rexInt.replaceAll("[^0-9]", " ");

		// 공백 제거
		rexInt = rexInt.replaceAll("  ", " ");
		rexInt = rexInt.replaceAll("  ", " ");
		// rexArr = Arrays.asList(rexInt.trim().split(" "));

		// 숫자 배열
		List<String> rexArr = new ArrayList<String>();
		rexArr = Arrays.asList(rexInt.trim().split(" "));
		// System.out.println("rexArr : " + rexArr);
		// System.out.println("rexArr.size() : " + rexArr.size());
		System.out.println("-----------------------------");

		// 숫자뒤에 "*" <and>조건 추가
		if (rexInt.matches(".*[0-9].*")) {
			for (int i = 0; i < rexArr.size(); i++) {
				if (query.contains(rexArr.get(i).toString())) {
					query = query.replace(rexArr.get(i).toString(), rexArr.get(i).toString() + "*");
					query = query.replace("**", "*");
					// System.out.println("찾은숫자 : " + rexArr.get(i).toString());
					// System.out.println("변경쿼리 : " + query);
				}
			}
		}

		System.out.println("---------------------------------");
		System.out.println("숫자변경쿼리 : " + query);
		System.out.println("=================================");

		char[] chr = query.toCharArray();

		String changeQuery = "";

		for (int i = 0; i < chr.length; i++) {
			chr[i] = (query.charAt(i));

			// 한글자씩 파싱 후 "*" <and> 조건을 추가
			if (chr[i] < 48 || chr[i] > 58) {
				changeQuery += chr[i] + "*";
				changeQuery = changeQuery.replace("**", "*");
				// System.out.println("문자 : "+changeQuery);
			} else {
				changeQuery += chr[i];
				// System.out.println("숫자 : "+changeQuery);
			}
		}
		// System.out.println("문자변경쿼리 : " + changeQuery);

		// 검색 프로세스 통신
		if (changeQuery.startsWith("*")) {
			// 맨앞 "*" 제거
			changeQuery = changeQuery.replace("**", "*");
			changeQuery = changeQuery.substring(1, changeQuery.length());
		}

		if (changeQuery.endsWith("*")) {
			// 마지막 "*" 제거
			changeQuery = changeQuery.replace("**", "*");
			changeQuery = changeQuery.substring(0, changeQuery.length() - 1);
			// changeQuery = changeQuery.substring(0, changeQuery.length() - 2);
		}

		if (query_en != null) {
			changeQuery = changeQuery + "*" + query_en;
		}
		
		if (changeQuery.startsWith("*")) {
			// 맨앞 "*" 제거
			changeQuery = changeQuery.replace("**", "*");
			changeQuery = changeQuery.substring(1, changeQuery.length());
		}

		if (changeQuery.endsWith("*")) {
			// 마지막 "*" 제거
			changeQuery = changeQuery.replace("**", "*");
			changeQuery = changeQuery.substring(0, changeQuery.length() - 1);
			// changeQuery = changeQuery.substring(0, changeQuery.length() - 2);
			System.out.println("뒤 *제거 : " + changeQuery);
		}

		System.out.println("changeQuery : " + changeQuery);


	}
*/
	public static void main(String[] args) {
		String str ="해군$육군,,사단";
		if(str.indexOf(",,") != -1){
			String[] tmp = str.split(",,");
			for(String s : tmp) {
				System.out.println(s);
			}
			System.out.println("============");
			str = "(" + tmp[0] + ")<in>mildsc_nm " + tmp[1];
		}
		System.out.println(str);
	}
}

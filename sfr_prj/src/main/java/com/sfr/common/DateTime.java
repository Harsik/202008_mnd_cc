package com.sfr.common;

import java.util.Date;
import java.util.Calendar;
import java.text.SimpleDateFormat;

public class DateTime {
	 public DateTime() {
	 }
	 /**
	  * check date string validation with the default format "yyyy-MM-dd".<p>
	  * @param s date string you want to check with default format "yyyy-MM-dd".
	  */
	 public static void check(String s) throws Exception {
	    check(s, "yyyy-MM-dd");
	 }
	 /**
	  * check date string validation with an user defined format.<p>
	  * @param s date string you want to check.<br>
	  * @param format string representation of the date format. For example, "yyyy-MM-dd".
	  */
	 public static void check(String s, String format)
	 throws java.text.ParseException {
	    if ( s == null )
	       throw new NullPointerException("date string to check is null");
	    if ( format == null )
	       throw new NullPointerException("format string to check date is null");

	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
	    java.util.Date date = null;
	    try {
	       date = formatter.parse(s);
	    }
	    catch(java.text.ParseException e) {
	       throw new java.text.ParseException(
	          e.getMessage() + " with format \"" + format + "\"",
	          e.getErrorOffset()
	       );
	    }

	    if ( ! formatter.format(date).equals(s) )
	       throw new java.text.ParseException(
	          "Out of bound date:\"" + s + "\" with format \"" + format + "\"",
	          0
	       );
	 }
	 /**
	  * "yyyyMMdd" 형태의 날짜를 Calendar객체로 변환하여 리턴<p>
	  * @return Calendar<br>
	  * @param date java.lang.String
	  */
	 private static Calendar getCalendarFromString(String date) {
	    Calendar cal = Calendar.getInstance();
	    cal.set( Integer.parseInt(date.substring(0,4)),
	           Integer.parseInt(date.substring(4,6))-1,
	           Integer.parseInt(date.substring(6,8)) );
	    return cal;
	 }
	 /**
	  * @return formatted string representation of current day with  "yyyy-MM-dd".
	  */
	 public static String getDateString() {
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("yyyyMMdd",
	                                                                                        java.util.Locale.KOREA);
	    return formatter.format(new java.util.Date());
	 }

	 public static String getDateTimeString(String pattern) {

	    String result = null;
	    if( pattern.length() < 14) {
	       int index = 14 - pattern.length();
	       String aa = "0";
	       for( int i = 1 ; i < index ; i++ ) {
	          aa = aa + "0";
	       }
	       result = pattern+aa;
	    }else if(pattern.length() == 14) {
	       result =  pattern.substring(0,4)+"-"+pattern.substring(4,6)+"-"+pattern.substring(6,8)+" "+pattern.substring(8,10)+":"+pattern.substring(10,12)+":"+pattern.substring(12,14);
	    }else if(pattern.length() > 14) {
	       result = pattern.substring(0,14);
	    }
	    return result;

	 }
	 /**
	  * 일 리턴
	  * @return int
	  */
	 public static int getDay() {
	    return getNumberByPattern("dd");
	 }
	 /**
	  * 스트링중에서 숫자만 빼내어 조합한 결과를 리턴
	  * @return java.lang.String
	  * @param str java.lang.String
	  */
	 private static String getDigitString(String str) {
	    StringBuffer buff = new StringBuffer();
	    char[] ch = str.toCharArray();

	    for( int i=0; i<ch.length; i++ ) {
	       if( Character.isDigit(ch[i]) )
	          buff.append( ch[i] );
	    }
	    return buff.toString();
	 }
	 /**
	  *
	  * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");<p>
	  *
	  * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"<br>
	  * @return formatted string representation of current day and time with  your pattern.
	  */
	 public static String getFormatString(String pattern) {
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (pattern, java.util.Locale.KOREA);
	    String dateString = formatter.format(new java.util.Date());
	    return dateString;
	 }
	 /**
	  *
	  * For example, String time = getFormatString("yyyy-MM-dd HH:mm:ss");<p>
	  *
	  * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"<br>
	  * @return formatted string representation of current day and time with  your pattern.
	  */
	 public static String getFormatString(Calendar cal, String pattern) {
	         SimpleDateFormat formatter = new SimpleDateFormat(pattern);
	         return formatter.format(cal.getTime());
	 }

	 /**
	  * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");<p>
	  * @return java.lang.String<br>
	  * @param pattern java.lang.String ==> "yyyy-MM-dd HH:mm:ss"<br>
	  * @param attr int == > Calendar의 Attribute int값을 넣는다. ex. Calender.HOUR_OF_DAY<br>
	  * @param i int == > 증감하고자 하는 값.
	  */
	 public static String getFormatStringAdd(String pattern, int attr, int i) {
	    SimpleDateFormat formatter = new SimpleDateFormat(pattern);
	    Calendar cal = Calendar.getInstance();
	    cal.add( attr, i);
	    return formatter.format(cal.getTime());

	 }
	 /**
	  *
	  * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");<p>
	  *
	  * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"<br>
	  * @return formatted string representation of current day and time with  your pattern.
	  */
	 public static int getMonth() {
	    return getNumberByPattern("MM");
	 }
	 /**
	  *
	  * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");<p>
	  *
	  * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"<br>
	  * @return formatted string representation of current day and time with  your pattern.
	  */
	 public static int getNumberByPattern(String pattern) {
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (pattern, java.util.Locale.KOREA);
	    String dateString = formatter.format(new java.util.Date());
	    return Integer.parseInt(dateString);
	 }
	 /**
	  *	스트링 날짜를 현재로부터 mode에 따라 how만큼의 +/- 날로 반환<br>
	  *	리턴 형태는 "yyyyMMdd"<br>
	  *	날짜 스트링의 형태는 어떤것이든 상관없음<br>
	  *	단, 년도 4자리, 월 2자리, 일 2자리는 포함되어 있어야 함<br>
	  *	mode 값에 따라서 1-> how day, 2-> how week, 3-> how month, 4-> how year
	  *	@param String date
	  *	@param int how
	  *	@param int mode
	  *	@return String
	  */
	 public static String getRollDate(String date, int how, int mode) {
	    return getRollDate( date,how,mode,"yyyyMMdd" );
	 }
	 /**
	  *	스트링 날짜를 현재로부터 mode에 따라 how만큼의 +/- 날로 반환<br>
	  *	날짜 스트링의 형태는 어떤것이든 상관없음<br>
	  *	단, 년도 4자리, 월 2자리, 일 2자리는 포함되어 있어야 함<br>
	  *	mode 값에 따라서 1-> how day, 2-> how week, 3-> how month, 4-> how year
	  *	@param String date
	  *	@param int how
	  *	@param int mode
	  *	@param String pattern
	  *	@return String
	  */
	 public static String getRollDate(String date, int how, int mode, String pattern) {
	    if(date==null) return date;
	    date = getDigitString(date);

	    if(date.length()!=8) return null;

//	    if( date.substring(4).equals("1231") && how>0 )
//	       date = String.valueOf(Integer.parseInt(date.substring(0,4))+1)+date.substring(4);
//	    if( date.substring(4).equals("0101") && how<0 )
//	       date = String.valueOf(Integer.parseInt(date.substring(0,4))-1)+date.substring(4);

	    Calendar cal = getCalendarFromString(date);
	    switch(mode)
	    {
	    case 1:
	       cal.add(Calendar.DAY_OF_YEAR,how); break;
	    case 2:
	       cal.add(Calendar.WEEK_OF_YEAR,how); break;
	    case 3:
	       cal.add(Calendar.MONTH,how); break;
	    case 4:
	       cal.add(Calendar.YEAR,how); break;
	    }
	    return getFormatString(cal,pattern);
	 }
	 /**
	  * @return formatted string representation of current day with  "yyyyMMdd".
	  */
	 public static String getShortDateString() {
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("yyyyMMdd", java.util.Locale.KOREA);
	    return formatter.format(new java.util.Date());
	 }
	 /**
	  * @return formatted string representation of current time with  "HHmmss".
	  */
	 public static String getShortTimeString() {
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("HHmmss", java.util.Locale.KOREA);
	    return formatter.format(new java.util.Date());
	 }
	 /**
	  * @return formatted string representation of current time with  "yyyy-MM-dd-HH:mm:ss".
	  */
	 public static String getTimeStampString() {
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("yyyy-MM-dd-HH:mm:ss:SSS", java.util.Locale.KOREA);
	    return formatter.format(new java.util.Date());
	 }
	 /**
	  * @return formatted string representation of current time with  "HH:mm:ss".
	  */
	 public static String getTimeString() {
	    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat ("HH:mm:ss", java.util.Locale.KOREA);
	    return formatter.format(new java.util.Date());
	 }
	 /**
	  *
	  * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");<p>
	  *
	  * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"<br>
	  * @return formatted string representation of current day and time with  your pattern.
	  */
	 public static int getYear() {
	    return getNumberByPattern("yyyy");
	 }
	 /**
	  * 년과 월을 입력받아 마지막 일을 리턴한다.
	  * @param year
	  * @param month
	  * @return int
	  */
	 public static int getLastDay(int year, int month) {

	         int [] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

	         if( (year%4) == 0) daysInMonth[1] = 29;

	         else daysInMonth[1] = 28;

	         return daysInMonth[month-1];

	 }

	 public static boolean isDate(int y, int m, int d) { // This method is used to check for a VALID date
	   m -= 1;
	   Calendar c = Calendar.getInstance();
	   c.setLenient(false);
	   try {
	     c.set(y, m, d);
	     java.util.Date dt = c.getTime();
	   }
	   catch (IllegalArgumentException e) {
	     return false;
	   }
	   return true;
	 }
	 
	 	/**
	 	 * 두날짜의 일수를 계산한다.
	 	 * 
	 	 * @param begin
	 	 * @param end
	 	 * @return
	 	 * @throws Exception
	 	 */
		public static long diffOfDate(String begin, String end) throws Exception {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");

			Date beginDate = formatter.parse(begin);
			Date endDate = formatter.parse(end);

			long diff = endDate.getTime() - beginDate.getTime();
			long diffDays = diff / (24 * 60 * 60 * 1000);

			return diffDays;
		}

		public static String addDate(String date, int num) {
			if (date.length() > 8) {
				return toString(addDate(toDate(date.substring(0, 8)), num));

			} else if (date.length() == 8) {
				return toString(addDate(toDate(date), num));

			} else {
				return date;
			}
		}

		public static Date addDate(Date date, int num) {
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DAY_OF_MONTH, num);
			return cal.getTime();
		}

		public static Date toDate(String text) {
			return toDate(text, "yyyyMMdd");
		}

		public static Date toDate(String text, String pattern) {
			try {
				return (new SimpleDateFormat(pattern)).parse(text);
			} catch (Exception e) {
				return null;
			}
		}
		
		public static String toString(Date date) {
			return toString(date, "yyyyMMdd");
		}

		public static String toString(Date date, String pattern) {
			try {
				return (new SimpleDateFormat(pattern)).format(date);
			} catch (NullPointerException e) {
				return "";
			}
		}

		 public static long getCurrentUnixTimeStamp()
		 {
			 return System.currentTimeMillis()/1000;
		 }

}

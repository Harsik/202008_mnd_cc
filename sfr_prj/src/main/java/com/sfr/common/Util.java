package com.sfr.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.*;
import java.util.Enumeration;
import java.util.Vector;
import java.text.DecimalFormat;

public class Util {
	public Util() {
	}
	/**
	  * Object[] 의 복제. Object의 Array 를 복제(clone)하여<br>
	  * 새로운 Instance를 만들어 줍니다.<p>
	  *
	  * @return java.lang.Object[]<br>
	  * @param objects java.lang.Object[]
	  */
	public static Object[] clone(Object[] objects)
	{
		int length = objects.length;
		Class c = objects.getClass().getComponentType();
		Object array = Array.newInstance(c, length);

		for(int i=0;i<length;i++){
			Array.set(array, i, clone(objects[i]));
		}
		return (Object[])array;
	}
	/**
	 * Object 의 복제. 일반적으로 <code>java.lang.Object.clone()</code> 함수를
	 * 를 사용하여 Object를 복제하면 Object내에 있는 Primitive type을 제외한 Object<br>
	 * field들은 복제가 되는 것이 아니라 같은 Object의 reference를
	 * 갖게 된다.<br>
	 * 그러나 이 Method를 사용하면 각 field의 동일한 Object를 새로 복제(clone)하여
	 * 준다.
	 *
	 * @return java.lang.Object
	 * @param object java.lang.Object
	 */
	public static Object clone(Object object)
	{
		Class c = object.getClass();
		Object newObject = null;
	  	try {
	       newObject = c.newInstance();
	    }
	    catch(Exception e ){
	       return null;
	    }

	    Field[] field = c.getFields();
	    for (int i=0 ; i<field.length; i++) {
	       try {
	          Object f = field[i].get(object);
	          field[i].set(newObject, f);
	       }
	       catch(Exception e){
	       }
	    }
	    return newObject;
	}
 /**
  * Vector 의 복제. 일반적으로 Vector Object를 clone()을 하면
  * Vector내의 Element Object는 새로 생성되는 것이 아니라<br>
  * 동일한 Object에 대한 reference만 새로 생성되기 때문에 같은 Element Object를
  * reference하는 Vector를 생성하게 된다. 그러나 이 method를 사용하면<br>
  * Vector내의 모든 Element Object도 새로 복제하여 준다.<p>
  *
  * @return java.util.Vector<br>
  * @param objects java.util.Vector
  */
 public static Vector clone(Vector objects)
 {
    Vector newObjects = new Vector();
    Enumeration e = objects.elements();
    while(e.hasMoreElements()){
       Object o = e.nextElement();
       newObjects.addElement(clone(o));
    }
    return newObjects;
 }
 /**
  * quickSort(obj,compareAttr,order)의 구체적인 함수<p>
  * @return int<br>
  * @param obj java.lang.Object<br>
  * @param obj java.lang.Object<br>
  * @param attr java.lang.String
  */
 private static int compareTo(Object obj1, Object obj2, String attr) {
    int ret = 0;
    Class c1 = obj1.getClass();
    Class c2 = obj2.getClass();
    if(c1.isPrimitive()||c2.isPrimitive()) return ret;

    Field[] f1 = c1.getFields();
    Field[] f2 = c2.getFields();
    int idx1=-1, idx2=-1;
    String type1 = null;
    String type2 = null;
    try {
       for(int i=0; i<f1.length; i++ )
          if(f1[i].getName().equals(attr)) {
             type1 = f1[i].getType().getName();
             idx1 = i; break;
          }
       for(int i=0; i<f1.length; i++ )
          if(f2[i].getName().equals(attr)) {
             type2 = f2[i].getType().getName();
             idx2 = i; break;
          }
       if(idx1==-1 || idx2==-1) return ret;
       if(type1==null || type2==null) return ret;
       if(!type1.equals(type2)) return ret;

       if(type1.equals("java.lang.String")) {
          ret = ((String)f1[idx1].get(obj1)).compareTo((String)f2[idx2].get(obj2));
       } else if(type1.equals("int")) {
          ret = f1[idx1].getInt(obj1)-f2[idx2].getInt(obj2);
       } else if(type1.equals("double")) {
          ret = (new Double(f1[idx1].getDouble(obj1))).compareTo(new Double(f2[idx2].getDouble(obj2)));
       }

    } catch (Exception e) {
       e.printStackTrace();
    }

    return ret;
 }
 /**
  * 스트링을 주어진 바이트 길이로 리턴
  */
 public static byte[] fixByteLength(String str, int len) {
    byte[] b = new byte[len];
    byte[] o = str.getBytes();
    int fix = (b.length<o.length)? b.length: o.length;
    System.arraycopy(o,0,b,0,fix);
    return b;
 }
 /**
  * 스트링을 해당 길이(len)로 리턴, 바이트 길이 아님
  */
 public static String fixLength(String str, int len) {
    return fixLength(str,0,len);
 }
 /**
  * 스트링을 시작 길이(off)에서 해당 길이(len)를 리턴, 바이트 길이 아님
  */
 public static String fixLength(String str, int off, int len) {
    int str_len = str.length();
    if( str_len<=off || len<=0 ) return "";
    if( str_len-off<len ) return str.substring(off);

    return str.substring( off,len+off );
 }
 /**
  * Entity Class의 null string field 초기화.
  * <p>
  * Entity class 내에 있는 java.lang.String형의 field는 DB의 Column과<br>
  * 밀접한 연관이 있는 경우가 많다. 이러한 Entity Field가 특히 GUI의 특정<br>
  * TextFiled에 표현되어야 하는 경우도 많다. 만약 그 String Filed가 null일<br>
  * 경우 일일이 검사를 한다는 것은 참으로 답답한 일이 아닐 수 없다.<br>
  * <p>
  * 이 method는 여하한의 Object 내에 있는 모든 java.lang.String형의 field 변수 중<br>
  * null 값으로 된 field를 길이가 0 인 blank string("")으로 초기화 시켜준다.
  * <p>
  *
  * Sample Code:<br>
  * public java.util.Vector selectAll() throws Exception<br>
  * {<br>
  *  java.util.Vector list = new Vector();<br>
  *     Statement stmt = null;<br>
  *     ResultSet rs =null;<br>
  *     try{<br>
  *         stmt = conn.createStatement();<br>
  *         String query = "select " +<br>
  *             "id, " +<br>
  *             "name, " +<br>
  *             "desc " +<br>
  *             "from THE10 " +<br>
  *             "order by id ";<br>
  *<br>
  *         rs = stmt.executeQuery(query);<br>
  *<br>
  *         while ( rs.next() ) {<br>
  *             AdminAuth entity = new AdminAuth();<br>
  *             entity.id = rs.getString("id");<br>
  *             entity.name = rs.getString("name");<br>
  *             entity.desc = rs.getString("desc");<br>
  *             Utility.fixNull(entity);<br>
  *             list.addElement(entity);<br>
  *         }<br>
  *     }<br>
  *     finally {<br>
  *         try{rs.close();}catch(Exception e){}<br>
  *         try{stmt.close();}catch(Exception e){}<br>
  *     }<br>
  *     return list;<br>
  * }<br>
  *
  * @param java.lang.Object Object내의 public java.lang.String 형의
  *        member variable에만 영향을 준다.
  *
  */
 public static void fixNull(Object o)
 {
    if ( o == null ) return;

    Class c = o.getClass();
    if ( c.isPrimitive() ) return;

    Field[] fields = c.getFields();
    for (int i=0 ; i<fields.length; i++) {
       try {
          Object f = fields[i].get(o);
          Class fc = fields[i].getType();

          if ( fc.getName().equals("java.lang.String") ) {
             if ( f == null ) fields[i].set(o, "");
             else   fields[i].set(o, f);
          }
       }
       catch(Exception e){
       }
    }
 }
 /**
  * Entity Class의 재귀적인 null string field 초기화.
  * <p>
  * fixNull() 과 유사한 기능을 하는데, java.lang.String field 뿐만 아니라<br>
  * Member 변수 중 Array, Object 가 있으면 재귀적으로 �아 가서 String형을<br>
  * blank string("")으로 만들어 준다.<br>
  * 정상적인 String인 경우 trim()을 시켜준다.<br>
  * 만약 Array나, Vector가 null일 경우 Instance화는 하지 않는다.
  *
  * <p>
  * 재귀적으로 추적되는 만큼, 부모와 자식간에 서로 양방향 reference를 갖고 있으면<br>
  * 절대 안된다. Stack Overflow를 내며 JVM을 내릴 것이다.
  *
  *
  * @param java.lang.Object Object내의 public String 형뿐만 아니라, Object[], Vector 등과<br>
  *        같은 public Object형 Member Variable에 영향을 준다.
  *
  *
  */
 public static void fixNullAll(Object o)
 {
    if ( o == null ) return;

    Class c = o.getClass();
    if ( c.isPrimitive() ) return;

    if( c.isArray() ) {
       int length = Array.getLength(o);
       for(int i=0; i<length ;i++){
          Object element = Array.get(o, i);
          fixNullAll(element);
       }
    }
    else {
       Field[] fields = c.getFields();
       for (int i=0 ; i<fields.length; i++) {
          try {
             Object f = fields[i].get(o);
             Class fc = fields[i].getType();
             if ( fc.isPrimitive() ) continue;
             if ( fc.getName().equals("java.lang.String") ) {
                if ( f == null ) fields[i].set(o, "");
                else    fields[i].set(o, f);
             }
             else if ( f != null ) {
                fixNullAll(f);
             }
             else {} // Some Object, but it's null.
          }
          catch(Exception e) {
          }
       }
    }
 }
 /**
  * Entity Class의 null string field 초기화 &amp; trim().
  * <p>
  * Entity class 내에 있는 java.lang.String형의 field는 DB의 Column과
  * 밀접한 연관이 있는 경우가 많다. 이러한 Entity Field가 특히 GUI의 특정<br>
  * TextFiled에 표현되어야 하는 경우도 많다. 만약 그 String Filed가 null일
  * 경우 일일이 검사를 한다는 것은 참으로 답답한 일이 아닐 수 없다.<br>
  * <p>
  * 이 method는 여하한의 Object 내에 있는 모든 java.lang.String형의 field 변수 중<br>
  * null 값으로 된 field를 길이가 0 인 blank string("")으로 초기화 시켜준다.
  * 만약 null이 아닌 정상적인 String이 대입되어 있으면 강제적으로 trim()를<br>
  * 시켜준다.
  * <p>
  * 이 때 trim() 함수는 java.lang.String 의 trim()을 사용하지 않았다.
  *<br>
  * Sample Code:<br>
  * public java.util.Vector selectAll() throws Exception<br>
  * {<br>
  *  java.util.Vector list = new Vector();<br>
  *     Statement stmt = null;<br>
  *     ResultSet rs =null;<br>
  *     try{<br>
  *         stmt = conn.createStatement();<br>
  *         String query = "select " +<br>
  *             "id, " +<br>
  *             "name, " +<br>
  *             "desc " +<br>
  *             "from THE10 " +<br>
  *             "order by id ";<br>
  *<br>
  *         rs = stmt.executeQuery(query);<br>
  *<br>
  *         while ( rs.next() ) {<br>
  *             AdminAuth entity = new AdminAuth();<br>
  *             entity.id = rs.getString("id");<br>
  *             entity.name = rs.getString("name");<br>
  *             entity.desc = rs.getString("desc");<br>
  *             Utility.fixNull(entity);<br>
  *             list.addElement(entity);<br>
  *         }<br>
  *     }<br>
  *     finally {<br>
  *         try{rs.close();}catch(Exception e){}<br>
  *         try{stmt.close();}catch(Exception e){}<br>
  *     }<br>
  *     return list;<br>
  * }<br>
  *<br>
  * @param java.lang.Object Object내의 public java.lang.String 형의
  *        member variable에만 영향을 준다.
  *
  */
 public static void fixNullAndTrim(Object o)
 {
    if ( o == null ) return;

    Class c = o.getClass();
    if ( c.isPrimitive() ) return;

    Field[] fields = c.getFields();
    for (int i=0 ; i<fields.length; i++) {
       try {
          Object f = fields[i].get(o);
          Class fc = fields[i].getType();
          if ( fc.getName().equals("java.lang.String") ) {
             if ( f == null ) fields[i].set(o, "");
             else {
                String item = trim( (String)f );
                fields[i].set(o, item);
             }
          }
       }
       catch(Exception e){
       }
    }
 }
 /**
  * Entity Class의 재귀적인 null string field 초기화  &amp; trim().
  * <p>
  * fixNull() 과 유사한 기능을 하는데, java.lang.String field 뿐만 아니라
  * Member 변수 중 Array, Object 가 있으면 재귀적으로 �아 가서 String형을
  * blank string("")으로 만들어 준다.<br>
  * 정상적인 String인 경우 trim()을 시켜준다.<br>
  * 만약 Array나, Vector가 null일 경우 Instance화는 하지 않는다.
  *
  * <p>
  * 재귀적으로 추적되는 만큼, 부모와 자식간에 서로 양방향 reference를 갖고 있으면<br>
  * 절대 안된다. Stack Overflow를 내며 JVM을 내릴 것이다.
  *
  *
  * @param java.lang.Object Object내의 public String 형뿐만 아니라, Object[], Vector 등과<br>
  *        같은 public Object형 Member Variable에 영향을 준다.
  *
  *
  */
 public static void fixNullAndTrimAll(Object o)
 {
    if ( o == null ) return;

    Class c = o.getClass();
    if ( c.isPrimitive() ) return;

    if( c.isArray() ) {
       int length = Array.getLength(o);
       for(int i=0; i<length ;i++){
          Object element = Array.get(o, i);
          fixNullAndTrimAll(element);
       }
    }
    else {
       Field[] fields = c.getFields();
       for (int i=0 ; i<fields.length; i++) {
          try {
             Object f = fields[i].get(o);
             Class fc = fields[i].getType();
             if ( fc.isPrimitive() ) continue;
             if ( fc.getName().equals("java.lang.String") ) {
                if ( f == null ) fields[i].set(o, "");
                else {
                   String item = trim( (String)f );
                   fields[i].set(o, item);
                }
             }
             else if ( f != null ) {
                fixNullAndTrimAll(f);
             }
             else {} // Some Object, but it's null.
          }
          catch(Exception e) {
          }
       }
    }
 }
 /**
  * request.getAttribute()
  * request로부터 parameterName에 해당하는 값을 얻어오는데 만일에
  * 존재하지 않으면 defaultValue로 대체해서 리턴한다.
  * @return java.lang.Object
  * @param request javax.servlet.http.HttpServletRequest
  * @param parameterName String
  * @param defaultValue Object
  */
 public static Object getAttribute(HttpServletRequest request,String parameterName,Object defaultValue) {
     Object paramValue = request.getAttribute(parameterName);
     if (paramValue == null) paramValue = defaultValue;
     return paramValue;
 }
 /**
  * request.getAttribute()
  * isParameterRequired이 true이면
  * request에서 꺼내온 것이 null일 경우 Exception 발생한다.
  * null이면 안되는 파라메터인 경우에 사용한다.<br>
  * ex) String temp = (String)LCUtil.getAttribute(request,"TEMP",true);<br>
  * @return java.lang.Object
  * @param request javax.servlet.http.HttpServletRequest
  * @param parameterName String
  * @param isParameterRequired boolean
  */
 public static Object getAttribute(HttpServletRequest request,String parameterName,boolean isParameterRequired)
     throws Exception {
     Object paramValue = request.getAttribute(parameterName);

     if ((isParameterRequired) && (paramValue == null))
         throw new Exception("Parameter " + parameterName + " was not specified.");

     return paramValue;
 }
 /**
  * session.getAttribute()
  * session로부터 parameterName에 해당하는 값을 얻어오는데 만일에
  * 존재하지 않으면 defaultValue로 대체해서 리턴한다.
  * @return java.lang.Object
  * @param session javax.servlet.http.HttpSession
  * @param parameterName String
  * @param defaultValue Object
  */
 public static Object getAttribute(HttpSession session,String parameterName,Object defaultValue) {
     Object paramValue = session.getAttribute(parameterName);
     if (paramValue == null) paramValue = defaultValue;
     return paramValue;
 }
 /**
  * session.getAttribute()
  * isParameterRequired이 true이면
  * session에서 꺼내온 것이 null일 경우 Exception 발생한다.
  * null이면 안되는 파라메터인 경우에 사용한다.<br>
  * @return java.lang.Object
  * @param session javax.servlet.http.HttpSession
  * @param parameterName String
  * @param isParameterRequired boolean
  */
 public static Object getAttribute(HttpSession session,String parameterName,boolean isParameterRequired)
     throws Exception {
     Object paramValue = session.getAttribute(parameterName);

     if ((isParameterRequired) && (paramValue == null))
         throw new Exception("Parameter " + parameterName + " was not specified.");

     return paramValue;
 }
 /**
  * @return java.lang.String
  * @param pattern java.lang.String
  */
 public static String getCardFormat(String pattern) {
    String result = null;

    if( pattern.length() != 16) {
       result = null;
    }else if(pattern.length() == 16) {
       result = pattern.substring(0,4)+"-"+pattern.substring(4,8)+"-"+pattern.substring(8,12)+"-"+pattern.substring(12,16);
    }
    return result;
 }
 /**
  * @return java.lang.String
  * @param dvar double
  */
 public static String getDecimalPoint(double dvar) {
    String str = Double.toString(dvar);
    StringBuffer buff = new StringBuffer();
    char[] ch = str.toCharArray();
    int count = 0;
    if( ch.length <= 5) {
       return str;
    }else {
       for( int i=0; i<ch.length; i++ ) {
          if( ch[i] == '.'  )
             count = i;
       }
       for(int j =0 ;j < count+2;j++) {
             buff.append(ch[j]);
           }

    }
    return buff.toString();
 }
 /**
  * @return java.lang.String
  * @param dvar double
  */
 public static String getDecimalPoint(double dvar, int dplength) {
    String str = Double.toString(dvar);
    StringBuffer buff = new StringBuffer();
    char[] ch = str.toCharArray();
    int count = 0;
    if( ch.length <= 5) {
       for(int i=ch.length; i < dplength+2; i++)
          str = str+"0";
       return str;
    }else {
       for( int i=0; i<ch.length; i++ ) {
          if( ch[i] == '.'  )
             count = i;
       }
       for(int j =0 ;j <= count+dplength;j++) {
             buff.append(ch[j]);
           }

    }
    return buff.toString();
 }
 /**
  * [예제]<br>
  * Util.getDecimalPoint(776760.9887);<br>
  * 결과 : 776760.9<br>
  * @return java.lang.String<br>
  * @param fvar float
  */
 public static String getDecimalPoint(float fvar) {
    String str = Float.toString(fvar);
    StringBuffer buff = new StringBuffer();
    char[] ch = str.toCharArray();
    int count = 0;
    if( ch.length < 5) {
       return str;
    }else {
       for( int i=0; i<ch.length; i++ ) {
          if( ch[i] == '.'  )
             count = i;
       }
       for(int j =0 ;j < count+2;j++) {
             buff.append(ch[j]);
           }

    }
    return buff.toString();

 }
 /**
  * @return java.lang.String
  * @param fvar float
  */
 public static String getDecimalPoint(float fvar, int dplength) {
    String str = Float.toString(fvar);
    StringBuffer buff = new StringBuffer();
    char[] ch = str.toCharArray();
    int count = 0;
    if( ch.length <= 5) {
       for(int i=ch.length; i < dplength+2; i++)
          str = str+"0";
       return str;
    }else {
       for( int i=0; i<ch.length; i++ ) {
          if( ch[i] == '.'  )
             count = i;
       }
       for(int j =0 ;j <= count+dplength;j++) {
             buff.append(ch[j]);
           }

    }
    return buff.toString();

 }
 /**
  * DecimalPoint를 찍어 리턴 해준다.
  * [예제]<br>
  * Util.getDecimalPoint("776760.9887");<br>
  * 결과 : 776760.98<br>
  * @return java.lang.String
  * @param str java.lang.String
  */
 public static String getDecimalPoint(String str) {
    StringBuffer buff = new StringBuffer();
    char[] ch = str.toCharArray();
    int count = 0;
    if( ch.length < 5) {
       return str;
    }else {
       for( int i=0; i<ch.length; i++ ) {
          if( ch[i] == '.'  )
             count = i;
       }
       for(int j =0 ;j <= count+2;j++) {
             buff.append(ch[j]);
           }

    }
    return buff.toString();
 }
 /**
  * @return java.lang.String
  * @param str java.lang.String
  */
 public static String getDecimalPoint(String str, int dplength) {
    StringBuffer buff = new StringBuffer();
    char[] ch = str.toCharArray();
    int count = 0;
    if( ch.length <= 5) {
       for(int i=ch.length; i < dplength+2; i++)
          str = str+"0";
       return str;
    }else {
       for( int i=0; i<ch.length; i++ ) {
          if( ch[i] == '.'  )
             count = i;
       }
       for(int j =0 ;j <= count+dplength;j++) {
             buff.append(ch[j]);
           }

    }
    return buff.toString();
 }
 /**
  * 설명 : 달러표시 <br>
  * <br>
  * @return java.lang.String
  * @param patternlong java.lang.Long
  */
 public static String getDollarFormat(long patternlong, int cent) {
     String total =  Long.toString(patternlong);

    String pattern = total.substring(0,(total.length() - cent));
    String centString = total.substring((total.length() - cent),total.length());

     int leng = pattern.length();
     int nameji = (leng-1)/3;
     String result= null;

    if(  nameji == 0 ) {
         result  = pattern;
      }else if(nameji == 1) {
       result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),leng);
      }else if(nameji == 2) {
         result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),leng-(nameji*3)+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6));
      }else if(nameji == 3) {
       result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9));
      }else if(nameji == 4) {
       result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12));
      }else if(nameji == 5) {
         result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12))+","+pattern.substring((leng-(nameji*3)+12),(leng-(nameji*3)+15));
      }else if(nameji == 6) {
       result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12))+","+pattern.substring((leng-(nameji*3)+12),(leng-(nameji*3)+15))+","+pattern.substring((leng-(nameji*3)+15),(leng-(nameji*3)+18));
      }

      if( centString.length() == 0 )
         return result;
      else
         return result + "." +centString;
 }
 /**
  * 설명 : 달러표시 <br>
  * <br>
  * @return java.lang.String
  * @param total java.lang.String
  */
 public static String getDollarFormat(String total, int cent) {

    String pattern = total.substring(0,(total.length() - cent));
    String centString = total.substring((total.length() - cent),total.length());

     int leng = pattern.length();
     int nameji = (leng-1)/3;
     String result= null;

    if(  nameji == 0 ) {
         result  = pattern;
      }else if(nameji == 1) {
       result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),leng);
      }else if(nameji == 2) {
         result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),leng-(nameji*3)+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6));
      }else if(nameji == 3) {
       result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9));
      }else if(nameji == 4) {
       result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12));
      }else if(nameji == 5) {
         result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12))+","+pattern.substring((leng-(nameji*3)+12),(leng-(nameji*3)+15));
      }else if(nameji == 6) {
       result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12))+","+pattern.substring((leng-(nameji*3)+12),(leng-(nameji*3)+15))+","+pattern.substring((leng-(nameji*3)+15),(leng-(nameji*3)+18));
      }

      if( centString.length() == 0 )
         return result;
      else
         return result + "." +centString;
 }
 /**
  * HashMap의 키 정보만 추출하여 String배열로 리턴
  */
 public static String[] getHashMapKeys(HashMap map) {
    if( map==null ) return null;
    String[] ret = new String[map.size()];
    int inc = 0;
    for( Iterator i=map.keySet().iterator(); i.hasNext(); ) {
       ret[inc++] = (String)i.next();
    }

    return ret;
 }
 /**
  * request로부터 parameterName에 해당하는 값을 얻어오는데<br>
  * 만일에 존재하지 않으면 defaultValue로 대체해서 리턴한다.
  */
 public static String getParameter(HttpServletRequest request,String parameterName,String defaultValue) {
     String paramValue = request.getParameter(parameterName);
     if(paramValue==null || paramValue.length()==0) paramValue = defaultValue;
     return paramValue;
 }
 /**
  * isParameterRequired이 true이면<br>
  * request에서 꺼내온 것이 null일 경우 Exception 발생한다.<br>
  * null이면 안되는 파라메터인 경우에 사용한다.<br>
  * ex) String temp = LCUtil.getParameter(request,"TEMP",true);
  */
 public static String getParameter(HttpServletRequest request,String parameterName,boolean isParameterRequired)
     throws Exception {
     String paramValue = request.getParameter(parameterName);

     if ((isParameterRequired) && (paramValue == null))
         throw new Exception("Parameter " + parameterName + " was not specified.");

     return paramValue;
 }
 /**
  * request로부터 parameterName에 해당하는 값을 얻어오는데<br>
  * 만일에 존재하지 않으면 defaultValue로 대체해서 리턴한다.
  */
 public static String[] getParameterValues(HttpServletRequest request,String parameterName,String[] defaultValue) {
     String[] paramValue = request.getParameterValues(parameterName);
     if (paramValue == null) paramValue = defaultValue;
     return paramValue;
 }
 /**
  * isParameterRequired이 true이면<br>
  * request에서 꺼내온 것이 null일 경우 Exception 발생한다.<br>
  * null이면 안되는 파라메터인 경우에 사용한다.<br>
  * ex) String[] temp = LCUtil.getParameterValues(request,"TEMP",true);
  */
 public static String[] getParameterValues(HttpServletRequest request,String parameterName,boolean isParameterRequired)
     throws Exception {
     String[] paramValue = request.getParameterValues(parameterName);

     if ((isParameterRequired) && (paramValue == null))
         throw new Exception("Parameter " + parameterName + " was not specified.");

     return paramValue;
 }
 /**
  * @return java.lang.String
  * @param str java.lang.String
  */
 public static String getRawBlank(String str) {
    char[] c = str.toCharArray();
    StringBuffer buff = new StringBuffer();
    for(int i=0; i<c.length; i++ )
       if(c[i] != ' ') buff.append(c[i]);
    return buff.toString();
 }
 /**
  * 주어진 스트링에서 숫자로 된것만 추려서 리턴한다.
  * @return java.lang.String
  * @param str java.lang.String
  */
 public static String getRawDigit(String str) {
    char[] c = str.toCharArray();
    StringBuffer buff = new StringBuffer();
    for(int i=0; i<c.length; i++ )
       if(Character.isDigit(c[i])) buff.append(c[i]);
    return buff.toString();
 }
 /**
  * HashMap의 키 정보만 추출하여 String배열로 리턴
  */
 public static Object[] getSetValues(Set set) {
    if(set==null) return null;
    Object[] ret = new Object[set.size()];
    int inc = 0;
    for( Iterator i=set.iterator(); i.hasNext(); ) {
       ret[inc++] = i.next();
    }

    return ret;
 }
 /**
  * Throwable의 스택메시지를 스트링으로 리턴한다.
  * @return String
  * @param e java.lang.Throwable
  */
 public static String getStackTrace(Throwable e) {
    java.io.ByteArrayOutputStream bos = new java.io.ByteArrayOutputStream();
    java.io.PrintWriter writer = new java.io.PrintWriter(bos);
    e.printStackTrace(writer);
    writer.flush();
    return bos.toString();
 }
 /**
  * fileName을 시스템의 separator에 맞게<br>
  * 파일을 변환시켜서 리턴
  */
 public static String getSystemFileName(String fileName) {
    String separator = System.getProperty("file.separator");
    fileName = replaceAll(fileName,"\\",separator);
    fileName = replaceAll(fileName,"/",separator);
    return fileName;
 }
 /**
  * String으로 넘겨진 파일명의 확장자를 가져온다.
  * @param fileName
  * @return
  */
 public static String getFileExtension(String fileName) {
 	return fileName.substring( fileName.lastIndexOf( "." ) + 1 );
 }
 /**
  * 설명 : 원화표시 <br>
  * <br>
  * @return java.lang.String
  * @param patternlong java.lang.Long
  */
 public static String getWonFormat(long patternlong) {
     String pattern =  Long.toString(patternlong);
     int leng = pattern.length();
     int nameji = (leng-1)/3;
     String result= null;

    if(  nameji == 0 ) {
         result  = pattern;
      }else if(nameji == 1) {
    result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),leng);
      }else if(nameji == 2) {
         result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),leng-(nameji*3)+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6));
      }else if(nameji == 3) {
    result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9));
      }else if(nameji == 4) {
    result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12));
      }else if(nameji == 5) {
         result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12))+","+pattern.substring((leng-(nameji*3)+12),(leng-(nameji*3)+15));
      }else if(nameji == 6) {
    result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12))+","+pattern.substring((leng-(nameji*3)+12),(leng-(nameji*3)+15))+","+pattern.substring((leng-(nameji*3)+15),(leng-(nameji*3)+18));
      }
         return result;
 }
 /**
  * 설명 : 원화표시 <br>
  * <br>
  * @return java.lang.String
  * @param pattern java.lang.String
  */
 public static String getWonFormat(String pattern) {
     int leng = pattern.length();
     int nameji = (leng-1)/3;
     String result= null;

    if(  nameji == 0 ) {
         result  = pattern;
      }else if(nameji == 1) {
    result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),leng);
      }else if(nameji == 2) {
         result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),leng-(nameji*3)+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6));
      }else if(nameji == 3) {
    result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring(leng-(nameji*3),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9));
      }else if(nameji == 4) {
    result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12));
      }else if(nameji == 5) {
         result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12))+","+pattern.substring((leng-(nameji*3)+12),(leng-(nameji*3)+15));
      }else if(nameji == 6) {
    result = pattern.substring(0 , leng-(nameji*3))+","+pattern.substring((leng-(nameji*3)),(leng-(nameji*3))+3)+","+pattern.substring((leng-(nameji*3)+3),(leng-(nameji*3)+6))+","+pattern.substring((leng-(nameji*3)+6),(leng-(nameji*3)+9))+","+pattern.substring((leng-(nameji*3)+9),(leng-(nameji*3)+12))+","+pattern.substring((leng-(nameji*3)+12),(leng-(nameji*3)+15))+","+pattern.substring((leng-(nameji*3)+15),(leng-(nameji*3)+18));
      }
         return result;
 }
 /**
  * 인수로 Object의 배열을 받아 compareAttr이라는 특정 어트리뷰트로
  * 원하는 order에 따라 배열자체를 소팅한다.<br>
  * 리턴값은 없고 함수를 호출하면 인수로 넘긴 것이 소팅이 된다.
  * order의 구분은 "ASC"와 "DESC"이다.<br>
  *
  * @return void
  * @param obj java.lang.Object[]
  * @param compareAttr java.lang.String
  * @param order java.lang.String
  */
 public static void quickSort(Object[] objs, String compareAttr, String order) {
    quickSort(objs,compareAttr,order,0,objs.length);
 }
 /**
  * quickSort(obj,compareAttr,order)의 구체적인 함수<br>
  * @return void
  * @param obj java.lang.Object[]
  * @param compareAttr java.lang.String
  * @param order java.lang.String
  * @param low int
  * @param high int
  */
 private static void quickSort(Object[] obj, String compareAttr, String order,
                     int low, int high) {
    if( low>=high ) return;

    int i, count=low;
    Object temp, pibot=obj[low];

    for(i=low+1 ; i<high ; i++) {
       if((order.equals("ASC") && compareTo(pibot,obj[i],compareAttr)>0) ||
          (order.equals("DESC") && compareTo(pibot,obj[i],compareAttr)<0)) {
          temp = obj[i];
          for(int j=i-1 ;j>=low ; j--) obj[j+1] = obj[j];
          obj[low] = temp;
          count++;
       }
    }
    quickSort(obj,compareAttr,order,count+1,i);
    quickSort(obj,compareAttr,order,low,count);
 }
 /**
  * str의 지정한 위치를 replace로 대체
  * @return java.lang.String
  * @param str1 java.lang.String
  * @param off int
  * @param len int
  * @param replace java.lang.String
  */
 public static String replace(String str, int off, int len, String replace) {
    StringBuffer buff = new StringBuffer( str );
    buff.replace( off,off+len,replace );
    return buff.toString();
 }
 /**
  * str1의 off index이후에 있는 처음 str2를 replace로 대체
  * @return java.lang.String
  * @param str1 java.lang.String
  * @param off int
  * @param str2 java.lang.String
  * @param replace java.lang.String
  */
 public static String replace(String str1, int off, String str2, String replace) {
    off = str1.indexOf( str2,off );
    if( off==-1 ) return str1;

    StringBuffer buff = new StringBuffer( str1 );
    buff.replace( off,off+str2.length(),replace );
    return buff.toString();
 }
 /**
  * str1내에 있는 처음 str2를 replace로 대체
  * @return java.lang.String
  * @param str1 java.lang.String
  * @param str2 java.lang.String
  * @param replace java.lang.String
  */
 public static String replace(String str1, String str2, String replace) {
    return replace( str1,0,str2,replace );
 }
 /**
  * str1의 off index이후에 있는 모든 str2를 replace로 대체
  * @return java.lang.String
  * @param str1 java.lang.String
  * @param off int
  * @param str2 java.lang.String
  * @param replace java.lang.String
  */
 public static String replaceAll(String str1, int off, String str2, String replace) {
    if(str1==null || str2==null || replace==null) return str1;

    off = str1.indexOf( str2,off );
    StringBuffer buff = new StringBuffer( str1 );
    while( off!=-1 )
    {
       buff.replace( off,off+str2.length(),replace );
       str1 = buff.toString();
       if( off+str2.length() < str1.length() )
       {
         off = str1.indexOf(str2, off + str2.length());
       }
       else off = -1;
    }
    return str1;
 }
 /**
  * str1내에 있는 모든 str2를 replace로 대체
  * @return java.lang.String
  * @param str1 java.lang.String
  * @param str2 java.lang.String
  * @param replace java.lang.String
  */
 public static String replaceAll(String str1, String str2, String replace) {
//    return str1.replaceAll(str1,replace);
    return replaceAll( str1,0,str2,replace );
 }
 /**
  * 6자리 숫자로만 된 우편번호를 중간에 '-'를 집어넣은 형태로 리턴.
  * @return java.lang.String
  * @param zipCD java.lang.String
  */
 public static String toFormatZip(String zipCD) {
    if(zipCD==null || zipCD.length()!=6) return zipCD;
    return zipCD.substring(0,3)+"-"+zipCD.substring(3);
 }
 /**
  * 문자의 원하는 위치에 delimeter 삽입후 리턴.
  * null 이거나 한글이 입력되었을 때는 입력된 문자를 리턴한다.<br>
  * [예제]<br>
  * 주민번호에 '-'를 넣으려 할때<br>
  * String ssn = "8032121344233";<br>
  * String rtnValue = Util.addFixDelim(ssn,'-',6);<br>
  * 결과 : 803212-1344233<br>
  * .<br>
  * 반대로 delimeter를 삭제 하고자 할때는 replace를 사용하면 된다.<br>
  * String ssn = "803212-1344233";<br>
  * String rtnValue = Util.replace(ssn,"-","");<br>
  * .<br>
  * ps) addFixDelim 에서는 delimeter가 char형이므로 '-' 를 사용했고<br>
  *        replace에서는 delimeter가 String형이므로 "-" 를 사용했다.<br>
  */
 public static String addFixDelim(String str,char delim,int off) {
  if(str==null) return str;
  if(hanCheck(str)) return str;

  if(str.length()>off) return str.substring(0,off)+delim+str.substring(off);
  else return str;
 }
 /**
  * 문자의 원하는 위치에 delimeter를 삽입후 리턴.
  * null 이거나 한글이 입력되었을 때는 입력된 문자를 리턴한다.<br>
  * [예제]<br>
  * 날짜에 '-'를 넣으려 할때<br>
  * 날짜에는 '-' 가 두개 들어 간다.<br>
  * .<br>
  * String date = "20021023";<br>
  * String rtnValue = Util.addFixDelim(date,'-',4,6);<br>
  * 결과 : 2002-10-23<br>
  * .<br>
  * 반대로 delimeter를 삭제 하고자 할때는 replaceAll를 사용하면 된다.<br>
  * String date = "803212-1344233";<br>
  * String rtnValue = Util.replaceAll(date,"-","");<br>
  * .<br>
  * ps) addFixDelim 에서는 delimeter가 char형이므로 '-' 를 사용했고<br>
  *        replace에서는 delimeter가 String형이므로 "-" 를 사용했다.
  */
 public static String addFixDelim(String str,char delim,int off1,int off2) {
  if(str==null) return str;
  if(hanCheck(str)) return str;
  if(str.length()>off2) return str.substring(0,off1)
                       +delim+str.substring(off1,off2)
                       +delim+str.substring(off2);
  else return str;
 }
 /**
  * 문자의 원하는 위치에 delimeter를 삽입후 리턴.
  * null 이거나 한글이 입력되었을 때는 입력된 문자를 리턴한다.<br>
  * [예제]<br>
  * delimeter('-') 를 3개 넣어야 할때<br>
  * .<br>
  * String str = "34234455";<br>
  * String rtnValue = Util.addFixDelim(str,'-',2,4,6);<br>
  * 결과 : 34-34-44-55<br>
  * .<br>
  * 반대로 delimeter를 삭제 하고자 할때는 replaceAll를 사용하면 된다.<br>
  * String str = "34-34-44-55";<br>
  * String rtnValue = Util.replaceAll(str,"-","");<br>
  * .<br>
  * ps) addFixDelim 에서는 delimeter가 char형이므로 '-' 를 사용했고<br>
  *        replace에서는 delimeter가 String형이므로 "-" 를 사용했다.
 */
public static String addFixDelim(String str,char delim,int off1,int off2,int off3) {
 if(str==null) return str;
 if(hanCheck(str)) return str;
 if(str.length()>off3) return str.substring(0,off1)
                      +delim+str.substring(off1,off2)
                      +delim+str.substring(off2,off3)
                      +delim+str.substring(off3);
 else return str;
}
 /**
  * 문자의 원하는 위치에 delimeter를 삽입후 리턴.
  * null 이거나 한글이 입력되었을 때는 입력된 문자를 리턴한다.<br>
  * [예제]<br>
  * delimeter('-') 를 4개 넣어야 할때<br>
  * .<br>
  * String str = "3423445566";<br>
  * String rtnValue = Util.addFixDelim(str,'-',2,4,6,8);<br>
  * 결과 : 34-34-44-55-66<br>
  * .<br>
  * 반대로 delimeter를 삭제 하고자 할때는 replaceAll를 사용하면 된다.<br>
  * String str = "34-34-44-55-66";<br>
  * String rtnValue = Util.replaceAll(str,"-","");<br>
  * .<br>
  * ps) addFixDelim 에서는 delimeter가 char형이므로 '-' 를 사용했고<br>
  *        replace에서는 delimeter가 String형이므로 "-" 를 사용했다.
 */
public static String addFixDelim(String str,char delim,int off1,int off2,int off3,int off4) {
if(str==null) return str;
if(hanCheck(str)) return str;
if(str.length()>off4) return str.substring(0,off1)
                     +delim+str.substring(off1,off2)
                     +delim+str.substring(off2,off3)
                     +delim+str.substring(off3,off4)
                     +delim+str.substring(off4);
else return str;
}

/**
 * 입력된 문자형 숫자를 전화번호 타입으로 변경후 리턴<br>
 * 023451234 ==> 02-345-1234
 * @param originNumber
 * @return String value
 */
public static String getPhoneNumber(String originNumber) {

   int totalSize = originNumber.length();

   if ( originNumber.indexOf(")") >= 0 || originNumber.indexOf("-") >= 0 || totalSize < 7);
   else
   {

      if ( originNumber.substring(0, 2).equals("02") && totalSize > 7 )
      {
         return originNumber.substring(0, 2) + "-" + originNumber.substring(2, totalSize- 4) + "-" + originNumber.substring(totalSize - 4, totalSize);
      }
      else
      {
         String areaNum = originNumber.substring(0, 3);
         if ( totalSize > 8 && (
            areaNum.equals("031") || areaNum.equals("032") || areaNum.equals("033") ||
            areaNum.equals("041") || areaNum.equals("042") || areaNum.equals("043") ||
            areaNum.equals("051") || areaNum.equals("052") || areaNum.equals("053") || areaNum.equals("054") || areaNum.equals("055") ||
            areaNum.equals("061") || areaNum.equals("062") || areaNum.equals("063") || areaNum.equals("064") ||
            areaNum.equals("011") || areaNum.equals("016") || areaNum.equals("017") || areaNum.equals("018") || areaNum.equals("019") ||
            areaNum.equals("012") || areaNum.equals("015") )   )
         {
            return originNumber.substring(0, 3) + "-" + originNumber.substring(3, totalSize- 4) + "-" + originNumber.substring(totalSize - 4, totalSize);
         }
      }
   }

   return originNumber;
}
 /**
 * String이라고 예상되어있는 값이 null( ""이 아님)로 들어 왔을 경우에
 * 대체를 해주는 함수.
 * @param   value   null인지 확인을 해야 하는 대상
 * @param   replacer    value가 null일 경우에 대체될 값
 * @return  value value가 null이 아닐경우에는 value, null일경우에는 replacer가 반환됨.
 **/
 public static String nvl(String value, String replacer){
    if (value == null){
       return replacer;
    }else{
       return value;
    }
 }
 /**
  * double 을 받아서 wantLength의 앞단에서 반올림해 주는 메소드.<p>
  * @param dValue<br>
  * @param wantLength<br>
  * @return String value
  */
 public static String round(double dValue, int wantLength) {

    String rValue = "";
    int rLength = 0;

    for ( int i=0 ; i<wantLength ; i++ )
       dValue = dValue * 10;

    rValue = String.valueOf(Math.round(dValue));                    // ^^
    rLength = rValue.length();

    if ( rLength <= wantLength )    {

       for ( int i=0 ; i< (wantLength-rLength) ; i++ )
          rValue = "0" + rValue;

       rValue = "0." + rValue;

    } else {

       rValue = rValue.substring(0, rValue.length()-wantLength) + "." + rValue.substring(rValue.length()-wantLength);

    }

    return rValue;
 }

/**
* DB에 저장된 enter key값을 <br>로 변환한다.
*@param String
*@return String
**/
public static String convertHtmlBr(String comment)
{
   int length = comment.length();
   StringBuffer sb = new StringBuffer();

   for (int i = 0; i < length; ++i)
   {
      String comp = comment.substring(i, i+1);
      if ("\r".compareTo(comp) == 0)
      {
         comp = comment.substring(++i, i+1);
         if ("\n".compareTo(comp) == 0)
            sb.append("<BR>\r");
         else
            sb.append("\r");
      }
      sb.append(comp);
   }
   return sb.toString();
}
/**
 * 한글 여부 체크.(
 * 입력 문자열이 한글이면 true, 한글이 아니면 false.
 */
public static boolean hanCheck(String str) {
  if(str.length() == str.getBytes().length) // 한글이 아니면
   return false;
  else    // 한글이면
   return true;
}

/**
 * DB로부터 읽어와서 브라우저로 출력할 때 한글을 'KSC5601'로 변환.
 * 톰캣에서는 한글을 읽어올 때 변환 과정이 필요하다.<br>
 * 레진에서는 jsp인 경우, 변환 불필요, 서블릿인 경우 변환 필요(?)
 * @param str 변환할 한글 문자열
 */
public static final String ToKo(String str) { // DB Selecting
String result = null;
if (str == null)
   return null;
try {
   result = new String(str.getBytes("8859_1"), "KSC5601");
} catch (UnsupportedEncodingException e) {
   e.printStackTrace();
}
return result;
}

/**
 * DB에 저장이나 검색을 위해 접근하기 전에 브라우저로 입력한 한글을 '8859_1'로 변환.
 * 톰캣에서는 저장시 변환이 불필요하나, 레진에서는 저장시 코드변환 필요하다.
 * @param str 변환할 한글 문자열
 */
public static final String ToEng(String str) {  // DB insert, delete, update
String result = null;
if (str == null)
   return null;
try {
   result = new String(str.getBytes("KSC5601"), "8859_1");
} catch (UnsupportedEncodingException e) {
   e.printStackTrace();
}
return result;
}

/**
* Remove special white space from both ends of this string.
* <p>
* All characters that have codes less than or equal to
* <code>'&#92;u0020'</code> (the space character) are considered to be
* white space.
* <p>
* java.lang.String의 trim()과 차이점은 일반적인 white space만 짜르는 것이
* 아니라 위에서와 같은 특수한 blank도 짤라 준다.<br>
* 이 소스는 IBM HOST와 데이타를 주고 받을 때 유용하게 사용했었다.
* 일반적으로 많이 쓰이지는 않을 것이다.
*
* @param  java.lang.String
* @return trimed string with white space removed
*         from the front and end.
*/
public static String trim(String s) {
  int st = 0;
  char[] val = s.toCharArray();
  int count = val.length;
  int len = count;

  while ((st < len) && ((val[st] <= ' ') || (val[st] == '　') ) )   st++;
  while ((st < len) && ((val[len - 1] <= ' ') || (val[len-1] == '　')))  len--;

  return ((st > 0) || (len < count)) ? s.substring(st, len) : s;
}
public static String getUni(String str) {

  int index = 0;
  String str2 = "";
  if(str==null) return str2;

  if (str.length() != 0)
  {
     index = str.lastIndexOf(".");
     if (index != -1)
     {
        str2 = hex2uni(str.substring(0, index)) + str.substring(index);
        str = str2;
     }
     else
     {
        str = hex2uni(str);
     }
  }
  return str;
}
public static String hex2uni(String hex){
    StringBuffer str = new StringBuffer();
    for( int i= 0; i < hex.length(); i=i+4 ){
       str.append( String.valueOf( (char)Integer.parseInt( hex.substring( i, i + 4 ) ,16) ) );
    }
    return str.toString();
  }
public static String uni2hex(String s){
    StringBuffer uni_s = new StringBuffer();
    String temp_s = null;
    for( int i=0 ; i < s.length() ; i++){
             temp_s = Integer.toHexString( s.charAt(i) );
       uni_s.append( temp_s.length()==4 ? temp_s : "00" + temp_s  );
    }
    return uni_s.toString();
}
/**
 * 전화번호 문자에 delimeter를 넣어 리턴.
 * [예제]<br>
 * 전화번호에 "-"를 넣으려할때<br>
 * String tel = "029991111";<br>
 * String rtnValue = Util.getTelNum(tel,"-");<br>
 * 결과 : 02-999-1111<br>
 * .<br>
 * 반대로 delimeter를 삭제 하고자 할때는 replace를 사용하면 된다.<br>
 * String tel = "02-999-1111";<br>
 * String rtnValue = Util.replaceAll(tel,"-","");<br>
 * .<br>
 */
public static String getTelNum(String value,String delimeter)
{
    if(delimeter == null) delimeter="-";
    if (value == null || value.equals("")) {
     return "" ;
     //일반전화의 경우
    }
    else if (value.startsWith("02") || value.startsWith("03") ||
             value.startsWith("04") || value.startsWith("05") ||
             value.startsWith("06") || !value.startsWith("0"))
    { //지역번호가 있는 경우 즉 02 혹은 031로 시작하는 경우
     value = value.trim() ;
     if (value.startsWith("02")) { //02 로 시작하는 경우
      if (value.length() == 9) { //예) 027778888   9자리
       value = value.substring(0, 2) + delimeter + value.substring(2, 5) +
           delimeter + value.substring(5, 9) ; //  02-444-5555
      }
      else if (value.length() == 10) { //0244448888   10자리
       value = value.substring(0, 2) + delimeter + value.substring(2, 6) +
           delimeter + value.substring(6, 10) ; //  02-3333-5555
      }
      else {
       value = "" ;
      }
     }
     else if (value.startsWith("03") || value.startsWith("04") ||
              value.startsWith("05") || value.startsWith("06")) { //03 or 04  or 05 or 06
      if (value.length() == 9) { //예) 031778888   9자리
       value = value.substring(0, 3) + delimeter + value.substring(3, 5) +
           delimeter + value.substring(5, 9) ; //  031-44-5555
      }
      else if (value.length() == 10) { //03144448888   10자리
       value = value.substring(0, 3) + delimeter + value.substring(3, 6) +
           delimeter + value.substring(6, 10) ; //  031-333-5555
      }
      else if (value.length() == 11) { //   03144448888
       value = value.substring(0, 3) + delimeter + value.substring(3, 7) +
           delimeter + value.substring(7, 11) ; //  031-3333-5555
      }
     }
     else {
      if (value.length() == 8) {
       value = value.substring(0, 4) + delimeter + value.substring(4) ; //4444-8888
      }
      else if(value.length()==7) {
       value = value.substring(0, 3) + delimeter + value.substring(3, 7) ; //444-8888
      }
     }
     return value ;

     //휴대전화의 경우 (011 ,016, 017, 018 , 019)
    }
    else {
     value = value.trim() ;
     if (value.length() == 10) { //0164448888
      value = value.substring(0, 3) + delimeter + value.substring(3, 6) +
          delimeter + value.substring(6, 10) ; //016-444-8888
     }
     else if(value.length() == 11){ //01655559999
      value = value.substring(0, 3) + delimeter + value.substring(3, 7) +
          delimeter + value.substring(7, 11) ; //019-5555-9999
     }
     return value ;
    }
   }
   /**
    * null 일경우 변수에 원하는 값을 넣는다.
    * @param  String nullChkVal  : 널체크 문자열
    * @param  String changeVal   : 널일경우 변경 문자열
    * @return String str         : 변환된 문자열
    */
   public static String makeSetVariable(String nullChkVal, String changeVal)
   {
      if(isEmptyString(nullChkVal))
        return changeVal;
      else
        return nullChkVal;
   }
   /**
    * Null or 공백 여부를 check 하여 결과를 return
    * @param   String checkValue : null or 공백문자 여부를 Check 하고자 하는 String
    * @return  boolean bRetVal   : Null or 공백 인 경우 true를 return
    */
   public static boolean isEmptyString(String checkValue)
   {
     boolean bRetVal = false;
     if (checkValue == null || checkValue.trim().equals("") || checkValue.length() == 0)
       bRetVal = true;
     return bRetVal;
   }
   /**
    * 숫자형 문자열에서 숫자앞에 "0" 을 길이만큼 넣고자 할때 사용한다.
    * 예제:  숫자형 문자 "432"  앞에  8자리로 앞에 "0"을 넣고자 한다.
    *    String rtnVal = addZeroString("432",8);
    *    결과값은 : "00000432";
    * @param val
    * @param len
    * @return String
    */
   public static String addZeroString(String val,int len)
   {
     if(val == null) return "";
     int ilen = val.length();
     if(ilen >= len) return val;
     String zeroadd = "";
     for(int i=0;i<len-ilen;i++)
     {
         zeroadd +="0";
     }
     return zeroadd+val;
   }
   /**
    * 문자열 -> '문자열'
    * @param  String condition : 변환할 문자열
    * @return String condition : 변환된 문자열
    */
   public static String makeSetString(String condition)
   {
     return "'" + condition.trim() + "'";
   }

   /**
    * 문자열 -> '%문자열%' or '문자열%' or '%문자열'
    * @param  String condition : 변환할 문자열
    * @param  String code      : Like 종류 앞쪽:F 뒤쪽:R 양쪽:D
    * @return String condition : 변환된 문자열
    */
   public static String makeSetLIKE(String condition, String code)
   {
     int gubun = 0;

     if("F".trim().equalsIgnoreCase(code))
       gubun =1;
     else if("R".trim().equalsIgnoreCase(code))
       gubun =2;
     else if("D".trim().equalsIgnoreCase(code))
       gubun =3;
     else
       throw new java.lang.IllegalArgumentException("Illegal Argument Exception.");

     switch(gubun)
     {
       case 1:
         return makeSetString("%" + condition.trim());
       case 2:
         return makeSetString(condition.trim() + "%");
       case 3:
         return makeSetString("%" + condition.trim() + "%");
       default:
         throw new java.lang.IllegalArgumentException("Illegal Argument Exception.");
     }// end switch
   }
   public static int getBetweenDay(String start, String end) {
            if ( Integer.parseInt(start) >  Integer.parseInt(end) ) return 0;
            Calendar cal = new GregorianCalendar();
            int cnt = 0;
            String date = start;
            DecimalFormat numFormat = new DecimalFormat();
                  numFormat.applyPattern("00");

            cal.set(Calendar.YEAR, Integer.parseInt(start.substring(0,4)));
            // A month is represented by an integer form 0 to 11; 0 is January
            cal.set(Calendar.MONTH, Integer.parseInt(start.substring(4,6))-1);
            cal.set(Calendar.DATE, Integer.parseInt(start.substring(6,8)));
            while ( !date.equals(end) )
            {
                    cal.add(Calendar.DATE, 1);
                    date = String.valueOf(cal.get(Calendar.YEAR))
                    +  numFormat.format(cal.get(Calendar.MONTH)+1)
                    + numFormat.format(cal.get(Calendar.DATE)) ;
                    cnt++;
            }
            return cnt+1;
    }

    public static String[]  makingRsdbizidForAudit(String str,char delim,int off1,int off2)
       {
         String[] strarry = new String[2];
         strarry[0]="";
         strarry[1]="";
         if(str==null) return strarry;
         if(hanCheck(str)) return strarry;
         if(str.length()>off2)
         {
            strarry[0] =  str.substring(0,off1)
                          +delim+str.substring(off1,off2)
                          +delim+str.substring(off2,str.length()-2)+"**";

            strarry[1] = str.substring(0,off1)
                         +delim+str.substring(off1,off2)
                         +delim+str.substring(off2);
            return strarry;
         }
         else return strarry;
       }

       public static String[] makingRsdbizidForAudit(String str,char delim,int off)
       {
         String[] strarry = new String[2];
         strarry[0]="";
         strarry[1]="";
         if(str==null) return strarry;
         if(hanCheck(str)) return strarry;

         if(str.length()>off)
         {
           strarry[0] = str.substring(0,off)+delim+str.substring(off,str.length()-2)+"**";
           strarry[1] = str.substring(0,off)+delim+str.substring(off);
           return strarry;
         }
         else return strarry;
       }

       
       public static String encryptedAsString(String str)
       {
         String rtrStr ="";
         String result ="";
         if(Util.isEmptyString(str)) return rtrStr;
         rtrStr =str;
         HashMap map = new HashMap();
         map.put("A","÷");
         map.put("B","∠");
         map.put("C","□");
         map.put("D","┘");
         map.put("E","∝");
         map.put("F","♣");
         map.put("G","─");
         map.put("H","☜");
         map.put("I","∮");
         map.put("J","⊥");
         map.put("K","〕");
         map.put("L","≥");
         map.put("M","∞");
         map.put("N","∂");
         map.put("O","┐");
         map.put("P","∬");
         map.put("Q","∏");
         map.put("R","◐");
         map.put("S","¤");
         map.put("T","‡");
         map.put("U","┼");
         map.put("V","‰");
         map.put("W","┤");
         map.put("X","⊆");
         map.put("Y","←");
         map.put("Z","●");
         map.put("a","§");
         map.put("b","℃");
         map.put("c","ø");
         map.put("d","￥");
         map.put("e","×");
         map.put("f","┴");
         map.put("g","】");
         map.put("h","♡");
         map.put("i","♪");
         map.put("j","Æ");
         map.put("k","Ð");
         map.put("l","đ");
         map.put("m","│");
         map.put("n","ħ");
         map.put("o","ß");
         map.put("p","┬");
         map.put("q","þ");
         map.put("r","ŧ");
         map.put("s","Þ");
         map.put("t","Œ");
         map.put("u","┌");
         map.put("v","↕");
         map.put("w","ĳ");
         map.put("x","├");
         map.put("y","∴");
         map.put("z","▩");
         map.put("0","¶");
         map.put("1","ㆀ");
         map.put("2","ㅱ");
         map.put("3","ŉ");
         map.put("4","ª");
         map.put("5","◇");
         map.put("6","∑");
         map.put("7","㏘");
         map.put("8","☞");
         map.put("9","└");
         char[] splt = rtrStr.toCharArray();
         for (int i = 0; i < splt.length; i++) {
           result = result + map.get(String.valueOf(splt[i]));
         }
         return result;
       }

       public static String decryptedAsString(String str)
       {
         String rtrStr ="";
         String result ="";
         if(Util.isEmptyString(str)) return rtrStr;
         rtrStr =str;
         HashMap map2 = new HashMap();
         map2.put("÷","A");
         map2.put("∠","B");
         map2.put("□","C");
         map2.put("┘","D");
         map2.put("∝","E");
         map2.put("♣","F");
         map2.put("─","G");
         map2.put("☜","H");
         map2.put("∮","I");
         map2.put("⊥","J");
         map2.put("〕","K");
         map2.put("≥","L");
         map2.put("∞","M");
         map2.put("∂","N");
         map2.put("┐","O");
         map2.put("∬","P");
         map2.put("∏","Q");
         map2.put("◐","R");
         map2.put("¤","S");
         map2.put("‡","T");
         map2.put("┼","U");
         map2.put("‰","V");
         map2.put("┤","W");
         map2.put("⊆","X");
         map2.put("←","Y");
         map2.put("●","Z");
         map2.put("§","a");
         map2.put("℃","b");
         map2.put("ø","c");
         map2.put("￥","d");
         map2.put("×","e");
         map2.put("┴","f");
         map2.put("】","g");
         map2.put("♡","h");
         map2.put("♪","i");
         map2.put("Æ","j");
         map2.put("Ð","k");
         map2.put("đ","l");
         map2.put("│","m");
         map2.put("ħ","n");
         map2.put("ß","o");
         map2.put("┬","p");
         map2.put("þ","q");
         map2.put("ŧ","r");
         map2.put("Þ","s");
         map2.put("Œ","t");
         map2.put("┌","u");
         map2.put("↕","v");
         map2.put("ĳ","w");
         map2.put("├","x");
         map2.put("∴","y");
         map2.put("▩","z");
         map2.put("¶","0");
         map2.put("ㆀ","1");
         map2.put("ㅱ","2");
         map2.put("ŉ","3");
         map2.put("ª","4");
         map2.put("◇","5");
         map2.put("∑","6");
         map2.put("㏘","7");
         map2.put("☞","8");
         map2.put("└","9");

         char[] enslpt = rtrStr.toCharArray();
         for (int i = 0; i < enslpt.length; i++)
         {
           result = result + map2.get(String.valueOf(enslpt[i]));
         }
         return result;
       }
       
       public static String convertCharSet(String conStr) throws Exception
       {
         return new String(conStr.getBytes("8859_1"),"ksc5601");
       }

       public static String convertCharSet2(String conStr) throws Exception
       {
         return new String(conStr.getBytes("ksc5601"),"8859_1");
       }

       public static String convertCharSet(StringBuffer conStr) throws Exception
       {
         return new String(conStr.toString().getBytes("8859_1"),"ksc5601");
       }
       
}
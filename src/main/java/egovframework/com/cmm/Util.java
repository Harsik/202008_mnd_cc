package egovframework.com.cmm;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public class Util
{
	public final static String FS = File.separator;

	/*--todo : Integer 관련 */
	private static int square(int nOrg, int nLoop)
	{
		int nReturn = 1;
		
		for(int i = 0; i < nLoop; i++)
			nReturn *= nOrg;
		
		return nReturn;
	}

	/**
	 * 문자열을 반올림
	 * 
	 * @param nOrg
	 *            반올림문자열
	 * @param nPos
	 *            반올림위치 (하위자리수포함)
	 * @return 반올림된int
	 */
	public static int round(String nOrg, int nPos)
	{
		return round(nullInt(nOrg), nPos);
	}

	/**
	 * int 숫자를 반올림
	 * 
	 * @param nOrg
	 *            반올림int
	 * @param nPos
	 *            반올림위치 (하위자리수포함)
	 * @return 반올림된int
	 */
	public static int round(int nOrg, int nPos)
	{
		return (int)(((float)nOrg / square(10, nPos)) + 0.5) * square(10, nPos);
	}

	/**
	 * 문자열을 숫자로 사용가능하는지 검사
	 * 
	 * @param szStr
	 *            해당문자열
	 * @return true 숫자로변환가능, false 숫자로변환불가능
	 */
	public static boolean isNum(String szStr)
	{
		try
		{
			Integer.parseInt(szStr);
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
	}

	/**
	 * 문자열에서 오직 숫자로 사용될수있는 문자열만 반환
	 * 
	 * @param szStr
	 *            해당문자열
	 * @return 숫자로 사용될수 있는 문자열
	 */
	public static String onlyNumber(String szStr)
	{
		if(szStr.length() > 1 && szStr.charAt(1) == '.')
			return szStr;

		String szReturn = "";
		boolean bFirstZero = true;

		for(int i = 0; i < szStr.length(); i++)
		{
			if(bFirstZero && Util.nullInt(szStr.substring(i, i + 1)) == 0)
				continue;
			
			bFirstZero = false;
			
			if(isNum(szStr.substring(i, i + 1)))
				szReturn += szStr.charAt(i);
		}
		
		return szReturn;
	}

	/**
	 * 문자열에서 전화번호로 사용 될 수 있는 숫자만 추출 int로 변환하지 않음으로 앞자리가 0이라도 반환이 된다
	 * 
	 * @param str
	 *            해당문자열
	 * @return 앞자리의 0을 포함한 숫자로 된 문자열 리턴
	 */
	public static String onlyNum(String str)
	{
		if(str == null)
			return "";

		StringBuffer sb = new StringBuffer();
		
		for(int i = 0; i < str.length(); i++)
		{
			if(Character.isDigit(str.charAt(i)))
				sb.append(str.charAt(i));
		}
		
		return sb.toString();
	}

	/**
	 * 핸드폰 번호중 앞의 0을 제거
	 * 
	 * @param resultValue
	 * @return 가장앞에 숫자가 0이면 제거
	 */
	public static String searchPhoneNo(String str)
	{
		String resultValue = "";
		
		if(str == null)
			return "";
		
		if(str == "")
			return "";
		
		resultValue = onlyNum(str);
		
		if(str.charAt(0) == '0')
			resultValue = str.substring(1, resultValue.length());
		
		return resultValue;
	}

	/**
	 * 변환int를 금액표시단위(,)포함하는 문자열로 변환
	 * 
	 * @param nValue
	 *            변환int
	 * @return 금액표시문자열
	 */
	public static String numberFormat(int nValue)
	{
		return numberFormat((new Integer(nValue)).longValue());
	}

	/**
	 * 변환long을 금액표시단위(,)포함하는 문자열로 변환
	 * 
	 * @param lValue
	 *            변환long
	 * @return 금액표시문자열
	 */
	public static String numberFormat(long lValue)
	{
		return NumberFormat.getInstance().format(lValue);
	}

	/**
	 * 변환double을 금액표시단위(,)포함하는 문자열로 변환
	 * 
	 * @param dValue
	 *            변환double
	 * @return 금액표시문자열
	 */
	public static String numberFormat(double dValue)
	{
		return NumberFormat.getInstance().format(dValue);
	}

	/**
	 * 문자열을 금액표시단위(,)포함하는 문자열로 변환
	 * 
	 * @param szValue
	 *            변환문자열
	 * @return 금액표시문자열
	 */
	public static String numberFormat(String szValue)
	{
		long lValue;
		
		try
		{
			lValue = Long.parseLong(szValue);
		}
		catch(Exception e)
		{
			return szValue;
		}

		int nPos = szValue.indexOf(".");
		
		if(nPos == -1)
			return numberFormat(lValue);
		else
			return numberFormat(Long.parseLong(szValue.substring(0, nPos))) + szValue.substring(nPos, szValue.length());
	}

	/**
	 * 퍼센트 해당X 가 해당Y에 대한 퍼센트반환
	 * 
	 * @param szX
	 *            해당X
	 * @param szY
	 *            해당Y
	 * @return 퍼센트
	 */
	public static int percent(String szX, String szY)
	{
		return percent(nullInt(szX), nullInt(szY));
	}

	/**
	 * 퍼센트 해당X(소수점포함)가 해당Y(소수점포함)에 대한 퍼센트반환
	 * 
	 * @param szX
	 *            해당X(소수점포함)
	 * @param szY
	 *            해당Y(소수점포함)
	 * @return 퍼센트(소수점포함)
	 */
	public static String percentF(String szX, String szY)
	{
		String szValue = String.valueOf(percent(Float.parseFloat(szX), Float.parseFloat(szY)));
		int nPos = szValue.indexOf(".");

		if(szValue.length() > 5)
			szValue = nPos > 0 ? szValue.substring(0, nPos + 3) : szValue;
		else if(szValue.length() < 5)
			szValue = nPos > 0 ? szValue.substring(0, nPos + 2) : szValue;

		return szValue;
	}

	/**
	 * 퍼센트 해당X가 해당Y에 대한 퍼센트반환
	 * 
	 * @param nX
	 *            해당X
	 * @param nY
	 *            해당Y
	 * @return 퍼센트
	 */
	public static int percent(int nX, int nY)
	{
		return (int)percent((float)nX, (float)nY);
	}

	/**
	 * 퍼센트 해당X가 해당Y에 대한 퍼센트반환
	 * 
	 * @param fX
	 *            해당X
	 * @param fY
	 *            해당Y
	 * @return 퍼센트
	 */
	public static float percent(float fX, float fY)
	{
		return (fX / (fX == 0 && fY == 0 ? 1 : fY)) * (float)100;
	}

	/**
	 * 객체를 참, 거짓 형태로 변경
	 * 
	 * @param obj
	 *            해당객체
	 * @return 객체가 참을의미시 true, 객체가 거짓을의미시 false
	 */
	public static boolean is(Object obj)
	{
		return is(nullString(obj));
	}

	/**
	 * 문자열이 참, 거짓 형태로 변경
	 * 
	 * @param szBool
	 *            해당문자열
	 * @return 문자열이 참을의미시 true, 문자열이 거짓을의미시 false
	 */
	public static boolean is(String szBool)
	{
		if(isNull(szBool))
			return false;
		
		return szBool.toLowerCase().equals("true") || szBool.toLowerCase().equals("yes") || szBool.toLowerCase().equals("y") || szBool.toLowerCase().equals("on") || szBool.toLowerCase().equals("1");
	}

	/*--todo : String 관련 */

	/**
	 * 벡터안의 데이터를 구분자 로 구분해서 문자열 표시
	 * 
	 * @param vector
	 *            해당벡터
	 * @param szToken
	 *            구분자
	 * @return 문자열
	 */
	@SuppressWarnings("rawtypes")
	public static String vectorToken(Vector vector, String szToken)
	{
		return vectorToToken(vector, szToken, "'", "''");
	}

	/**
	 * 벡터안의 데이터를 구분자 로 구분해서 문자열 표시 데이터에 (')값존재시 변환문자열로 변환
	 * 
	 * @param vector
	 *            해당벡터
	 * @param szToken
	 *            구분자
	 * @param szReplace
	 *            변환문자열
	 * @return 문자열
	 */
	@SuppressWarnings("rawtypes")
	public static String vectorToken(Vector vector, String szToken, String szReplace)
	{
		return vectorToToken(vector, szToken, "'", szReplace);
	}

	/**
	 * 벡터안의 데이터를 구분자 로 구분해서 문자열 표시 데이터에 데이터표식값 존재시 변환문자열로 변환
	 * 
	 * @param vector
	 *            해당벡터
	 * @param szToken
	 *            구분자
	 * @param szWrapper
	 *            데이터표식
	 * @param szReplace
	 *            변환문자열
	 * @return 문자열
	 */
	@SuppressWarnings("rawtypes")
	public static String vectorToToken(Vector vector, String szToken, String szWrapper, String szReplace)
	{ // oracle in query 이용
		if(vector == null || vector.size() == 0)
			return null;

		StringBuffer sb = new StringBuffer();
		
		for(int i = 0; i < vector.size(); i++)
		{
			String str = (String)vector.elementAt(i);
		
			if(isNull(str))
				continue;
			
			str = replace(str, szWrapper, szReplace);
			str = szWrapper + str + szWrapper;
			
			if(sb.length() == 0)
				sb.append(str);
			else
			{
				sb.append(szToken);
				sb.append(str);
			}
		}
		
		return isNull(sb) ? null : sb.toString();
	}

	/**
	 * 문자열의 데이터를 구분으로 분리된 배열문자열을 반환
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @param szSep
	 *            구분
	 * @return 배열문자열
	 */
	public static String[] split(String szOrg, String szSep)
	{
		if(isNull(szOrg))
			return null;

		String[] saReturn = new String[indexOfCount(szOrg, szSep) + 1];
		int nNdx = 0, nBegin = 0, nEnd;
		
		while(true)
		{
			nEnd = szOrg.indexOf(szSep, nBegin);
			
			if(nEnd != -1)
			{
				if(nBegin == nEnd)
					saReturn[nNdx] = "";
				else
					saReturn[nNdx] = szOrg.substring(nBegin, nEnd);
				
				nBegin = nEnd + szSep.length();
				nNdx++;
			}
			else
				break;
		}
		
		saReturn[saReturn.length - 1] = szOrg.substring(nBegin, szOrg.length());
		
		return saReturn;
	}

	/**
	 * 문자열의 데이터를 구분으로 분리된 데이터가 존재하는 배열문자열을 반환
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @param szSep
	 *            구분
	 * @return 배열문자열
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	public static String[] explode(String szOrg, String szSep)
	{
		StringTokenizer st = new StringTokenizer(szOrg, szSep);
		ArrayList arrayList = new ArrayList();

		while(st.hasMoreElements())
			arrayList.add(st.nextToken());

		String[] saReturn = new String[arrayList.size()];

		for(int i = 0; i < saReturn.length; i++)
			saReturn[i] = (String)arrayList.get(i);
		
		return saReturn;
	}

	/**
	 * 배열문자열에 있는 데이터를 구분으로 합쳐진 문자열반환
	 * 
	 * @param saOrg
	 *            배열문자열
	 * @param szSep
	 *            구분
	 * @return 합쳐진문자열
	 */
	public static String implode(String[] saOrg, String szSep)
	{
		String szReturn = "";
		int nLen = saOrg.length, nEndPos = saOrg.length - 2;

		for(int i = 0; i < nLen; i++)
		{
			if(i > nEndPos)
				szReturn = szReturn + saOrg[i];
			else
				szReturn = szReturn + saOrg[i] + szSep;
		}
		
		return szReturn;
	}

	public static int indexOfCount(String szOrg, char cSep)
	{
		return indexOfCount(szOrg, String.valueOf(cSep));
	}

	public static int indexOfCount(String szOrg, String szSep)
	{
		int nCnt = 0, nPos;

		nPos = szOrg.indexOf(szSep);
		
		while(nPos != -1)
		{
			nPos = szOrg.indexOf(szSep, nPos + szSep.length());
			nCnt++;
		}
		
		return nCnt;
	}

	public static int indexOfCount(String szOrg, char szSep, int nIndex)
	{
		return indexOfCount(szOrg, String.valueOf(szSep), nIndex);
	}

	public static int indexOfCount(String szOrg, String szSep, int nIndex)
	{
		int nCnt = 0, nPos = 0, nRPos = 0;

		while(true)
		{
			nPos = szOrg.indexOf(szSep, nPos + szSep.length());
			
			if(nIndex == nCnt)
				break;
			
			if(nPos == -1)
			{
				nRPos = szOrg.length() - szSep.length();
				break;
			}
			
			nCnt++;
			nRPos = nPos;
		}
		
		return nRPos + szSep.length();
	}

	public static String replace(StringBuffer sbOrg, String szSep, String szReplace)
	{
		return replace(sbOrg.toString(), szSep, szReplace);
	}

	public static String replace(String szOrg, String szSep, String szReplace)
	{
		if(isNull(szOrg))
			return "";

		int nBegin = 0, nEnd;
		StringBuffer sbReturn = new StringBuffer();

		while((nEnd = szOrg.indexOf(szSep, nBegin)) != -1)
		{
			sbReturn.append(szOrg.substring(nBegin, nEnd));
			sbReturn.append(szReplace);
			nBegin = nEnd + szSep.length();
		}
		
		sbReturn.append(szOrg.substring(nBegin));
		
		return sbReturn.toString();
	}

	@SuppressWarnings("rawtypes")
	public static String replacePattern(String szOrg, String szF, String szT, Map map)
	{
		StringBuffer sb = new StringBuffer();
		int nPos;
		
		if(map == null)
			map = new HashMap();

		for(;;)
		{
			nPos = szOrg.indexOf(szF);
			
			if(nPos == -1)
			{
				sb.append(szOrg);
				break;
			}
			
			sb.append(szOrg.substring(0, nPos));
			szOrg = szOrg.substring(nPos + szF.length());
			nPos = szOrg.indexOf(szT);
		
			if(nPos == -1)
				break;
			
			String szKey = szOrg.substring(0, nPos);
			String szValue = nullString((String)map.get(szKey), "");
			sb.append(szValue);
			szOrg = szOrg.substring(nPos + szT.length());
		}
		
		return sb.toString();
	}

	public static String replaceL(String szOrg, String szSep)
	{
		return replaceL(szOrg, szSep, "");
	}

	public static String replaceL(String szOrg, String szSep, String szReplace)
	{
		if(isNull(szOrg))
			return "";

		int nPatternLen = szSep.length();
		
		if(szOrg.length() < nPatternLen)
			return szOrg;

		while(szOrg.substring(0, nPatternLen).equals(szSep))
		{
			szOrg = szReplace + szOrg.substring(nPatternLen);
			
			if(szOrg.length() < nPatternLen)
				break;
		}
		
		return szOrg;
	}

	public static String replaceR(String szOrg, String szSep)
	{
		return replaceR(szOrg, szSep, "");
	}

	public static String replaceR(String szOrg, String szSep, String szReplace)
	{
		if(isNull(szOrg))
			return "";

		int nPatternLen = szSep.length();
		
		if(szOrg.length() < nPatternLen)
			return szOrg;

		while(szOrg.substring(szOrg.length() - nPatternLen).equals(szSep))
		{
			szOrg = szOrg.substring(0, szOrg.length() - nPatternLen) + szReplace;
			
			if(szOrg.length() < nPatternLen)
				break;
		}
		
		return szOrg;
	}

	public static String replaceLR(String szOrg, String szSep)
	{
		return replaceLR(nullString(szOrg), szSep, "");
	}

	public static String replaceLR(String szOrg, String szSep, String szReplace)
	{
		return replaceR(replaceL(nullString(szOrg).trim(), szSep, szReplace), szSep, szReplace);
	}

	/**
	 * 문자열을 euc-kr로 변환
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @return 변환된문자열
	 */
	public static String toKOR(String szOrg)
	{
		if(isNull(szOrg))
			return szOrg;

		try
		{
			// return new String(szOrg.getBytes("8859_1"), "euc-kr"); // 톰켓에서 사용
			return new String(szOrg.getBytes("KSC5601"), "euc-kr"); // jeus에서 사용
		}
		catch(Exception e)
		{
			return szOrg;
		}
	}

	/**
	 * 문자열을 8859-1로 변환
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @return 변환된문자열
	 */
	public static String toENG(String szOrg)
	{
		if(isNull(szOrg))
			return szOrg;

		try
		{
			return new String(szOrg.getBytes("euc-kr"), "8859_1");
		}
		catch(Exception e)
		{
			return szOrg;
		}
	}

	// Java에서 저장 할 데이터를 MySQL에서 사용할 수 있는 Latin1로 변환
	public static String toLatin1(String str) throws UnsupportedEncodingException
	{
		return new String(str.getBytes(), "ISO-8859-1");
	}

	// MySQL에서 불러온 데이터를 Java에서 사용할 수 있는 Unicode로 변환
	public static String toUnicode(String str) throws UnsupportedEncodingException
	{
		return new String(str.getBytes("ISO-8859-1"));
	}

	/**
	 * 문자열을 길이만큼 자른후 추가문자열을 붙임
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @param nLen
	 *            길이
	 * @param szAppend
	 *            추가문자열
	 * @return 제어문자열
	 */
	public static String substrByte(String szOrg, int nLen, String szAppend)
	{
		if(isNull(szOrg))
			return szOrg;

		String szReturn = szOrg;
		int nBegin = 0, nEnd = 0;
		char cTemp;

		try
		{
			if(szReturn.getBytes("euc-kr").length > nLen)
			{
				while(nEnd + 1 < nLen)
				{
					cTemp = szReturn.charAt(nBegin);
					nEnd++;
					nBegin++;
					
					if(cTemp > 127)
						nEnd++; // 한글 문자
				}
				
				szReturn = szReturn.substring(0, nBegin) + szAppend;
			}
		}
		catch(Exception e)
		{
			return "";
		}
		
		return szReturn;
	}

	/**
	 * 문자열이 null 인지 체크
	 * 
	 * @param str
	 *            다상문자열
	 * @return true 해당문자열이 null ,false 해당문자열이 null이 아님.
	 */
	public static boolean isNull(String str)
	{
		if(str == null)
			return true;
		
		return str.trim().equals("") || str.trim().equalsIgnoreCase("null");
	}

	/**
	 * 객체가 null 인지 체크
	 * 
	 * @param obj
	 *            대상객체
	 * @return true 해당객체가 null ,false 해당객체가 null이 아님.
	 */
	public static boolean isNull(Object obj)
	{
		if(obj == null)
			return true;
		
		if(obj instanceof String)
			return isNull((String)obj);
		
		return false;
	}

	/**
	 * 객체를 사용할수있는 문자열로 반환
	 * 
	 * @param obj
	 *            해당객체
	 * @return 문자열
	 */
	public static String nullString(Object obj)
	{
		return isNull(obj) ? "" : (obj instanceof String) ? (String)obj : obj.toString();
	}

	/**
	 * 문자열을 사용할수있는 문자열로 반환
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @return 문자열
	 */
	public static String nullString(String szOrg)
	{
		return isNull(szOrg) ? "" : szOrg;
	}

	/**
	 * 객체를 사용할수있는 int로 반환
	 * 
	 * @param obj
	 *            해당객체
	 * @return 해당int, null일경우 0의 int 반환
	 */
	public static int nullInt(Object obj)
	{
		try
		{
			return Integer.parseInt(nullString(obj, "0"));
		}
		catch(Exception e)
		{
			return 0;
		}
	}

	/**
	 * 객체를 사용할수있는 double로 반환
	 * 
	 * @param obj
	 *            해당객체
	 * @return 해당double, null일경우 0의 double 반환
	 */
	public static double nullDouble(Object obj)
	{
		try
		{
			return Double.parseDouble(nullString(obj, "0"));
		}
		catch(Exception e)
		{
			return 0;
		}
	}

	/**
	 * 객체가 존재하지 않을경우 변환문자열 로 반환
	 * 
	 * @param obj
	 *            해당객체
	 * @param szReplace
	 *            변환문자열
	 * @return 해당객체가 있을경우 해당객체문자열, 해당객체가 없을경우 반환문자열
	 */
	public static String nullString(Object obj, String szReplace)
	{
		return isNull(obj) ? szReplace : obj.toString();
	}

	/**
	 * 문자열이 존재하지 않을경우 변환문자열 로 반환
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @param szReplace
	 *            반환문자열
	 * @return 해당문자열이 있을경우 해당문자열, 해당문자열이 없을경우 반환문자열
	 */
	public static String nullString(String szOrg, String szReplace)
	{
		return isNull(szOrg) ? szReplace : szOrg;
	}

	/**
	 * 객체가 존재하지 않을경우 반환int로 반환
	 * 
	 * @param obj
	 *            해당객체
	 * @param nReplace
	 *            반환int
	 * @return 해당객체가 있을경우 해당객체int, 해당객체가 없을경우 반환int
	 */
	public static int nullInt(Object obj, int nReplace)
	{
		return isNull(obj) ? nReplace : nullInt(obj);
	}

	/**
	 * 객체가 존재하지 않을경우 반환double로 반환
	 * 
	 * @param obj
	 *            해당객체
	 * @param dReplace
	 *            반환double
	 * @return 해당객체가 있을경우 해당객체double, 해당객체가 없을경우 반환double
	 */
	public static double nullDouble(Object obj, double dReplace)
	{
		return isNull(obj) ? dReplace : nullDouble(obj);
	}

	/**
	 * 해당int에 대한 길이를 표시길이만큼 짤르며, 부족한부분은 0으로 채움
	 * 
	 * @param nOrg
	 *            해당int
	 * @param nLen
	 *            표시길이
	 * @return 제어된문자열
	 */
	public static String lpadNumber(int nOrg, int nLen)
	{
		return lpadNumber(Integer.toString(nOrg), nLen);
	}

	/**
	 * 문자열에 대한 길이를 표시길이만큼 짤르며, 부족한부분은 0으로 채움
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @param nLen
	 *            표시길이
	 * @return 제어된문자열
	 */
	public static String lpadNumber(String szOrg, int nLen)
	{
		return lpadString(szOrg, nLen, "0");
	}

	/**
	 * 해당int에 대한 길이를 표시길이만큼 짤르며, 부족한부분은 변환문자열으로 채움
	 * 
	 * @param szOrg
	 *            해당int
	 * @param nLen
	 *            표시길이
	 * @param szReplace
	 *            반환문자열
	 * @return 제어문자열
	 */
	public static String lpadString(int szOrg, int nLen, String szReplace)
	{
		return lpadString(Integer.toString(szOrg), nLen, szReplace);
	}

	/**
	 * 문자열에 대한 길이를 표시길이만큼 짤르며, 부족한부분은 변환문자열으로 채움
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @param nLen
	 *            표시길이
	 * @param szReplace
	 *            변환문자열
	 * @return 제어문자열
	 */
	public static String lpadString(String szOrg, int nLen, String szReplace)
	{
		if(szOrg.length() == nLen)
			return szOrg;
		
		if(nLen < szOrg.length())
			return szOrg.substring(szOrg.length() - nLen, szOrg.length());
		
		nLen = nLen - szOrg.length();
		
		for(int i = 0; i < nLen; i++)
			szOrg = szReplace + szOrg;
		
		return szOrg;
	}

	/**
	 * 문자열에 대한 길이를 표시길이만큼 자르며 Dot(.)을 붙여줌
	 * 
	 * @param szOrg
	 *            해당문자열
	 * @param nLen
	 *            표시길이
	 * @param szReplace
	 *            변환문자열
	 * @return 제어문자열
	 */
	public static String lpadStringDot(String szOrg, int nLen)
	{
		if(szOrg.length() == nLen)
			return szOrg;
		
		if(nLen < szOrg.length())
			return szOrg.substring(0, nLen) + "...";
		
		return szOrg;
	}

	/*--todo : IO 관련 */
	public static synchronized String mkdirs(String szPath)
	{
		return mkdirs(szPath, false);
	}

	public static synchronized String mkdirs(String szPath, boolean bTailFile)
	{
		String[] saPath = explode(replace(szPath, "\\", "/"), "/");
		String szNewPath = "";
		int nLoop = bTailFile ? saPath.length - 1 : saPath.length;
		File f;

		for(int i = 0; i < nLoop; i++)
		{
			szNewPath += FS + saPath[i];
			f = new File(szNewPath);
			
			if(!f.isDirectory())
				f.mkdir();
		}
		
		return szNewPath;
	}

	public static synchronized boolean rm(String szPath)
	{
		return rm(szPath, false);
	}

	public static synchronized boolean rm(String szPath, boolean bDirDelete)
	{
		if(isNull(szPath))
			return false;

		File f = new File(szPath);

		if(f.exists())
		{
			if(f.isFile())
				return f.delete();
			else if(f.isDirectory() && bDirDelete)
			{
				File[] files = f.listFiles();
				
				for(int i = 0; i < files.length; i++)
				{
					if(files[i].isDirectory())
						rm(files[i].getAbsolutePath(), true);
					
					files[i].delete();
				}
				
				return f.delete();
			}
		}
		
		return false;
	}

	// String ofname = 원본파일명
	// String szPath = 파일경로 + 파일명(생성하고자 하는 파일명)
	// return 파일경로 + 파일명(확장자 포함)
	public static String fileOnlyNameExTension(String szPath, String ofname)
	{
		String fPathAndName = fileOnlyName(szPath);
		//String[] saPath = explode(szPath, FS);
		String Extension = "";
		
		if(ofname.lastIndexOf(".") != -1)
			Extension = ofname.substring(ofname.lastIndexOf("."));

		return fPathAndName + Extension;
	}

	// String szPath = 파일경로 + 파일명
	// return 파일경로 + 파일명(확장자 제외)
	public static String fileOnlyName(String szPath)
	{
		String[] saPath = explode(szPath, FS);
		int nLoop = saPath.length - 1;
		String szNewPath = "";

		for(int i = 0; i < nLoop; i++)
			szNewPath += FS + saPath[i];
		
		return szNewPath + FS + fileOnlyName(szNewPath + FS, saPath[saPath.length - 1]);
	}

	public static String fileOnlyName(String szPath, String szFname)
	{
		String[] saFName = explode(szFname, ".");
		int nCnt = 1;

		while(true)
		{
			if(fileExists(szPath + szFname))
			{
				szFname = "";
				
				for(int i = 0; saFName.length > i; i++)
				{
					if(i == saFName.length - 1)
						szFname += ".";
					
					szFname += (i == saFName.length - 2) ? saFName[i] + nCnt : saFName[i];
				}
			}
			else
				break;
			
			nCnt++;
		}
		
		return szFname;
	}

	public static boolean fileExists(String szPath)
	{
		return new File(szPath).exists();
	}

	public static boolean isFile(String szPath)
	{
		return new File(szPath).isFile();
	}

	public static synchronized boolean mv(String szSFile, String szTFile)
	{
		return cp(szSFile, szTFile) && rm(szSFile);
	}

	public static synchronized boolean cp(String szSFile, String szTFile)
	{
		FileInputStream fin = null;
		FileOutputStream fout = null;
		byte buffer[] = new byte[1024];
		int j;

		try
		{
			fin = new FileInputStream(szSFile);
			fout = new FileOutputStream(szTFile);
			
			while((j = fin.read(buffer)) >= 0)
				fout.write(buffer, 0, j);
			
			fin.close();
			fout.close();
			
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
		finally
		{
			if(fin != null)
			{
				try
				{
					fin.close();
				}
				catch(Exception e)
				{
					
				}
			}
			if(fout != null)
			{
				try
				{
					fout.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}
	}

	public static String fileRead(String szPath)
	{
		String szReturn = "", szLine;
		FileInputStream fin = null;
		BufferedReader br = null;

		try
		{
			fin = new FileInputStream(szPath);
			br = new BufferedReader(new InputStreamReader(fin, "euc-kr"));
			
			while((szLine = br.readLine()) != null)
				szReturn += szLine + '\n';
			
			br.close();
			fin.close();
			
			return szReturn.substring(0, szReturn.length() - 1);
		}
		catch(Exception e)
		{
			return "";
		}
		finally
		{
			if(br != null)
			{
				try
				{
					br.close();
				}
				catch(Exception e)
				{
					
				}
			}
			if(fin != null)
			{
				try
				{
					fin.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}
	}

	public static byte[] fileReadBytes(String szPath)
	{
		byte[] bytes;
		FileInputStream fi = null;

		try
		{
			fi = new FileInputStream(szPath);
			bytes = new byte[fi.available()];
			fi.read(bytes);
			fi.close();
			
			return bytes;
		}
		catch(Exception e)
		{
			return new byte[0];
		}
		finally
		{
			if(fi != null)
			{
				try
				{
					fi.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}
	}

	public static boolean fileWrite(String szPath, String szContent)
	{
		return fileWrite(szPath, szContent.getBytes(), false);
	}

	public static boolean fileWrite(String szPath, String szContent, boolean bAppend)
	{
		return fileWrite(szPath, szContent.getBytes(), bAppend);
	}

	public static boolean fileWrite(String szPath, byte[] bytes)
	{
		return fileWrite(szPath, bytes, false);
	}

	public static synchronized boolean fileWrite(String szPath, byte[] bytes, boolean bAppend)
	{
		FileOutputStream fout = null;

		try
		{
			mkdirs(szPath, true);
			fout = new FileOutputStream(szPath, bAppend);
			fout.write(bytes, 0, bytes.length);
			fout.close();
			
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
		finally
		{
			if(fout != null)
			{
				try
				{
					fout.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}
	}

	public static synchronized boolean fileWrite(String szPath, InputStream is)
	{
		FileOutputStream fout = null;
		byte buffer[] = new byte[1024];
		int j;

		try
		{
			mkdirs(szPath, true);
			fout = new FileOutputStream(szPath);
			
			while((j = is.read(buffer)) >= 0)
				fout.write(buffer, 0, j);
			
			is.close();
			fout.close();
			
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
		finally
		{
			if(is != null)
			{
				try
				{
					is.close();
				}
				catch(Exception e)
				{
					
				}
			}
			if(fout != null)
			{
				try
				{
					fout.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}
	}

	public static boolean fileWriteException(String szPath, Exception e)
	{
		return fileWriteException(szPath, e, false);
	}

	public static boolean fileAWriteException(String szPath, Exception e)
	{
		return fileWriteException(szPath, e, true);
	}

	public static synchronized boolean fileWriteException(String szPath, Exception e, boolean bAppend)
	{
		PrintWriter pw = null;

		try
		{
			mkdirs(szPath, true);
			pw = new PrintWriter(new OutputStreamWriter(new FileOutputStream(szPath, bAppend), "euc-kr"), true);
			e.printStackTrace(pw);
			pw.close();
			
			return true;
		}
		catch(Exception ex)
		{
			return false;
		}
		finally
		{
			if(pw != null)
				pw.close();
		}
	}

	/*--todo : Runtime 관련 */
	public static String getHomeDir()
	{
		return System.getProperty("user.home", "/");
	}

	public static String getTempDir()
	{
		return System.getProperty("user.home", "/") + FS + "temp";
	}

	@SuppressWarnings("rawtypes")
	public static Properties getProperty(String szPath)
	{
		FileInputStream fis = null;
		Properties prop = new Properties();

		try
		{
			fis = new FileInputStream(szPath);
			prop.load(fis);
			fis.close();
		}
		catch(Exception e)
		{
			
		}
		finally
		{
			if(fis != null)
			{
				try
				{
					fis.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}

		if(prop.size() > 0)
		{
			String szKey;
			
			for(Enumeration e = prop.keys(); e.hasMoreElements();)
			{
				szKey = (String)e.nextElement();
				prop.setProperty(toKOR(szKey), toKOR(prop.getProperty(szKey)));
			}
		}
		
		return prop;
	}

	public static String getProperty(String szPath, String szElement)
	{
		return getProperty(szPath, szElement, "");
	}

	public static String getProperty(String szPath, String szElement, String szDefault)
	{
		try
		{
			return getProperty(szPath).getProperty(szElement, szDefault);
		}
		catch(Exception e)
		{
			return "";
		}
	}

	public static String[] getPropertyArray(String szPath, String szAtt, String szSeq)
	{
		return getPropertyArray(szPath, szAtt, "", szSeq);
	}

	public static String[] getPropertyArray(String szPath, String szAtt, String szDefault, String szSeq)
	{
		return Util.explode(getProperty(szPath, szAtt, szDefault), szSeq);
	}

	public static String exec(String cmd)
	{
		String szReturn = "";
		Process p = null;
		InputStream is = null;

		try
		{
			p = Runtime.getRuntime().exec(cmd);
			is = p.getInputStream();
			
			while(true)
			{
				try
				{
					p.exitValue();
					szReturn += exec(is);
					break;
				}
				catch(Exception eIn)
				{
					szReturn += exec(is);
				}
			}
			
			p.destroy();
			is.close();
			
			return szReturn;
		}
		catch(Exception e)
		{
			return szReturn;
		}
		finally
		{
			if(p != null)
				p.destroy();
			
			if(is != null)
			{
				try
				{
					is.close();
				}
				catch(Exception e)
				{
					
				}
			}
			
			Runtime.getRuntime().gc();
		}
	}

	private static String exec(InputStream is) throws Exception
	{
		byte bytes[] = new byte[2048];
		String szReturn = "";

		while((is.read(bytes)) > 0)
			szReturn += new String(bytes);

		return szReturn;
	}

	public static int exec(String cmd, String resultFile) throws IOException
	{
		int nReturn = 0;
		FileOutputStream fos = null;
		Process p = null;
		InputStream is = null;

		try
		{
			p = Runtime.getRuntime().exec(cmd);
			is = p.getInputStream();
			fos = new FileOutputStream(resultFile);
			
			while(true)
			{
				try
				{
					p.exitValue();
					nReturn += exec(is, fos);
					break;
				}
				catch(Exception eIn)
				{
					nReturn += exec(is, fos);
				}
			}
			
			fos.close();
			p.destroy();
			is.close();
			
			return nReturn;
		}
		catch(Exception e)
		{
			return nReturn;
		}
		finally
		{
			if(fos != null)
				fos.close();
			
			if(p != null)
				p.destroy();
			
			if(is != null)
			{
				try
				{
					is.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}
	}

	private static int exec(InputStream is, FileOutputStream fos) throws Exception
	{
		int nReturn = 0;
		int nRead;
		byte bytes[] = new byte[2048];

		while((nRead = is.read(bytes)) > 0)
		{
			nReturn += bytes.length;
			fos.write(bytes, 0, nRead);
		}
		
		return nReturn;
	}

	/*--todo : HTTP 관련 */
	@SuppressWarnings("deprecation")
	public static void setCookie(HttpServletResponse response, String szName, String szValue)
	{
		szValue = java.net.URLEncoder.encode(szValue);
		Cookie cookie = new Cookie(szName, szValue);
		cookie.setMaxAge(60 * 60 * 24);
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	public static String getCookie(HttpServletRequest request, String szName)
	{
		return getCookie(request, szName, true);
	}

	public static String getCookie(HttpServletRequest request, String szName, boolean bDecoder)
	{
		Cookie[] cookies = request.getCookies();
		
		if(cookies == null)
			return "";

		for(int i = 0; i < cookies.length; i++)
		{
			Cookie cookie = cookies[i];
			
			try
			{
				if(cookie.getName().equalsIgnoreCase(szName))
					return bDecoder ? java.net.URLDecoder.decode(cookie.getValue(), "MS949") : cookie.getValue();
			}
			catch(Exception e)
			{
				return getUTF(cookie.getValue());
			}
		}
		
		return "";
	}

	public static String getUTF(String szOrg)
	{
		StringBuffer sb = new StringBuffer();

		for(int i = 0; i < szOrg.length(); i++)
		{
			char c = szOrg.charAt(i), c1 = szOrg.charAt(i + 1);
			
			try
			{
				if(c == '%' && c1 == 'u')
				{ // utf
					sb.append((char)Integer.parseInt(szOrg.substring(i + 2, i + 6), 16));
					i += 5;
				}
				else if(c == '%')
				{ // euc
					sb.append((char)Integer.parseInt(szOrg.substring(i + 1, i + 3), 16));
					i += 2;
				}
				else
					sb.append(c);
			}
			catch(Exception e)
			{
				sb.append("×");
			}
		}
		
		return sb.toString();
	}

	/*--todo : 기타 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	public static void alignExample(Vector vector)
	{
		Object o;
		for(int i = 0; i < vector.size(); i++)
		{
			for(int j = i + 1; j < vector.size(); j++)
			{
				int n1 = Util.nullInt(vector.get(i));
				int n2 = Util.nullInt(vector.get(j));
				
				if(n1 > n2)
				{
					o = vector.get(j);
					vector.remove(j);
					vector.add(i, o);
				}
			}
		}
	}

	/**
	 * 문자열을 주어진 길이(<code>size</code>)만큼 자르고 뒤에 "..."을 붙여 반환한다.
	 *
	 * @param str
	 *            문자열
	 * @return 변환된 문자열
	 * @since PDK1.1 (Patch #2)
	 */
	public static String head(String str, int size)
	{
		if(str == null || str.equals(""))
			return "";

		size *= 2;

		int len = str.length();
		int cnt = 0, index = 0;
		char temp = '0';

		while(index < len && cnt < size)
		{
			temp = str.charAt(index++);
			
			if(((91 <= temp && temp <= 126) || (33 <= temp && temp <= 57)) && temp != 92 && !(35 <= temp && temp <= 38))
				cnt++;
			else
				cnt += 2;
		}

		if(index < len && size >= cnt)
			str = str.substring(0, index) + "...";
		else if(index < len && size < cnt)
			str = str.substring(0, index - 1) + "...";

		return str;
		// return TextUtility.head(str, size);
	}

	/**
	 * 보안관련 태그 제거
	 */
	public static String convertToSecureHtml(String str)
	{
		if(str == null || str.equals(""))
			return "";

		String ret = str;

		// < -> &lt;
		ret = ret.replace("<", "&lt;");
		// > -> &gt;
		ret = ret.replace(">", "&gt;");
		// "\t" -> &nbsp;&nbsp;&nbsp;
		ret = ret.replace("\t", "&nbsp;&nbsp;&nbsp;");
		// "\"" -> &#34;
		ret = ret.replace("\"", "&#34;");

		ret = ret.trim();
		
		return ret;
	}

	/**
	 *
	 * 주어진 문자열을 브라우저에서 출력 가능한 문자열로 변환한다.
	 *
	 * <ul type="square">
	 * <li>&lt; -> &amp;lt;</li>
	 * <li>&gt; -> &amp;gt;</li>
	 * <li>"\n"/"\r\n" -> &lt;br&gt;</li>
	 * <li>"\t" -> &amp;nbsp;&amp;nbsp;&amp;nbsp;.</li>
	 * </ul>
	 *
	 * @param str
	 *            문자열
	 * @return 변환된 문자열
	 */
	public static String convertToPrintableHtml(String str)
	{
		if(str == null || str.equals(""))
			return "";

		String ret = str;

		// < -> &lt;
		ret = ret.replace("<", "&lt;");
		
		// > -> &gt;
		ret = ret.replace(">", "&gt;");
		
		// "\t" -> &nbsp;&nbsp;&nbsp;
		ret = ret.replace("\t", "&nbsp;&nbsp;&nbsp;");
		
		// "\"" -> &#34;
		ret = ret.replace("\"", "&#34;");

		ret = convertToEnterKey(ret);
		ret = ret.trim();
		
		return ret;
	}

	public static String convertToEnterKey(String str)
	{
		if(str == null || str.equals(""))
			return "";

		String ret = str;

		// "\n" -> <br>
		ret = ret.replace("\n", "<br>");
		
		// "\r\n" -> <br>
		ret = ret.replace("\r\n", "<br>");
		
		return ret;
	}

	/**
	 *
	 * 주어진 문자열을 input 이나 textarea에서 출력 가능한 문자열로 변환한다.
	 *
	 * <ul type="square">
	 * <li>&lt; -> &amp;lt;</li>
	 * <li>&gt; -> &amp;gt;</li>
	 * </ul>
	 *
	 * @param str
	 *            문자열
	 * @return 변환된 문자열
	 */
	public static String convertToText(String str)
	{
		if(str == null || str.equals(""))
			return "";
		
		String ret = str;
		
		// < -> &lt;
		ret = ret.replace("<", "&lt;");
		
		// > -> &gt;
		ret = ret.replace(">", "&gt;");
		
		// " 변환처리.처리
		ret = ret.replace("\"", "&quot;");

		return ret;
	}

	/**
	 *
	 * 주어진 문자열을 html은 유효하나 script tag만 변환한다.
	 *
	 * <ul type="square">
	 * <li>&lt; -> &amp;lt;</li>
	 * <li>&gt; -> &amp;gt;</li>
	 * </ul>
	 *
	 * @param str
	 *            문자열
	 * @return 변환된 문자열
	 */
	public static String convertToScript(String str)
	{
		if(str == null || str.equals(""))
			return "";
		
		String ret = str;
		
		// < -> &lt;
		ret = ret.replace("<SCRIPT", "&lt;script!");
		
		// > -> &gt;
		ret = ret.replace("</SCRIPT", "&lt;/script!");
		
		return ret;
	}

	/**
	 * 
	 * 쿠키를 받아서 해당 id의 value로 반환한다.
	 * 
	 * @param cookies
	 * @param value
	 * 
	 * @return 해당 키의 값
	 * 
	 */
	public String convertToCookie(Cookie[] cookies, String value)
	{
		String ret = "";
		
		if(cookies != null && value != null)
		{
			for(int i = 0; i < cookies.length; i++)
			{
				if(cookies[i].getName().equals(value))
				{
					ret = cookies[i].getValue();
					break;
				}
			}
		}
		
		return ret;
	}

	public static String removeTag(String s)
	{
		return s.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

	/**
	 * request 에서 파라미터 추출 후 map에 담는다.
	 * 
	 * @param req
	 * @return HashMap<String, Object>
	 */
	@SuppressWarnings("unchecked")
	public static HashMap<String, Object> paramsToMap(HttpServletRequest req)
	{
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		//Enumeration<Object> e = req.getParameterNames();
		Enumeration<String> e = req.getParameterNames();

		if(e == null)
			return null;

		while(e.hasMoreElements())
		{
			String names = (String)e.nextElement();
			params.put(names, req.getParameter(names));
		}

		return params;
	}

	/**
	 * request 에서 파라미터 추출 후 map에 담는다.
	 * 
	 * @param req
	 * @return HashMap<String, Object>
	 */
	@SuppressWarnings("unchecked")
	//public static HashMap<String, Object> paramsToMap(MultipartHttpServletRequest req)
	public static Map<String, Object> paramsToMap(MultipartHttpServletRequest req)
	{
		//HashMap<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> params = new HashMap<String, Object>();

		//Enumeration<Object> e = req.getParameterNames();
		Enumeration<String> e = req.getParameterNames();

		while(e.hasMoreElements())
		{
			String names = (String)e.nextElement();
			params.put(names, req.getParameter(names));
		}

		return params;
	}

	public static String SHA256(Object str)
	{
		String SHA = "";
		String getStr = Util.nullString(str);
		
		try
		{
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(getStr.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			
			for(int i = 0; i < byteData.length; i++)
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			
			SHA = sb.toString();
		}
		catch(NoSuchAlgorithmException e)
		{
			e.printStackTrace();
			SHA = null;
		}
		
		return SHA;
	}

	public static long diffOfDate(String begin, String end) throws Exception
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);

		Date beginDate = formatter.parse(begin);
		Date endDate = formatter.parse(end);

		long diff = endDate.getTime() - beginDate.getTime();
		long diffDays = diff / (24 * 60 * 60 * 1000);

		return diffDays;
	}

	public static String removeXSS(String value)
	{
		value = value.replaceAll("&", "&amp;");
		value = value.replaceAll("<", "&lt;");
		value = value.replaceAll(">", "&gt;");
		value = value.replaceAll("</", "&lt;");
		value = value.replaceAll("%00", null);
		value = value.replaceAll("\"", "&#34;");
		value = value.replaceAll("\'", "&#39;");
		value = value.replaceAll("%", "&#37;");
		value = value.replaceAll("../", "");
		value = value.replaceAll("..\\\\", "");
		value = value.replaceAll("./", "");
		value = value.replaceAll("%2F", "");

		return value;
	}

	public static String setXss(Object obj)
	{
		String ret = nullString(obj);

		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;/form");
		ret = ret.replaceAll("\n", "<br/>");
		
		return ret;
	}

	/**
	 * 
	 * @param checkObject
	 *            , type
	 * @param String
	 *            object , Int
	 * @return boolean
	 */
	public static boolean checkForm(Object value, int type)
	{
		boolean result = true;
		String toValStr = Util.nullString(value);
		List<String> testValue = new ArrayList<String>();

		switch(type)
		{
			case 1: // 매개변수로 들어온 값이 아이디
				testValue.add("^[0-9a-zA-Z]*$"); // 영문 숫자만
				
				if(toValStr.length() < 5 || toValStr.length() > 50)
					result = false; // 아이디가 10자리 이하 50자리 이상이면 정규식 패스(검사작업 취소)
				
				if(toValStr.matches("^[0-9]*$"))
					result = false;
				
				if(toValStr.matches("^[a-zA-Z]*$"))
					result = false;
				
				break;
			case 2: // 매개변수로 들어온 값이 비밀번호
				testValue.add("^[0-9a-zA-Z]*$"); // 영문 숫자만
				
				if(toValStr.length() < 10 || toValStr.length() > 50)
					result = false; // 아이디가 10자리 이하 50자리 이상이면 정규식 패스(검사작업 취소)
				
				if(toValStr.matches("^[0-9]*$"))
					result = false;
				
				if(toValStr.matches("^[a-zA-Z]*$"))
					result = false;
				
				break;
			case 3: // 매개변수로 들어온 값이 회사명
				break;
			case 4: // 매개변수로 들어온 값이 사용자명
				break;
			case 5: // 매개변수로 들어온 값이 부서아이디
				break;
			case 6: // 매개변수로 들어온 값이 그룹아이디
				break;
			case 7: // 매개변수로 들어온 값이 LOGIN_YN
				break;
			case 8: // 매개변수로 들어온 값이 INT_NO
				break;
			default:
				result = false;
				break;
		}
		
		if(result)
		{
			for(int i = 0; i < testValue.size(); i++)
			{
				if(!toValStr.matches(testValue.get(i)))
					result = false;
			}
		}

		return result;
	}

}
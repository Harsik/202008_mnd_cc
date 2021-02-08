<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="xecure.crypto.jni.XecureLib" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Calendar" %>

<%
	String	[]nameList = {
						"자신", "남편", "부인", "딸램", "아들", "막내", "장남", "장녀",
						"차녀", "차남", "엄마", "아빠", "형님", "언니", "누나", "오빠", "동생",
						"할아버지", "할머니", "큰아버지", "큰어머니", "삼촌", "사촌",
						"매부", "매재", "매형", "제수", "제부", "고모", "고모부",
						"이모", "이모부", "아저씨", "조카"};

	java.util.Random	aRandom = null;

	aRandom = (java.util.Random)application.getAttribute ("xwup.ibs.random");
	if (aRandom == null)
	{
		aRandom = new java.util.Random ();
		application.setAttribute ("xwup.ibs.random", aRandom);
	}
%>
<%
	String commandType = request.getParameter("commandType");
	String operaterId = "internet";
	String user_policy_type = request.getParameter("user_policy_type") ; 
	String company_name = request.getParameter("company_name");
	String user_name = request.getParameter("user_name");


	if (commandType != null && commandType.equalsIgnoreCase ("update"))
	{
		boolean isError = false;
		if (user_policy_type == null)
			isError = true;

		if (user_name == null)
			isError = true;

		if (isError)
		{
%>
({"code":"-1",
"reason":"no policy or user_name or ssn",
"moreinformation":""})
<%
			return;
		}
	
	}

	if (user_policy_type == null)
	{
		user_policy_type = "104";
	}

	if (user_name == null || user_name.length () == 0)
	{
		user_name = nameList [aRandom.nextInt (nameList.length)];
	}
	else
		user_name = new String(user_name.getBytes("iso8859-1"), "utf-8");

	String euser_name = request.getParameter("euser_name");
	String user_id = request.getParameter("user_id");
	String ssn = request.getParameter("ssn");

	String policy_type ;
	String user_type;

	user_type = user_policy_type.substring(0, 1);

	if( user_type.equals("1") )
	{
		if (ssn == null || ssn.length () == 0)
		{
			StringBuffer		aBuffer = new StringBuffer ();
			Calendar			aCalendar = Calendar.getInstance ();
			String				aSSNTail = null;
			aSSNTail = String.valueOf (aRandom.nextInt (2999999));

			aBuffer.append (String.valueOf (aCalendar.get(Calendar.YEAR)).substring (2));

			if (aCalendar.get(Calendar.MONTH) < 10)
				aBuffer.append ("0");
			aBuffer.append (String.valueOf (aCalendar.get(Calendar.MONTH)));

			if (aCalendar.get(Calendar.DAY_OF_MONTH) < 10)
				aBuffer.append ("0");
			aBuffer.append (String.valueOf (aCalendar.get(Calendar.DAY_OF_MONTH)));


			if (aSSNTail.length () < 7)
			{
				for (int aIter = 0; aIter < 7 - aSSNTail.length (); ++aIter)
				{
					aBuffer.append ("0");
				}
			}
			aBuffer.append (aSSNTail);

			ssn = aBuffer.toString ();

		}
		if (user_id == null)
			user_id = ssn;

		policy_type = user_policy_type.substring(1,3);
		user_id = policy_type + ssn.charAt(5) + user_id;
	}
	else if ( user_type.equals("2") )
	{
		if (ssn == null || ssn.length () == 0)
		{
			StringBuffer		aBuffer = new StringBuffer ();
			String				aSSNTail = null;
			aSSNTail = "2" + String.valueOf (aRandom.nextInt (999999999));

			if (aSSNTail.length () < 10)
			{
				for (int aIter = 0; aIter < 10 - aSSNTail.length (); ++aIter)
				{
					aBuffer.append ("0");
				}
			}
			aBuffer.append (aSSNTail);

			ssn = aBuffer.toString ();
		}

		if (company_name == null)
			company_name = ssn;
		if (euser_name == null)
			euser_name = ssn;
		if (user_id == null)
			user_id = ssn;

		policy_type = user_policy_type.substring(1,3);
		user_id = policy_type + ssn.charAt(8) + user_id;
	}
	else
		policy_type = user_policy_type.substring(1,2);

%>
<%

	String email = "dont email me";
	String cell_phone = "dont call me";
	String fax = "dont fax me";
	String zipcode = "127-311";
	String address = "dogok dong house";
	String phone = "02-526-8000";
	String czipcode = "127-311";
	String caddress = "dogok dong";
	String cphone = "02-526-8000";

	int	ra_result = 0;
	
	XecureConfig xconf = new XecureConfig ();
	PublicRA sfra = new PublicRA (xconf);
	XecureLib jni = new XecureLib (xconf);

	String ip = null;
	int port = -1;
	int protocol = -1;

	String targetRA = request.getParameter ("targetRA");

	ip = xconf.getRaHost ();
	port = xconf.getRaPort ();
	protocol = xconf.getRaProtocol ();

	if (targetRA != null)
	{
		if (targetRA.equalsIgnoreCase ("1024")) /* 1024 PublicRA Information */
		{
			ip = "192.168.0.43";
			port = 25610;
			protocol = 1;
		}
		else if (targetRA.equalsIgnoreCase ("2048")) /* 2048 PublicRA Information */
		{
			ip = "192.168.60.109";
			port = 15679;
			protocol = 1;
		}
	}

	if (commandType == null || commandType.equalsIgnoreCase ("new"))
	{
	ra_result = jni.registerNewUser (ip.getBytes (),
									 port,
									 protocol,
									 operaterId.getBytes (),
									 user_type.getBytes (),
									 (company_name == null) ? null : company_name.getBytes (),
									 user_name.getBytes (),
									 (euser_name == null) ? null : euser_name.getBytes (),
									 user_id.getBytes (),
									 ssn.getBytes (),
									 policy_type.getBytes (),
									 email.getBytes (),
									 cell_phone.getBytes (),
									 fax.getBytes (),
									 zipcode.getBytes (),
									 address.getBytes (),
									 phone.getBytes (),
									 czipcode.getBytes (),
									 caddress.getBytes (),
									 cphone.getBytes () );
	}
	else if (commandType.equalsIgnoreCase ("rereg"))
	{
	ra_result = jni.registerRenewUser (ip.getBytes (),
									 port,
									 protocol,
									 operaterId.getBytes (),
									 user_type.getBytes (),
									 (company_name == null) ? null : company_name.getBytes (),
									 user_name.getBytes (),
									 (euser_name == null) ? null : euser_name.getBytes (),
									 user_id.getBytes (),
									 ssn.getBytes (),
									 policy_type.getBytes (),
									 email.getBytes (),
									 cell_phone.getBytes (),
									 fax.getBytes (),
									 zipcode.getBytes (),
									 address.getBytes (),
									 phone.getBytes (),
									 czipcode.getBytes (),
									 caddress.getBytes (),
									 cphone.getBytes () );
	}
	else if (commandType.equalsIgnoreCase ("update"))
	{
	ra_result = jni.registerUpdateUser (ip.getBytes (),
									 port,
									 protocol,
									 operaterId.getBytes (),
									 user_type.getBytes (),
									 (company_name == null) ? null : company_name.getBytes (),
									 user_name.getBytes (),
									 (euser_name == null) ? null : euser_name.getBytes (),
									 user_id.getBytes (),
									 ssn.getBytes (),
									 policy_type.getBytes (),
									 email.getBytes (),
									 cell_phone.getBytes (),
									 fax.getBytes (),
									 zipcode.getBytes (),
									 address.getBytes (),
									 phone.getBytes (),
									 czipcode.getBytes (),
									 caddress.getBytes (),
									 cphone.getBytes () );
	}


%> 
({"ssn":"<%=ssn%>",
"name":"<%=user_name%>",
"code":"<%=ra_result%>",
<%
	if ( ra_result == 0 ) {
%> 
"regdate":"<%=new String(jni.reguser_RegDate, "cp949")%>",
"regserial":"<%=new String(jni.reguser_RegSerial, "cp949")%>",
"userid":"<%=new String(jni.reguser_UserId, "cp949")%>",
"refcode":"<%=(jni.reguser_RefCode == null) ? "" : new String(jni.reguser_RefCode, "cp949")%>",
"authcode":"<%=(jni.reguser_AuthCode == null) ? "" : new String(jni.reguser_AuthCode, "cp949")%>",
"policytype":"<%=new String(jni.reguser_PolicyType, "cp949")%>",
"roothash":"<%=new String(jni.reguser_RootHash, "cp949")%>"
<%	}
	else
	{
%>
"reason":"<%=new String (jni.errMsg)%>",
"moreinformation":"RA IP:<%=ip + ", RA Port:" + port%>"
<%	}
%>
})

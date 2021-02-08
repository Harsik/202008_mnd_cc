<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Calendar" %>

<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%
	String	[]nameList = {"자신", "남편", "부인", "딸램", "아들", "막내", "장남", "장녀",
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
	String targetRA = request.getParameter ("targetRA");
	String operaterId = "internet";
	String user_policy_type = request.getParameter("user_policy_type") ; 
	String company_name = request.getParameter("company_name");
	String user_name = request.getParameter("user_name");
	String cert_type = request.getParameter("cert_type");
	String cert_class = request.getParameter("cert_class");
	String corp_code = request.getParameter("corp_code");
	
	String org_code = request.getParameter("org_code");
	String orgid_code = request.getParameter("orgid_code");

	String position = request.getParameter("position");
	String foreigner_id_num = request.getParameter("foreigner_id_num");
	String reg_master_num = request.getParameter("reg_master_num");
	String executive_num = request.getParameter("executive_num");
	String publicOrPrivate = request.getParameter("user_public_or_private");
	
	String ext3 = request.getParameter("ext3");

	int	ca_result = 0;
	XecureConfig xconf = new XecureConfig ();
	XecureCA ca_client = null;
	String ip = null;
	int port = -1;
	int caType = -1;
	int caRMPType = -1;
%>

<%
	ip = xconf.getXecureCaHost ();
	port = xconf.getXecureCaPort ();

	if (targetRA != null)
	{
		if (targetRA.equalsIgnoreCase ("1024")) /* 1024 XecureCA Information */
		{
			ip = "192.168.0.26";
			port = 29210;
			caType = 2;
			caRMPType = 2;
		}
		else if (targetRA.equalsIgnoreCase ("2048")) /* 2048 XecureCA Information */
		{
			if (publicOrPrivate.equals("yessignmpki")) {
				ip = "192.168.0.43";
				port = 5301;
				caType = 2;
				caRMPType = 1;		
			} else {
				ip = "192.168.0.4";
				port = 21200;
				caType = 2;
				caRMPType = 2;
			}
		}
	}

	ca_client = new XecureCA (xconf, ip, port, caType, caRMPType);


	if (org_code == null)
		org_code = "";
	if (orgid_code == null)
		orgid_code = "";
	if (corp_code == null)
		corp_code = "0000";
	if (cert_class == null)
		cert_class = "0000";
	if (cert_type == null)
		cert_type = "0000";


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
({"code":"-1"
"reason":"no policy or user_name or ssn"
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
		if (targetRA.equalsIgnoreCase("2048"))
		{
			while (user_name.length() < 4)
			{
				user_name = nameList [aRandom.nextInt (nameList.length)];
			}
		}
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

	String email = "dont email me";
	String cell_phone = "dont call me";
	String fax = "dont fax me";
	String zipcode = "127-311";
	String address = "dogok dong house";
	String phone = "02-526-8000";
	String czipcode = "127-311";
	String caddress = "dogok dong";
	String cphone = "02-526-8000";


%> 
({"ssn":"<%=ssn%>",
"name":"<%=user_name%>",
<%

	if (commandType == null || commandType.equalsIgnoreCase ("new"))
	{
		ca_result = ca_client.registerNewUser (operaterId,
											   user_type,
											   company_name,
											   user_name,
											   user_id,
											   ssn,
											   policy_type,
											   email,
											   cell_phone,
											   fax,
											   zipcode,
											   address,
											   phone,
											   czipcode,
											   caddress,
											   cphone,
											   cert_type,
											   cert_class,
											   corp_code,
											   org_code,
											   orgid_code,
											   position,
											   foreigner_id_num,
											   reg_master_num,
											   executive_num,
											   ext3);
	}
	else if (commandType.equalsIgnoreCase ("rereg"))
	{
		ca_result = ca_client.registerReNewUser (operaterId,
												 user_type,
												 company_name,
												 user_name,
												 user_id,
												 ssn,
												 policy_type,
												 email,
												 cell_phone,
												 fax,
												 zipcode,
												 address,
												 phone,
												 czipcode,
												 caddress,
												 cphone,
												 cert_type,
												 cert_class,
												 corp_code,
												 org_code,
												 orgid_code,
												 position,
												 foreigner_id_num,
												 reg_master_num,
												 executive_num,
												 ext3,
												 0);
	}
	else if (commandType.equalsIgnoreCase ("update"))
	{
%>
"code":"none",
"reason":"XecureCA does not support registration for UPDATE",
"moreinformation":"CA IP:<%=ip + ", CA Port:" + port%>"
})
<%
		return;

	}
	if ( ca_result == 0 ) {
%> 
"code":"0",
"regdate":"<%=ca_client.getResponseFromRegUser("REGDATE")%>",
"regserial":"<%=ca_client.getResponseFromRegUser("REGSERIAL")%>",
"userid":"<%=ca_client.getResponseFromRegUser("USERID")%>",
"refcode":"<%=ca_client.getResponseFromRegUser("REFCODE")%>",
"authcode":"<%=ca_client.getResponseFromRegUser("AUTHCODE")%>"
<%	}
	else
	{
%>
"code":"<%=ca_client.getLastError()%>",
"reason":"<%=ca_client.getLastErrorMsg()%>",
"moreinformation":"CA IP:<%=ip + ", CA Port:" + port %>"
<%	}
%>
})

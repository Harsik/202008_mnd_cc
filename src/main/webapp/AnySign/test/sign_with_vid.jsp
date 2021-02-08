<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page buffer="16kb"%>
<%@ page import="xecure.servlet.*"%>
<%@ page import="xecure.crypto.*"%>
<%@ page import="java.io.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="cache-control" content="no-cache">
<style type="text/css">
<!--
form			{margin:0px 0px 0px 0px;}
input           { border:1px solid #d3d3d3; margin:2px; padding:1px;}
input.largebtn	{ width: 500px; }
input.mediumbtn	{ width: 300px; }
input.smallbtn	{ width: 150px; }
h1, h2, h3, h4  { margin:0;}
h3              { font-size:13pt; background-color:#EEE;}
.test			{border:1px dashed gray;}
.test td		{font-size: 9pt;color: #333333;background: #EEEEEE;text-align: center;}
.inputtext		{width: 100%;}
.inputbutton	{width: 100%;height: 100%;}
.inputcheck		{width: 14px;height: 14px;}
-->
</style>

<link rel="stylesheet" type="text/css" href="../XecureWeb/css/common.css" />
<script type="text/javascript" src="../xecureweb_up.js"></script>

<script type="text/javascript" src="../touchen/TouchEnKey.js"></script>
<script type="text/javascript" src="../transkey/BigInt.js"></script>
<script type="text/javascript" src="../transkey/Barrett.js"></script>
<script type="text/javascript" src="../transkey/RSA.js"></script>
<script type="text/javascript" src="../transkey/wz_jsgraphics.js"></script>
<script type="text/javascript" src="../transkey/transkey_XC.js"></script>
<script type="text/javascript" src="../transkey/seed.js"></script>
<script type="text/javascript" src="../transkey/genkey.js"></script>

<script>
var s = '';
s += '-----BEGIN CERTIFICATE-----\n';
s += 'MIIDGTCCAoKgAwIBAgIEBo53lTANBgkqhkiG9w0BAQQFADBhMQswCQYDVQQGEwJL\n';
s += 'UjELMAkGA1UECBMCYWExCzAJBgNVBAcTAmFhMQswCQYDVQQKEwJhYTELMAkGA1UE\n';
s += 'CxMCYWExCzAJBgNVBAMTAmFhMREwDwYJKoZIhvcNAQkBFgJhYTAeFw0wMTA3MTgw\n';
s += 'MDAwMDBaFw0wNjA3MTcwNDE4MDBaMGcxCzAJBgNVBAYTAktSMQwwCgYDVQQIEwNp\n';
s += 'aWkxDDAKBgNVBAcTA2lpaTEMMAoGA1UEChMDaWlpMQwwCgYDVQQLEwNpaWkxDDAK\n';
s += 'BgNVBAMTA2lpaTESMBAGCSqGSIb3DQEJARYDaWlpMIGfMA0GCSqGSIb3DQEBAQUA\n';
s += 'A4GNADCBiQKBgQCzSWuMplCOF2v/RGL6xENjTH5SFMXKlcJbnebTm1ZuENjc5KHo\n';
s += 'fW6t89qkHznyHlllWwVSv8bNm5u6TK5fNFY4RC95cU8jqAVK0oFRLRjkDAfoMVV1\n';
s += 'fD5eoXmN6fyZWtLgiHXQ9evISBP62UkT5KjQ86dDKo2Dg53XFVyKI+ksAwIDAQAB\n';
s += 'o4HXMIHUMGoGCWCGSAGG+EIBDQRdFltZb3VyIENlcnRpZmljYXRlIGlzIGR1ZSB1\n';
s += 'cHRvIDEgeWVhci4gWW91IGhhdmUgdG8gcmVpc3N1ZSB5b3VyIGNlcnRpZmljYXRl\n';
s += 'IGJlZm9yZSBpdCBleHBpcmVzMCIGCWCGSAGG+EIBAgQVFhN3d3cuc29mdGZvcnVt\n';
s += 'LmNvLmtyMBEGCWCGSAGG+EIBAQQEAwIAgDAvBglghkgBhvhCAgUEIhYgZDQxZDhj\n';
s += 'ZDk4ZjAwYjIwNGU5ODAwOTk4ZWNmODQyN2UwDQYJKoZIhvcNAQEEBQADgYEAPeWZ\n';
s += 'SPTLWtdsNNrztq//3agTQImdn2Yrds5Rhf1Y2FZ+sXdZvPLBy3+p1eh4zy0IVyjm\n';
s += 'AioAO9U//TuZfeHlOs6ffsBc87D3BaBH0CUdQxaPy99AtUrVnGxNjJ3QjSesiPxf\n';
s += 'kcIPWgTrDozCmSKh0lr8MKzB0PpML7gpLkE6ZNQ=\n';
s += '-----END CERTIFICATE-----\n';
s += '';

	PrintObjectTag ();
	XecureWeb.mDivInsertOption = false;
var useTranskey = false;
</script>
<script>
function sumCheckbox (aCheckbox)
{
	var aIter;
	var aTotal = 0;

	for (aIter = 0;aIter < aCheckbox.length;aIter++)
	{
		if (aCheckbox[aIter].checked)
			aTotal += parseInt (aCheckbox[aIter].value);
	}

	return aTotal;
}
function initForm ()
{
	// form_SignDataWithVID
	document.getElementById ("form_SignDataWithVID").aXgateAddress.value = XecureWeb.mXgateAddress;
	document.getElementById ("form_SignDataWithVID").aCAList.value = XecureWeb.mCAList;
	document.getElementById ("form_SignDataWithVID").aPlain.value = "이 내용이 전자서명됩니다.";
	document.getElementById ("form_SignDataWithVID").aLimitPassword.value = XecureWeb.mLimitPassword;

	// form_SignDataWithVID_Serial
	document.getElementById ("form_SignDataWithVID_Serial").aXgateAddress.value = XecureWeb.mXgateAddress;
	document.getElementById ("form_SignDataWithVID_Serial").aCAList.value = XecureWeb.mCAList;
	document.getElementById ("form_SignDataWithVID_Serial").aPlain.value = "이 내용이 전자서명됩니다.";
	document.getElementById ("form_SignDataWithVID_Serial").aLimitPassword.value = XecureWeb.mLimitPassword;
}

function SignDataWithVID_callback (aResult)
{
	document.getElementById ("form_SignDataWithVID").aSignedMsg.value = aResult;
	var aResultVid = send_vid_info();
	document.getElementById ("form_SignDataWithVID").aVidMsg.value = aResultVid;
}

function SignDataWithVID_Serial_callback (aResult)
{
	document.getElementById ("form_SignDataWithVID_Serial").aSignedMsg.value = aResult;
	aResultVid = XecureWeb.GetVidInfo();
	document.getElementById ("form_SignDataWithVID_Serial").aVidMsg.value = aResultVid;
}

</script>
</head>
<body onload="initForm();">
<form name='xecure'><input type=hidden name='p'></form>
	<table width="800" border="0" align='center' cellspacing="0" cellpadding="0" height="100%">
		<!-- Header -->
		<tr>
			<td>
				<div id="xecure_header" />
			</td>
		</tr>

		<!-- Body -->
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<!-- left space -->
						<td width='106'>&nbsp;</td>

						<!-- right contents -->
						<td>
							<!-- CENTER START -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<h3>SignDataWithVID</h3>
										<table class="test">
										<form id="form_SignDataWithVID"  method=post action='./sign_vid_result.jsp'>
											<tr>
												<td width="50" rowspan="7">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtext" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													1 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8"/>
													8 : <strong>WEB(aIdn)</strong>으로 부터 직접 VID를 입력받는다  <strong>(VID입력창 뜨지 않음)</strong><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16"/>
													16 : IDN값을 입력받지 않는다 ""로 IDN대체 <strong>(VID입력창을 띄우지 않음)</strong><br/>
												</td>
											</tr>
											<tr>
												<td>aIdn</td>
												<td><input type="text" class="inputtext" name="aIdn"/></td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="XecureWeb.SignDataWithVID"
													onClick="XecureWeb.SignDataWithVID (this.form.aXgateAddress.value,
																					this.form.aCAList.value,
																					this.form.aPlain.value,
																					sumCheckbox (this.form.aOption),
																					this.form.aDescription.value,
																					this.form.aLimitPassword.value,
																					this.form.aIdn.value,
																					s,
																					SignDataWithVID_callback);"/>
													<!--br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_vid_user" 

						onClick="Sign_with_vid_user (sumCheckbox (this.form.aOption), 
													 this.form.aPlain.value, 
													 s,
													 SignDataWithVID_callback);"/>

													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_vid_web" 

						onClick="Sign_with_vid_web (sumCheckbox (this.form.aOption), 
													this.form.aPlain.value, 
													this.form.aIdn.value, 
													s,
													SignDataWithVID_callback);"/-->
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtext" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>VID Output</td>
												<td colspan="2">
													<textarea class="inputtext" name="aVidMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>전송</td>												
												<td colspan="4" height="25"><input type=submit value="서버로전송">
												</td>
											</tr>

										</form>
										</table>
										<br/>

										<h3>SignDataWithVID_Serial</h3>
										<table class="test">
										<form id="form_SignDataWithVID_Serial" method=post action='./sign_vid_result.jsp' >
											<tr>
												<td width="50" rowspan="9">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aSerial</td>
												<td><input type="text" class="inputtext" name="aSerial"/></td>
											</tr>
											<tr>
												<td>aLocation</td>
												<td><input type="text" class="inputtext" name="aLocation"/></td>
											</tr>
											<tr>
												<td>aIdn</td>
												<td><input type="text" class="inputtext" name="aIdn"/></td>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtext" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													1 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8"/>
													8 : <strong>WEB(aIdn)</strong>으로 부터 직접 VID를 입력받는다  <strong>(VID입력창 뜨지 않음)</strong><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16"/>
													16 : IDN값을 입력받지 않는다 ""로 대체 <strong>(VID입력창 뜨지 않음)</strong><br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="XecureWeb.SignDataWithVID_Serial"
													onClick="XecureWeb.SignDataWithVID_Serial (this.form.aXgateAddress.value,
																					this.form.aCAList.value,
																					this.form.aSerial.value,
																					this.form.aLocation.value,
																					this.form.aPlain.value,
																					sumCheckbox (this.form.aOption),
																					this.form.aDescription.value,
																					this.form.aLimitPassword.value,
																					this.form.aIdn.value, 
																					s,
																					SignDataWithVID_Serial_callback);"/>
													<!--br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_vid_user_serial"
													onClick="Sign_with_vid_user_serial (this.form.aSerial.value,
																						this.form.aLocation.value,
																						sumCheckbox (this.form.aOption),
																						this.form.aPlain.value,
																						s,
																						SignDataWithVID_Serial_callback);"/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_vid_web_serial"
													onClick="Sign_with_vid_web_serial (this.form.aSerial.value,
																					   this.form.aLocation.value, 
																					   sumCheckbox (this.form.aOption), 
																					   this.form.aPlain.value,  
																					   s,
																					   this.form.aIdn.value, 
																					   SignDataWithVID_Serial_callback);"/--->
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtext" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Vid Output</td>
												<td colspan="2">
													<textarea class="inputtext" name="aVidMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>전송</td>
												<td colspan="3" height="25"><input type=submit value="서버로전송">
												</td>
											</tr>


										</form>
										</table>
										<br/>

									</td>
								</tr>
							</table>
							<!-- CENTER END -->
						</td>
						<!-- right contents end -->
					</tr>
				</table>
			</td>
		</tr>

		<!-- Footer -->
		<tr>
			<td>
				<div id="xecure_footer" />
			</td>
		</tr>
	</table>
</body>
</html>

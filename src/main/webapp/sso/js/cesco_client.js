$.support.cors = true;
$.ajaxSetup ({ cache: false });

var clientHost = "https://127.0.0.1:39093"; 


function init() {
	return new Promise(function(resolve, reject) {
		$.ajax({
			url: clientHost + "/init",
			type: "POST",
			data: JSON.stringify(initMessage()),
			success: function(data) {
				if(data.resultMsg == 'SUCCESS') {
					resolve();	
				} else {
					alert(data.resultMsg);
					reject(data);
				}
				
			},
			error: function(xhr, a, b) {
				console.log(xhr);
				reject(xhr.responseText);
			}
		});	
	});
}

function get() {
	return new Promise(function(resolve, reject) {
		$.ajax({
			url: clientHost + "/GetData",
			type: "POST",
			//contentType: "text/plain",
			headers: {
				"Authorization": "Basic dGVzdGNsaWVudDp0ZXN0c2VjcmV0MQ=="
			},
			
			crossDomain: true,
			/*beforeSend : function(xhr){
	            xhr.setRequestHeader("Authorization", "Basic asdfasxdfasdfasdf");
	        },*/
			//data: JSON.stringify(initMessage()),
			
			success: function(data) {
				if(data.resultMsg == 'SUCCESS') {
					resolve();	
				} else {
					alert(data.resultMsg);
					reject(data);
				}
			},
			error: function(xhr, a, b) {
				reject(xhr.responseText);
			}
		});
	});
}

//{"token" : "SSOTOKEN", "tokenIdx" : "123-456-7890"}
function set() {
	return new Promise(function(resolve, reject) {
		let artifact = {
				"artifact" : "<%= artifact %>"
		}
		
		$.ajax({
			url: clientHost + "/SetData",
			type: "POST",
			data: JSON.stringify(artifact),
			success: function(data) {
				if(data.resultMsg == 'SUCCESS') {
					submit();
					resolve();
				} else {
					alert(data.resultMsg);
					reject(data);
				}
			},
			error: function(xhr, a, b) {
				reject(xhr.responseText);
			}
		});
	});
}

function logout() {
	$.ajax({
		url: clientHost + "/Logout",
		type: "POST",
		//data: JSON.stringify(getMessage()),
		success: function(data) {
			console.log(data);
		},
		error: function(xhr, a, b) {
			
		}
	});
}

function check() {
	$.ajax({
		url: clientHost + "/Check",
		type: "POST",
		data: JSON.stringify(initMessage()),
		success: function(data) {
			console.log(data);
		},
		error: function(xhr, a, b) {
			
		}
	});
}
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>

<style>
	.backgroundColor{background-color:ffdee9;}
</style>

</head>
<body onbeforeunload="closePage()" class="backgroundColor" >

	<input type="hidden" id="studyGroupIdx" name="studyGroupIdx" value="${idx}"/>
	<input type="hidden" id="userName" name="userName" value="${user.name}"/>
	<input type="hidden" id="userIdx" name="userIdx" value="${user.idx}"/>
	<input type="hidden" id="myProfile" name="myProfile" value="${myProfile.route}" />
	
	
	<div>
	<div style="text-align:center; min-height: 90%; ">
		<div id="output" style="min-height: 450px; display: inline; width: 90%; height: 90%;"></div>
		
	</div>
	<hr>
	<div style="text-align:center;">
		<input type="text" id="message" onkeydown="JavaScript:sendByEnter();" style="width: 90%; display: inline;">
		<button id="send" onclick="send()">send</button>
	</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var ws;//웹소켓
	var blankPattern = /^\s+|\s+$/g; //공백 체크
	var studyGroupIdx = document.getElementById('studyGroupIdx').value;
	var userName = document.getElementById('userName').value;
	var message = document.getElementById('message');//유저가 입력할 메세지 input태그의 id값
	var myProfileImg = document.getElementById('myProfile').value;//채팅창에 프로필 이미지를 출력하기 위함.
	
	function connect() {
		ws = new WebSocket('ws://localhost:8080/StudyMate/studyRoom/board/tempChat/'+studyGroupIdx);
		ws.onopen = function() {
			entrance();
		};
		ws.onmessage = function(message) {
			console.log(message);
			onMessage(message);
		};
		ws.onclose = function(event) {
			exit();
			console.log(event);
		};
		
		function onMessage(event){
			var fromServer = JSON.parse(event.data);
			var name = fromServer.name;
			var msg = fromServer.msg;
			
			
			
			if(name == userName && name !="" && msg != ""){//본인이 작성한 메세지는 오른쪽에 출력
				var tempMsg = "<div style=\"text-align:right\">" + "<span style=\"margin-botton:1px;\"> <img src="+ myProfileImg +" style=\"width: 1cm; height: 1cm; border-radius: 100%;\">"+ name + "</span><br/>" + "<span style=\"background-color:white; border-radius: 5%; \">" + msg + "</span> </div>" ;
				print(tempMsg);
			}else if(name != userName && name !="" && msg == ""){//맨 처음 채팅방에 입장한 경우 출력
				var tempMsg = "<div style=\"text-align:center; color:red;\">" + "<span>"+ name +' 님이 입장하셨습니다.'+ "</span> </div>" ;
				print(tempMsg);
			}else if(name != userName && name !="" && msg != ""){//상대방이 작성한 메세지는 왼쪽에 출력
				var tempMsg = "<div style=\"text-align:left\">" + "<span style=\"margin-botton:1px;\">"+ name + "</span><br/>" + "<span style=\"background-color:white; border-radius: 5%; \">" + msg + "</span> </div>" ;
				print(tempMsg);
			}else if(name == ""){
				var tempMsg = "<div style=\"text-align:center; color:red;\">" + "<span>"+ msg + "</span> </div>" ;
				print(tempMsg);
			}
		}
		
		function print(s) {
			$('#output').val($('#output').val()+'\n').append(s);
			$('#output').scrollTop($("#output").prop('scrollHeight'));
		}
		
	}
	
	function disconnect() {
		if (ws) {
			//exit();
			ws.close();
			ws = null;
		}
	}
	
	function cursorOnFocus(){//메세지 입력부분에 focus를 맞춰줌.
		document.getElementById('message').focus();
	}
	
	function send(){
		
		if(message.value.replace(blankPattern, '') == ""){
			//공백만 입력하고 send 했을경우 처리
			cursorOnFocus();
		}else{
			
			var tempMessage = {
				name : userName,
				tempMsg : message.value
			};
			ws.send(JSON.stringify(tempMessage));
			
		}
		$("#message").val('');
	}
	
	//입장을 알림
	function entrance(){
		var tempMessage = {
			name : userName
		};
		
		ws.send(JSON.stringify(tempMessage));
	}
	//퇴장을 알림
	function exit(){
		var tempMessage = {
				name : "",
				tempMsg: userName+" 님이 퇴장하셨습니다."	
		};
		
		ws.send(JSON.stringify(tempMessage));
	}
	
	function closePage(){
		exit();
	}
	
	
	//엔터를 눌러도 보냄
	function sendByEnter(){
		if(event.keyCode == 13){
			send();
			return;
		}
	}
	
	
	
	//페이지 로드가 완료되면 자동으로 연결.
	$(document).ready(function(){
		connect();
	});
</script>
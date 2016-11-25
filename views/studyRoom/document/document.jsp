<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../board/board.jsp" %>


        
         <input type="hidden" id="studyGroupIdx" name="studyGroupIdx" value="${idx}"/>
         <input type="hidden" id="userIdx" name="userIdx" value="${user.idx}"/>
         <input type="hidden" id="userName" name="userName" value="${user.name}"/>
         
         <div class="content">
         
         <!-- 현재 작성자 표시 -->
         <span class="blink_me" id="currentWriter" style="margin:20px;"></span>
         
  		 
  		 
         <!-- 이부분에서 작업 -->
         
         <div id="summernote" style="width:600px; height: 600px;"></div>
         	
			
        	<button class="btn toggle" id="write" >작성하기</button>
        	<button class="btn toggle" id="complete" style="display:none;" onclick="saveDocument()">작성완료</button>
        	
        	<a class="btn" href="/StudyMate/studyRoom/document/documentDown1.do?idx=${idx}">문서 다운로드</a>
        	
        	
        	
         </div>
  		 
  		 
 

<%@ include file="../../include/footer2.jsp" %>

<!-- 동시문서 페이지에 적용할 css -->
<link href="/StudyMate/resources/concurrentDocument/concurrentDocument.css" rel='stylesheet' type='text/css'>
<!-- 동시문서관련. summernote와 websocket -->
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script> 
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css" />
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/js/bootstrap.min.js"></script>


<!-- include summernote css/js -->
<link href="/StudyMate/summernote/dist/summernote.css" rel="stylesheet">
<script src="/StudyMate/summernote/dist/summernote.js"></script>
<!-- include summernote-ko-KR -->
<script src="/StudyMate/summernote/dist/lang/summernote-ko-KR.js"></script>


<script type="text/javascript">
$(document).ready(function() {
    $('#summernote').summernote({
        height : 500,
        minHeight: null,
        maxHeight: null,
        focus: true,
        lang: 'ko-KR' // default: 'en-US'
        
    });
})

$(document).ready(function(){
	connect();
});
</script>
<!-- 동시문서 작성을 위한 스크립트 -->

<script type="text/javascript">

	var studyGroupIdx = document.getElementById('studyGroupIdx').value;
	var userIdx = document.getElementById('userIdx').value;
	var userName = document.getElementById('userName').value;
	
	var tempInterval;
	
	var ws = new WebSocket('ws://127.0.0.1:8080/StudyMate/studyRoom/document/document/'+studyGroupIdx);//WebSocket 객체를 생성하여 전역변수 ws 에 대입힌다.; //웹소켓

	onBoard();
	
	/* 페이지 로드시 자동으로 문서작성창에 포커스를 맞춰줌 */
	function onBoard(){
		document.getElementById('summernote').focus();
	}
	
	
	/* 현재 작성중인 유저의 이름을 깜빡이게 해줌*/
	function blink(){
		$('.blink_me').fadeOut(500).fadeIn(500, blink);
	}


	function connect() { // 이 함수를 호출하면 서버의 웹소켓 핸들러 (MyWebSocketHandler)에 연결하고, 웹소켓 이벤트 핸들러 함수를 등록한다.
    
    	ws.onerror = function(event){
    		onError(event)
    	};
    
    	ws.onopen = function(event){
    		onOpen(event)
  	  	};
    
   		ws.onclose = function(event){
    		onClose(event)
    	};
    
    	ws.onmessage = function(event){
    		onMessage(event)
    	};
    
    
    	function onOpen(event){
    		//alert('동시문서작성을 시작합니다.');
    	}
    
    
    	function onError(event){
    		alert(event.data+" 서버 연결에 문제가 발생하였습니다.");
    	}
    
    	function onClose(event){
    		alert("세션이 종료되었습니다.");
    	}
    
    	function onMessage(event){//서버가 보낸 메세지가 도착하자마자 호출되는 이벤트 핸들러 함수.
    		    	
    		var fromServer = JSON.parse(event.data);
    		var currentWriter = fromServer.name;
    		
    		if(currentWriter != null){
    			$('#currentWriter').html(currentWriter+' 님이 문서를 작성중입니다.');
    		}
    	
    		if(fromServer.writing == '작성중'){//누군가 작성중이면
    			//다른 클라이언트들의 작성하기 버튼을 막고 입력창도 비활성화 해줌.
    			$('#write').attr('disabled', true);
    			$('#summernote').attr('disabled', true);
    		}
    		
    		if(fromServer.writing == '작성완료'){//문서 작성중인 유저가 완료를 하면
    			//다른 클라이언트들의 작성하기 버튼을 활성화 하고 입력창도 활성화 해줌.
    			$('#write').removeAttr('disabled');
    			$('#summernote').removeAttr('disabled');
    			$('#currentWriter').html('');
    		}
    		
    		console.log(event.data);//데이터를 로그에 찍어줌.
    		//print(event.data);//서버가 보낸 데이터를 화면에 출력하는 함수 호출.
    		print(fromServer.documentContents);
    	}
    

    	function print(s) {//문자열을 textarea에 출력하기 위해 구현한 함수.
    		//console.log(s);
    		//console.log(jQuery.type(s));
    		console.log($('#summernote').val());
        	//$('#summernote').val(s);
        	var document1 = document.getElementById("temp");
        	document1.innerHTML = s;
        
        	$('#summernote').scrollTop($("#summernote").prop('scrollHeight'));// <textarea id="output"> 태그의 수직 스크롤바를 하단으로 이동.
    	}
	}//connect 끝



$(function () {
	
	
	
    $('#connect').click(function () {// id가 connect인 버튼을 클릭했을때 실행될 이벤트 핸들러 함수를 등록.
        connect();
    });
    
    $('#write').click(function(){//작성하기 버튼 눌렀을 때 실행될 이벤트 핸들러 함수
    	$("button.toggle").toggle();
    	//setInterval(sendDocument,1000);
    	tempInterval = setInterval(sendDocument,1200);
    //sendDocument(userName) 이렇게 매개변수가 존재하면 setInterval 함수 동작 안함... ㅠㅠ
    });
    
    $('#complete').click(function(){
    	$("button.toggle").toggle();
    	//writing1 = "작성완료";
    	
    	var document = {
    			documentContents : $("#temp").html(),
    			writer : userName,
    			writing : "작성완료"
    	};
    	ws.send(JSON.stringify(document));
    	clearInterval(tempInterval);
    });
});

//서버로 내용을 보내는 함수
function sendDocument(){
	var document = {
		documentContents : $("#temp").html(),//summernote 창에 입력된 내용이 document에 잘 들어가고
		writer : userName,
		writing: "작성중"
	};
	ws.send(JSON.stringify(document));//서버로 전송
}

//저장하기 위해
function saveDocument(){
	var sendDocument ;
	
	sendDocument = {
			
			studyGroupIdx : studyGroupIdx,
			userIdx : userIdx,
			userName : userName,
			contents : $("#temp").html(),
			
	};
	
	
	
	$.ajax({
		type : "post",
		url : "/StudyMate/studyRoom/document/save.do",
		data : sendDocument,
		dataType : "json",
		success : function(data){
			alert('저장 성공');
			alert('다운로드페이지로 이동합니다.');
			
			//downloadDocument(data);
			
		}
	});
	
};


//다운로드 위해
function downloadDocument(data){
	alert("downloadDocument 함수로 들어옴.");
	var document;
	document = {
			
			contents : data.contents
	};
	
	JSON.stringify(document);
	
	$.ajax({
		type : "post",
		url : "/StudyMate/studyRoom/document/documentDown.do",
		data : document,
		dataType : "json",
		success : function(data){
			alert("성공");
		}
	}); 
	
}


/* function isWriting(userName){//작성하기를 누르면 작성중인 유저의 이름과 writing:true를 json형식으로 보냄
	var msg = {
				writer : userName,
				writing: "작성중"
			  };
	ws.send(JSON.stringify(msg));
}

function complete(userName){
	var msg = {
				writer : userName,
				writing: "작성완료"
			  };
	ws.send(JSON.stringify(msg));
} */


</script>
<style>
.note-table{
	display:none;
}
.note-insert{
	display:none;
}
.note-view{
	display:none;
}
</style>
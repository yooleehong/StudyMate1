<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
<script>
var ws;

function connect() { // 이 함수를 호출하면 서버의 웹소켓 핸들러 (MyWebSocketHandler)에 연결하고, 웹소켓 이벤트 핸들러 함수를 등록한다.
    ws = new WebSocket('ws://localhost:8080/studyMate.websocket/document.do');//WebSocket 객체를 생성하여 전역변수 ws 에 대입힌다.

    ws.onopen = function () {//서버에 웹소켓이 연결되자 마자 호출되는 이벤트 핸들러 함수를 등록한다.
        //alert('서버와 연결 되었습니다.');
    };

    ws.onmessage = function (document) {//서버가 보낸 메세지가 도착하자마자 호출되는 이벤트 핸들러 함수를 등록.
        console.log(document);
    	//alert('서버에서 보낸 내용: '+document.data);
        print(document.data);//서버가 보낸 문자열을 화면에 출력
    };

    ws.onclose = function (event) {
        console.log(event);
    };

    function print(s) {//문자열을 textarea에 출력하기 위해 구현한 함수.
        $('#output').val(s);//출력할 문자열을 <textarea id="output"> 태그의 끝에 추가
        $('#output').scrollTop($("#output").prop('scrollHeight'));// <textarea id="output"> 태그의 수직 스크롤바를 하단으로 이동.
    }
}



$(function () {
    $('#connect').click(function () {// id가 connect인 버튼을 클릭했을때 실행될 이벤트 핸들러 함수를 등록.
        connect();//줄 8의 connect() 함수 호출
        //alert('동시 문서 작성을 시작합니다.');
    });
    
    $('#write').click(function(){//작성하기 버튼 눌렀을 때 실행될 이벤트 핸들러 함수
    	//여기에 다른 참여자들의 textarea와 button을 disabled 시키는 구문이 위치해야함.
    	//var isWrite = document.getElementById("write").value();
    	//isWrite = document.getElementById("write");
    	//isWrite.disabled = 'true';
    	$("button.toggle").toggle();
    	//alert('문서 작업을 시작합니다.');
    });
    
    $('#send').click(function () {//
        var document = $("#output").val();//문서의 내용을 (textarea에 입력된 내용) document 변수에 저장
        ws.send(document);//웹소켓을 통해 서버로 전달. 서버에서는 그냥 받아줌--> 참여자가 내용을 삭제했을 수도 있고 추가했을 수도 있어서.
        $("button.toggle").toggle();//작성하기로 토글
    });
    
});
</script>
</head>
<body>
    <div>
        <div>문서를 작성하세요.</div>
        <textarea id="output" style="width:600px; height: 600px;"></textarea>
        <button id="connect">문서 작성 참여하기</button>
        <button class="toggle" id="write" >작성하기</button>
        <button class="toggle" id="send" style="display:none;">공유하기</button>
        
        <br />
        
        <button>문서 저장(임시)</button>
        
    </div>
    

</body>
</html>
 

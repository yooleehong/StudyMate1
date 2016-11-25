<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../../include/header1.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
	<title>snippet</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.0.min.js"></script>
<!-- 쪽지 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
div.enter{
	margin-top: 8%;
}
div.left{
	margin-left: 20%;
}
td.td1{
	width: 150px;
}
td.td2{
	width: 600px;
}

</style>	
	<script>
	$(document).ready (function () {
		//리스트(ul) 아코디언(공통) 항상 필요함!
		function accordion(o) {
			var maxWidth = $(o).parent().children('.on').children('.inner').width();
			var minWidth = $(o).parent().children().not('.on').children('.inner').width();	
			$(o).animate({width: maxWidth+"px"}, { queue:false, duration:400});
			$(o).siblings('.on').animate({width: minWidth+"px"}, { queue:false, duration:400 });
			$(o).siblings('.on').toggleClass('on'); 
			$(o).addClass('on');
		}

		//리스트(ul) 아코디언(auto)
		(function(a){
			a.fn.accordion_auto=function(p){
				var s_t_i=p&&p.scroller_time_interval?p.scroller_time_interval:"3000";
				var dom=a(this);
				var s_length=dom.length;
				var timer;
				var current = 0;
				begin();
				play();
				function begin(){
					dom.click(function(){
						current = dom.index($(this)); play(); stop()
					});
					dom.hover(function(){
							stop();
						},
						function(){
							timer = setTimeout(play,s_t_i);
						}
					);
				}
				function stop(){
					clearTimeout(timer);
				}
				function play(){
					clearTimeout(timer);
					accordion(dom[current]);
					if(current >= s_length-1){
							current = 0;
					}else{
						current ++;
					}
					timer = setTimeout(play,s_t_i);
				}
			}
		})(jQuery);

		$(".jq_accordion_auto li").accordion_auto();

		//리스트(ul) 아코디언(hover)
		$('.jq_accordion_hover li').hover(function() {
			accordion(this);
		});
	});
	/*쪽지*/
		$('#massege_submit').click(function(){
			event.preventDefault();	//action을 이용한 폼의 이동을 막아줌
				$.ajax({
					type: "POST",
					url : "/StudyMate/MessageController",
					dataType : "JSON",
					data : encodeURI("userFrom="+userFrom+"&userTo="+userTo+"&text="+text)
				});
				
			
			});
		$('#massege_submit2').click(function(){
			event.preventDefault();	//action을 이용한 폼의 이동을 막아줌
				$.ajax({
					type: "POST",
					url : "/StudyMate/MessageController",
					dataType : "JSON",
					data : encodeURI("idx="+idx)
				});
				
			});
			
			
			
		function new_win(){
			
			  window.open("selete_sub.do","new_win","width=300, height=300");
			  
			  }
			  
		
		function new_win2(){
			 cw=screen.availWidth;     //화면 넓이
			ch=screen.availHeight;    //화면 높이
			sw=280;    //띄울 창의 넓이
			sh=200;    //띄울 창의 높이
			ml=(cw-sw)/2;        //가운데 띄우기위한 창의 x위치
			mt=(ch-sh)/2;         //가운데 띄우기위한 창의 y위치
			
			  window.open("/StudyMate3/Message/searchUser.do","new_win2","width=280,height=200,resizable=no,scrollbars=no,menubar=no,toolbar=no,location=no,status=no,left="+ml+",top="+mt+",channelmode=no");
		}
		
		$( function() {
			$( "#dialog" ).dialog({
				autoOpen: false,
				modal: true,
				stack: true,
				zIndex: 1060,
				resizable: false,
				show: {
					effect: "blind",
					duration: 1000
				},
				hide: {
					effect: "explode",
					duration: 1000
				}
			});
		
			$( "#opener" ).on( "click", function() {
				$( "#dialog" ).dialog( "open" );
			});
			
			$( "#dialog2" ).dialog({
				autoOpen: false,
				modal: true,
				stack: true,
				zIndex: 1070,
				width: 500,
				height: 400,
				resizable: false,
				show: {
					effect: "blind",
					duration: 1000
				},
				hide: {
					effect: "explode",
					duration: 1000
				}
			});
			
			$( "#myModal" ).on( "click", function() {
				$( "#dialog2" ).dialog( "open" );
			});
			
			$( "#dialog3" ).dialog({
				autoOpen: false,
				modal: true,
				stack: true,
				zIndex: 1060,
				resizable: false,
				show: {
					effect: "blind",
					duration: 1000
				},
				hide: {
					effect: "explode",
					duration: 1000
				}
			});

			$( "#dialog4" ).dialog({
				autoOpen: false,
				modal: true,
				stack: true,
				zIndex: 1060,
				resizable: false,
				show: {
					effect: "blind",
					duration: 1000
				},
				hide: {
					effect: "explode",
					duration: 1000
				}
			});
			
		} );
		function receive(idx,id,name,text,time) {
			document.form1.idx.value=idx;
			document.form1.name.value=name+'('+id+')';
			document.form1.text.value=text;
			 document.all("Time1").innerHTML=time;
			$( "#dialog3" ).dialog( "open" );
			
		}
		function send(idx,id,name,text,time) {
			document.form2.idx.value=idx;
			document.form2.name.value=name+'('+id+')';
			document.form2.text.value=text;
			 document.all("Time2").innerHTML=time;
			$( "#dialog4" ).dialog( "open" );
			
		}
		
		
		
	</script>
	<style type="text/css">
			.list_menu4 {overflow:hidden}
			.list_menu4 li {overflow:hidden;float:left;position:relative;color:#fff}
			.list_menu4 .inner {width:50px;height:590px}
			.list_menu4 .tit {display:block;position:absolute;top:0;bottom:0;left:0;width:10px;padding:20px;color:#fff;word-break:break-all;text-align:center;cursor:pointer}
			.list_menu4 .menu1 {background:pink}
			.list_menu4 .menu1 .tit {color:#ff6ece}
			.list_menu4 .menu2 {background:#555}
			.list_menu4 .menu2 .tit {color:#fffc00}
			.list_menu4 .menu3 {background:#777}
			.list_menu4 .menu3 .tit {color:#12ff00}
			.list_menu4 .menu4 {background:#999}
			.list_menu4 .menu4 .tit {color:#00fcff}
			.list_menu4 .cont {width:300px;padding:20px 10px 10px 60px}
			.list_menu4 .on .inner {width:1000px; height:590px;}
		</style>

</head>
<body style="background-color: #e7e7e7;">
		
		<div style="margin-top: 5%;"></div>
 <button type="button" class="btn btn-info btn-lg" id="myModal" style="margin-left: 76%;">send</button>
		<div style="margin-left: 18%; margin-top: 5px;">
		<ul class="jq_accordion_hover list_menu4">
		<c:if test="${!empty receive}">
			<li class="menu1 on"><div class="inner"><strong class="jq_toggle tit">RECEIVE</strong><!-- 메뉴1 시작-->
			<div class="jq_hide cont" style="width: 800px; ">
				<div class="enter"></div>
					<div class="left">
					
					<!-- 받은편지함 -->
						<table border="0" class="table table-hover">
							<thead>
								<tr>
									<td style="text-align: center;">보낸이</td>
									<td>내용</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="receive" items="${receive}">  
								      <tr onclick="receive('${receive.idx}','${receive.loginId}','${receive.name}','${receive.text}','${receive.writeTime}')">
								           <td id="td1" class="td1" style="text-align: center;">${receive.loginId} </td>
								           <td class="td2"> ${receive.text} </td>
								      </tr>
							     </c:forEach> 
						     </tbody>
						     </table>
						       <div>
				<ul class="pagination pagination-small pagination-centered"> 
		     	 <c:forEach var="page" items="${ pagination.pageList }">
			       <li class='${ page.cssClass }'>
			       <a data-page="${ page.number }">
			       ${ page.label }</a>
			       </li>
		       	 </c:forEach>
				</ul>
			 </div>
					</div>
			</div>
			</div></li><!-- 메뉴1 끝 -->
			</c:if>
			<c:if test="${empty receive}">
				<li class="menu1 on"><div class="inner" style="margin-top: 19.02px;"><strong class="jq_toggle tit">RECEIVE</strong><!-- 메뉴1 시작-->
			<div class="jq_hide cont" style="width: 800px; ">
				<div class="enter"></div>
					<div class="left">
				<h3 style="text-align: center; margin-top: 42%; ">받은 쪽지가 없습니다.</h3>
					</div>
			</div>
			</div></li><!-- 메뉴1 끝 -->

			
			</c:if>
			
			<c:if test="${!empty send}">
				<li class="menu2"><div class="inner"><strong class="jq_toggle tit">SEND</strong>
				<div class="jq_hide cont" style="width: 800px; ">
				<div class="enter"></div>
					<div class="left">
					
					<!-- 보낸 편지함 -->
						<table name='sendTable' border="0" class="table table-hover">
							<thead>
								<tr>
									<td style="text-align: center;">받는이</td>
									<td>내용</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="send" items="${send}">
									<tr onclick="send('${send.idx}','${send.loginId}','${send.name}','${send.text}','${send.writeTime}')">
										<td class="td1" style="text-align: center;">
											${send.loginId}</td>
										<td class="td2">${send.text}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
	
					</div></div></li>
				</c:if>
				<c:if test="${empty send}">
					<li class="menu2"><div class="inner" style="margin-top: 19.02px;"><strong class="jq_toggle tit">SEND</strong>
						<div class="jq_hide cont" style="width: 800px; ">
						<div class="enter"></div>
							<div class="left">
								<h3 style="text-align: center; margin-top: 42%;">보낸 쪽지가 없습니다.</h3>	
							</div>
			
							</div></div>	
				</c:if>	
				
				<li class="menu3"><div class="inner" style="margin-top: 19.02px;"><strong class="jq_toggle tit">MEMO</strong>
				<div class="jq_hide cont" style="width: 800px; ">
				<div style="margin-bottom: 2%;"></div>
				<div style="margin-left: 5%;">
				<textarea rows="24" cols="100" style="background-color:transparent" ></textarea>
				</div>
			</div></div></li>
			<li class="menu4"><div class="inner" style="margin-top: 19.02px;"><strong class="jq_toggle tit">LOGO</strong>
			<div class="jq_hide cont" style="width: 800px; ">
			<div style="width: 100%; text-align: center; margin-left: 18%; margin-top: 27%;">
			    <img src="/StudyMate/resources/images/icon-main.png" style="width: 100%; max-width: 600px; vertical-align: middle" />
			</div>
			</div></div></li>
		</ul>
		<!-- 리스트(ul) 아코디언(click)// -->
		</div>

	<!-- 쪽지 -->
	<!-- 모달1 -->
	 <div id="dialog" title="사용자 검색" style="width: 100; height: 200; font-size: 15px;">

				<center>
			        
			        <form action="/StudyMate/member/message/main.do" method="POST">
			            <span>이름:</span>
			            <input type="text" id="name" name="name">
			            <button type="submit" id="search">검색</button>
			        </form>
			        
			           
					<c:if test="${empty list}">
					    <span>조회 결과가 없습니다.</span>
					</c:if>
					
					<c:if test="${not empty list}">
							<table>
							<tr>
					      <th>고유번호</th>
					      <th>ID</th>
					      </tr>
					     <c:forEach var="user" items="${list}">  
					      <tr>
					           <td><a href="javascript:form_input(${user.idx})"> ${user.idx} </td>
					           <td> ${user.loginId} </td>
					      </tr>
					     </c:forEach> 
					     </table>
					</c:if>
					
				</center>


			</div>
			
		<!-- 모달2 -->	
		<div id="dialog2" title="쪽지보내기" style="width: 100; height: 200; font-size: 15px;">
        <br>
 
          <form method="POST"  name="suhoform" action="/StudyMate/member/message/select.do">
						
							<label class="control-label" for="inputDefault">보내는사람</label> 
							<input type="text" class="form-control" id="userFrom" name="userFrom" value="${idx}" readonly>
						
						
							<label for="inputPassword" class="control-label">받는사람</label><br>
							<input type="text" class="form-control" id="userTo" name="userTo" readonly><button type="button" id="opener">검색</button>
							<br>
							<label for="inputPassword" class="control-label">내용</label>
							<input type="text" class="form-control" id="text" name="text" placeholder="내용">
					
								<button type="submit" id="massege_submit" class="btn btn-primary btn-lg btn-block">보내기</button>
					
					</form>

            <hr>

		
		</div>
	<c:set var="view" value="${view}"/>
	<c:if test="${'yes' ne view}">	
		<!-- 모달 메세지창 1 -->	
		<div id="dialog3" title="Message" style="width: 100; height: 200; font-size: 15px;">
 					<form method="POST"  name="form1" action="/StudyMate/member/message/delete.do">
 							<div id="Time1" style="margin-top: 1px; text-align: right; margin-bottom: 3px;">2016/3/4</div>
 							<input type="hidden" class="form-control" id="idx" name="idx" value="0">
 							
							<label class="control-label" for="inputDefault">보낸이</label> 
							<input type="text" class="form-control" id="name" name="name" value="hi" readonly>
						
							<br>
							<label for="inputPassword" class="control-label">내용</label>
							<input type="text" class="form-control" id="text" name="text" value="hi" placeholder="내용" readonly>
							<br>
								<button type="submit" id="massege_submit2" class="btn btn-primary btn-lg btn-block">삭제</button>
					</form>
				

            <hr>

		
		</div>
		<!-- 모달 메세지창 2 -->	
		<div id="dialog4" title="Message" style="width: 100; height: 200; font-size: 15px;">
 					<form method="POST"  name="form2" action="/StudyMate/member/message/delete.do">
 							<div id="Time2" style="margin-top: 1px; text-align: right; margin-bottom: 3px;">2016/3/4</div>
 							<input type="hidden" class="form-control" id="idx" name="idx" value="0">
 							
							<label class="control-label" for="inputDefault">받는이</label> 
							<input type="text" class="form-control" id="name" name="name" value="hi" readonly>
						
							<br>
							<label for="inputPassword" class="control-label">내용</label>
							<input type="text" class="form-control" id="text" name="text" value="hi" placeholder="내용" readonly>
							<br>
								<button type="submit" id="massege_submit2" class="btn btn-primary btn-lg btn-block">삭제</button>
					</form>
				

            <hr>

		
		</div>
	</c:if>
</body>
</html>




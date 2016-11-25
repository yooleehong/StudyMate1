<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header1.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>



<!-- Bootstrap CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<!-- font Awesome CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<!-- Main Styles CSS -->
<link href="css/main.css" rel="stylesheet">


<style type="text/css">
.click:hover {
	background-color: #ffa;
	cursor: pointer;
}
body{
 background:#EEEEEE;    
}
.user-profile-2 {
    text-align: center;
    position: relative;
    margin-top:10px;
}

.box-info {
    position: relative;
    padding: 15px;
    background: #fff;
    color: #5b5b5b;
    margin-bottom: 20px;
    -webkit-transition: All 0.4s ease;
    -moz-transition: All 0.4s ease;
    -o-transition: All 0.4s ease;
    border-bottom:4px solid #DDDDDD;
}

.user-profile-2 .header-cover {
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    height: 130px;
    overflow: hidden;
    z-index: 1;
}

.user-profile-2 .user-profile-inner {
    z-index: 2;
    position: relative;
}

.user-profile-2 .user-profile-inner h4.white {
    color: #fff;
}

.user-profile-2 .user-profile-inner img.profile-avatar {
    box-shadow: 0 0 0 5px rgba(255,255,255,1);
    -moz-box-shadow: 0 0 0 5px rgba(255,255,255,1);
    -webkit-box-shadow: 0 0 0 5px rgba(255,255,255,1);
    border: none;
    width:100px;
    height:100px;
}

.user-button {
    margin: 15px 0;
}
/*************pagination***********/
.gallery-bottom .pagination {
  margin-top: 0px;
}

.pagination > li > a, .pagination > li > span {
  background-color: #ccc;
  padding: 3px 9px;
  color: #fff;
  border: 0px;
}

.pagination > li > a {
  margin-right: 5px;
}

.pagination > .active > a, .pagination > .active > span, .pagination > .active > a:hover, .pagination > .active > span:hover, .pagination > .active > a:focus, .pagination > .active > span:focus {
  background-color: #32c5d2;
}
/*************papup layer***********/
.layer {display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:100;}
		.layer .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
		.layer .pop-layer {display:block;}
	.pop-layer {display:none; position: absolute; top: 50%; left: 50%; width: 650px; height:auto;  background-color:#fff; border: 5px solid #3571B5; z-index: 10;}	
	.pop-layer .pop-container {padding: 20px 25px;}
	.pop-layer p.ctxt {color: #666; line-height: 25px;}
	.pop-layer .btn-r {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}
	a.cbtn {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}	
	a.cbtn:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}
</style>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script type="text/javascript">

/*************layer***********/
/* 상세보기 레이어 */
function layer_open(el, url2){
		document.getElementById('layerNo1').style.display='inline';
	document.getElementById('layerNo2').style.display='none';
		var temp = $('#' + el);
  	$.ajax({
		//url : "/StudyMate/studyMain/layerDetal.do?idx=1",
		url : url2,
		//data : encodeURI("commentIdx="+commentIdx),		
		dataType : "json",
		 success : function(data){
			 //alert(data.STUDYNAME);
			 $("#studyGroupName").html(data.STUDYNAME);
			 document.getElementById("leaderName").value = data.LEADERNAME;
			 document.getElementById("maxCounter").value = data.MAXCOUNT;
			 document.getElementById("studyGroupGoal").value = data.STUDYGOAL;
			 document.getElementById("studyGroupContents").value = data.STUDYCONTENTS;
		 },
		 error : function(request){
			 alert("error");
		 }
	});  
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수
	if(bg){
		$('.layer').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
	}else{
		temp.fadeIn();
	}
	// 화면의 중앙에 레이어를 띄운다.
	if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
	else temp.css('left', '0px');
	temp.find('a.cbtn').click(function(e){
		if(bg){
			$('.layer').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
		}else{
			temp.fadeOut();
		}
		e.preventDefault();
	});
	$('.layer .bg').click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
		$('.layer').fadeOut();
		e.preventDefault();
	});
}	
/* 신청서 레이어 */
function layer_open2(el, studyGroupIdx){
	
		document.getElementById('layerNo2').style.display='inline';
		document.getElementById('layerNo1').style.display='none';
		document.getElementById("studyGroupIdx").value = studyGroupIdx;
		document.getElementById("reason").value = "";
		
		var temp = $('#' + el);
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수
	if(bg){
		$('.layer').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
	}else{
		temp.fadeIn();
	}
	// 화면의 중앙에 레이어를 띄운다.
	if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
	else temp.css('top', '0px');
	if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
	else temp.css('left', '0px');
	temp.find('a.cbtn').click(function(e){
		if(bg){
			$('.layer').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
		}else{
			temp.fadeOut();
		}
		e.preventDefault();
	});
	$('.layer .bg').click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
		$('.layer').fadeOut();
		e.preventDefault();
	});
}	


$(function() {

    $("div.pagination a").click(function() {
        $("input[name=pg]").val($(this).attr("data-page"));
        $("form").submit();
    });

    $("[data-auto-submit=true]").change(function() {
        $(this).parents("form").submit();
    });

});

function search(){

	$('#recommendList').hide();
	$('#searchList').show();
}

function apply(){
		 var reason = $('#reason').val();
	 var studyGroupIdx = $('#studyGroupIdx').val();
		$.ajax({
		url : "/StudyMate/studyMain/applicationByLayer.do",
		data : encodeURI("reason="+reason+"&studyGroupIdx="+studyGroupIdx),		
		dataType : "json",
		 success : function(data){
			 
			 if(data.RESULT=="succ"){
				 alert("신청이 완료되었습니다.");			 
			 }else{
				 alert("이미 신청/가입 된 스터디 입니다.");
			 }
			 $('#closeBtn').click();
		 },
		 error : function(request){
			 alert("error");
		 }
	});  
}


</script>

   <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap JavaScript -->
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

    <!-- Custom JavaScript -->
    <script src="js/custom.js"></script>

    <!-- Call functions on document ready -->
    <script>
        $(document).ready(function() {
            // Call Functions Like
            appMaster.aFunction();
            // Call anotherFunction
            appMaster.anotherFunction();
        });
    </script>



 



<div class="container">
	<div class="bs-docs-section">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-header">
					<br />
					<h2 id="tables" style="padding: 2% 2% 0% 2%">StudyGroup List</h2>
					<br />


					<div id="wrapper">
						<div class="container">

							<div id="mainCarousel" class="carousel slide"
								data-ride="carousel">
								<!-- Indicators -->
								<ol class="carousel-indicators">
									<li data-target="#mainCarousel" data-slide-to="0"
										class="active"></li>
									<li data-target="#mainCarousel" data-slide-to="1"></li>
									<li data-target="#mainCarousel" data-slide-to="2"></li>
								</ol>

								<!-- Wrapper for slides 1920x650 -->
								<div class="carousel-inner" role="listbox">
									<div class="item active">
										<img
											src="https://investimmi-cdn.s3-us-west-2.amazonaws.com/Content/img/650/study.jpg"
											alt="...">
										<div class="carousel-caption">
											<h3>Slide Caption</h3>
										</div>
									</div>
									<div class="item">
										<img
											src="https://investimmi-cdn.s3-us-west-2.amazonaws.com/Content/img/650/our-services-student.jpg"
											alt="...">
										<div class="carousel-caption">
											<h3>Slide Caption</h3>
										</div>
									</div>
									<div class="item">
										<img
											src="http://comd.hkbu.edu.hk/masters/images/bg_highlights_main.jpg"
											alt="...">
										<div class="carousel-caption">
											<h3>Slide Caption</h3>
										</div>
									</div>
								</div>

								<!-- Controls -->
								<a class="left carousel-control" href="#mainCarousel"
									role="button" data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left"></span> <span
									class="sr-only">Previous</span>
								</a> <a class="right carousel-control" href="#mainCarousel"
									role="button" data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right"></span> <span
									class="sr-only">Next</span>
								</a>
							</div>
							<!-- /Slider -->

							<hr>

						</div>
					</div>
					
				
					<div style="padding: 2% 0% 1% 0%">				
						<a href="/StudyMate/studyMain/studyListForLeader.do" class="btn btn-primary col-xs-offset-9">생성한 스터디</a> 			
						<a href="/StudyMate/studyMain/studyListForMember.do" class="btn btn-primary">가입한 스터디</a>
						<!-- 		<a href="/StudyMate/studyMain/studyListAll.do" class="btn btn-primary">스터디 가입</a> -->
						<a href="javascript:search();" style="float:left; padding-left:30px"><img width="10%" height="10%" src="http://www.thesecu.com/wp-content/themes/secu/assets/images/Apps-Search-icon.png"></a>
				</div>
			</div>
		</div>





		<div style="display:${test2};" id="searchList">
		<!-- 스터디 검색 -->
		<br/><br/>
		<form:form id="searchForm" method="post" modelAttribute="pagination">
			<input type="hidden" name="pg" value="1" />
			<div class="bs-component">
				<div style="padding-left:30px">
				<form:select path="ss">
					<form:option value="0" label="전체보기" />
					<form:option value="1" label="스터디 이름 검색" />
					<form:option value="2" label="스터디 소개글 검색" />
					<form:option value="3" label="스터디 목표 검색" />
				</form:select>
				<form:input path="st" />    <!-- 검색어 -->
				<!-- onclick="location.href='javascript:foo();'" -->
				<input type="submit" class="btn btn-small" style="height: 30px" value="검색">
				<c:if test="${ pagination.ss != 0 }">
					<a href="studyListAll.do" class="btn btn-small">취소</a>  <!-- 수정 -->
				</c:if>
				<form:select path="od" data-auto-submit="true">
					<form:option value="0" label="생성 순서" />
					<form:option value="1" label="스터디 이름 순서" />
				</form:select>

				<form:select path="sz" data-auto-submit="true">
					<form:option value="10" />
					<form:option value="15" />
					<form:option value="30" />
					<form:option value="50" />
				</form:select>
				</div>
				<div class="container bootstrap snippet">
				<br/>
					<c:forEach var="studyGroup" items="${list2}">
					    <div class="col-sm-4">
					    	<!-- Begin user profile -->
					    	<div class="box-info text-center user-profile-2">
					    		<div class="header-cover">
								<!-- //[유리방금추가] 시작 -->
				    				<c:set var="none2" value="true"/>
					    		<c:forEach var="groupImages" items="${groupImages}">
							   			<c:if test="${studyGroup.idx eq groupImages.studyGroupIdx}">
							   			<img src="/StudyMate/studyGroupImage/${groupImages.fileName}" style="height: 130px; width: 350px;" alt="User cover">
							   			<c:set var="none2" value="false"/>  			
							   			</c:if>
							   				
							   			<c:if test="${studyGroup.idx ne groupImages.studyGroupIdx}">	
							   			</c:if>	
				
					    		</c:forEach>
					    		<c:if test="${none2}">
					    		<img src="http://bootdey.com/img/Content/bg_element.jpg" style="height: 130px; width: 350px;" alt="User cover">
					    		</c:if>	

 							<!-- //[유리방금추가]끝 -->
					    		</div>
					    		<div class="user-profile-inner">
					    			<h4 class="white">${studyGroup.studyGroupName}</h4>
									<!-- //[유리방금추가] 시작 -->
				    				<c:set var="none" value="true"/>
					    		<c:forEach var="images" items="${images}">
							   			<c:if test="${studyGroup.leaderIdx eq images.userIdx}">
							   			<img src="/StudyMate/upload2/${images.fileName}" class="img-circle profile-avatar" alt="User avatar">
							   			<c:set var="none" value="false"/>  			
							   			</c:if>
							   				
							   			<c:if test="${studyGroup.leaderIdx ne images.userIdx}">	
							   			</c:if>	
				
					    		</c:forEach>
					    		<c:if test="${none}">
					    		<img src="http://bootdey.com/img/Content/User_for_snippets.png" class="img-circle profile-avatar" alt="User avatar">
					    		</c:if>	
				    			<!-- //[유리방금추가]끝 -->
					    			<h5>${studyGroup.leaderName}</h5>
					    			<h6>${studyGroup.studyGroupIntro}</h6>
					    			<h6>${studyGroup.studyGroupGoal}</h6>
					    			<h6>${studyGroup.studyGroupTerm}</h6>
					    				
					    			<!-- User button -->
					    			<div class="user-button">
					    				<div class="row">
					    					<div class="col-md-6">
					    						<!-- <button type="button" class="btn btn-primary btn-sm btn-block"><i class="fa fa-envelope"></i> 상세보기</button> -->
					    						 <a type="button" class="btn btn-default btn-sm btn-block"  href="#" onclick="layer_open('layer2', '/StudyMate/studyMain/layerDetal.do?idx=${studyGroup.idx}');return false;"><i class="fa fa-envelope"></i> 상세보기</a> 
					    					</div>
					    					<div class="col-md-6">
					    						<a type="button" class="btn btn-default btn-sm btn-block" href="#" class="btn-example" onclick="layer_open2('layer3','${studyGroup.idx}');return false;"><i class="fa fa-user"></i> 가입하기</a>
					    					</div>
					    				</div>
					    			</div>
					    		</div>
					    	</div>
					    </div>   
					   </c:forEach>	
					</div>	
			</div>


 			<!-- pagination -->
			 <div class="col-sm-6">
				<ul class="pagination">
					<c:forEach var="page" items="${ pagination.pageList }">
                		<li class='${ page.cssClass }'><a data-page="${ page.number }">${ page.label }</a></li>
            		</c:forEach>
				</ul>
			</div> 
			
			

		</form:form>
		</div>
		
		
	</div>
</div>


<!-- 스터디 추천 리스트 -->	
	
<div id="recommendList" class="container bootstrap snippet" style="display:${test1};">
<h4 id="tables" style="padding: 2% 2% 0% 2%"> recommend list</h4>		
<c:forEach var="studyGroup" items="${list}">
    <div class="col-sm-4">
    	
    	<!-- Begin user profile -->
    	<div class="box-info text-center user-profile-2">
    		<div class="header-cover">
    			<!-- //[유리방금추가] 시작 -->
				    				<c:set var="none2" value="true"/>
					    		<c:forEach var="groupImages" items="${groupImages}">
							   			<c:if test="${studyGroup.idx eq groupImages.studyGroupIdx}">
							   			<img src="/StudyMate/studyGroupImage/${groupImages.fileName}" style="height: 130px; width: 350px;" alt="User cover">
							   			<c:set var="none2" value="false"/>  			
							   			</c:if>
							   				
							   			<c:if test="${studyGroup.idx ne groupImages.studyGroupIdx}">	
							   			</c:if>	
				
					    		</c:forEach>
					    		<c:if test="${none2}">
					    		<img src="http://bootdey.com/img/Content/bg_element.jpg" style="height: 130px; width: 350px;" alt="User cover">
					    		</c:if>	

 							<!-- //[유리방금추가]끝 -->

    		</div>
    		<div class="user-profile-inner">
    			<h4 class="white">${studyGroup.studyGroupName}</h4>
    				<!-- //[유리방금추가] 시작 -->
    				<c:set var="none" value="true"/>
	    		<c:forEach var="images" items="${images}">
			   			<c:if test="${studyGroup.leaderIdx eq images.userIdx}">
			   			<img src="/StudyMate/upload2/${images.fileName}" class="img-circle profile-avatar" alt="User avatar">
			   			<c:set var="none" value="false"/>  			
			   			</c:if>
			   				
			   			<c:if test="${studyGroup.leaderIdx ne images.userIdx}">	
			   			</c:if>	

	    		</c:forEach>
	    		<c:if test="${none}">
	    		<img src="http://bootdey.com/img/Content/User_for_snippets.png" class="img-circle profile-avatar" alt="User avatar">
	    		</c:if>	
    			<!-- //[유리방금추가]끝 -->
    			<h5>${studyGroup.leaderName}</h5>
    			<h6>${studyGroup.studyGroupIntro}</h6>
    			<h6>${studyGroup.studyGroupGoal}</h6>
    			<h6>${studyGroup.studyGroupTerm}</h6>
    				
    			<!-- User button -->
    			<div class="user-button">
    				<div class="row">
    					<div class="col-md-6"> 					
    						<%-- <a href="/StudyMate/studyMain/studyDetail.do?idx=${studyGroup.idx}"><i class="fa fa-envelope"></i> 상세보기</a> --%>
    					 <a type="button" class="btn btn-default btn-sm btn-block"  href="#" onclick="layer_open('layer2', '/StudyMate/studyMain/layerDetal.do?idx=${studyGroup.idx}');return false;"><i class="fa fa-envelope"></i> 상세보기</a> 
    					</div>
    					<div class="col-md-6">
    						<a type="button" class="btn btn-default btn-sm btn-block" href="#" class="btn-example" onclick="layer_open2('layer3','${studyGroup.idx}');return false;"><i class="fa fa-user"></i> 가입하기</a>
    					</div>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>   
 </c:forEach>	
</div>	
    <!-- 스터디 상세보기 레이어 -->
<!--  <a href="#" class="btn-example" onclick="layer_open('layer2');return false;">1</a>  -->
<div id="layerNo1">
<div class="layer">
	<br/><br/><br/>
	<div class="bg"></div>
	<div id="layer2" class="pop-layer">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				<!-- <p id="ptag" class="ctxt mb20">Thank you</p> -->
				
				<div class="container">
         
			      <div class="bs-docs-section">
			        <div class="row">
			          <div class="col-lg-6">
			            <div class="page-header">
			              <h3 id="forms">study group 상세보기</h3>
			            </div>
			          </div>
			        </div>
			
			        <div class="row">
			          <div class="col-lg-6">
			            <div class="well bs-component">
			              <form class="form-horizontal">  
			              
			                <fieldset>
			                  <legend id="studyGroupName"></legend>
			                  
			                   <div class="form-group">
			                    <label for="inputEmail" class="col-lg-2 control-label">조장</label>
			                    <div class="col-lg-10">
			                     	<input id="leaderName" class="form-control" readonly>
			                    </div>
			                  </div>
			                  
			                  <div class="form-group">
			                    <label for="inputEmail" class="col-lg-2 control-label">인원</label>
			                    <div class="col-lg-10">
			                      	<input id="maxCounter" class="form-control" readonly>
			                       
			                    </div>
			                  </div>
			                  
							  <div class="form-group">
			                    <label for="inputEmail" class="col-lg-2 control-label">목표</label>
			                    <div class="col-lg-10">
			                      <input id="studyGroupGoal" class="form-control" readonly>
			                    </div>
			                  </div>
			                  
			                  <div class="form-group">
			                    <label for="textArea" class="col-lg-2 control-label">내용</label>
			                    <div class="col-lg-10">
									 <textarea id="studyGroupContents"  class="form-control" rows="3" readonly></textarea>
			                    </div>
			                  </div>
			             
			                </fieldset>
			              </form>
			            </div>
			          </div>
			          </div>
			          </div>		          
			      </div>
    
				<!--// content-->
				<div class="btn-r">
					<a href="#" class="cbtn">Close</a>
				</div>
			</div>
		</div>
	</div>
</div>
</div>

<!-- 스터디 신청서 레이어 -->
<!-- <a href="#" class="btn-example" onclick="layer_open2('layer3');return false;">2</a> -->
<div id="layerNo2">
<div class="layer">
	<br/><br/><br/>
	<div class="bg"></div>
	<div id="layer3" class="pop-layer">
		<div class="pop-container">
			<div class="pop-conts">
				<!--content //-->
				   <div class="container">
         
				      <div class="bs-docs-section">
				        <div class="row">
				          <div class="col-lg-6">
				            <div class="page-header">
				              <h1 id="forms">가입 신청서</h1>
				            </div>
				          </div>
				        </div>
				
				        <div class="row">
				          <div class="col-lg-6">
				            <div class="well bs-component">
				              <%-- <form action="/StudyMate/studyMain/layerTest.do"> --%>
				              <form action="javascript:apply();">
				                <fieldset>
				                  <legend>신청서 작성</legend>
				                 
				                 <%-- value="${studyGroup.idx}" --%>
				                  <input type="hidden" id="studyGroupIdx" name="studyGroupIdx"/>
				                  
				                  <div class="form-group">
				                    <label for="textArea" class="col-lg-2 control-label">사유</label>
				                    <div class="col-lg-10">
				                   <textarea name="reason" id="reason" class="form-control" rows="5"></textarea>
				                      
				                      <span class="help-block">스터디 조장의 승인/반려 과정을 통해 가입이 진행됩니다.</span>
				                    </div>
				                  </div>
				              
				                  <div class="form-group">
				                    <div class="col-lg-10 col-lg-offset-2">
				                      <button type="submit" class="btn btn-primary">신청하기</button>
				                    </div>
				                  </div>
				                </fieldset>
				                
				              </form>
				            </div>
				          </div>
				          </div>
				          </div>
				          	          
				      </div>
				
				<!--// content-->
				<div class="btn-r">
					<a id="closeBtn" href="#" class="cbtn">Close</a>
				</div>
			</div>
		</div>
	</div>
</div>      
</div>
		              



<%@ include file="../include/footer1.jsp"%>




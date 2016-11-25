<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header1.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<style type="text/css">
.click:hover {
	background-color: #ffa;
	cursor: pointer;
}body{
 background:#EEEEEE;    
}.user-profile-2 {
    text-align: center;
    position: relative;
    margin-top:10px;
}.box-info {
    position: relative;
    padding: 15px;
    background: #fff;
    color: #5b5b5b;
    margin-bottom: 20px;
    -webkit-transition: All 0.4s ease;
    -moz-transition: All 0.4s ease;
    -o-transition: All 0.4s ease;
    border-bottom:4px solid #DDDDDD;
}.user-profile-2 .header-cover {
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    height: 130px;
    overflow: hidden;
    z-index: 1;
}.user-profile-2 .user-profile-inner {
    z-index: 2;
    position: relative;
}.user-profile-2 .user-profile-inner h4.white {
    color: #fff;
}.user-profile-2 .user-profile-inner img.profile-avatar {
    box-shadow: 0 0 0 5px rgba(255,255,255,1);
    -moz-box-shadow: 0 0 0 5px rgba(255,255,255,1);
    -webkit-box-shadow: 0 0 0 5px rgba(255,255,255,1);
    border: none;
    width:100px;
    height:100px;
}.user-button {
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
</style>
<script>

//10.20 성경
//create study -> error 메세지 관련
window.onload=fnInit;
function fnInit(){
	
	var errmsg = $("#errorItem").val();
	//var errmsg = document.getElementById('errorItem').val();
	
	if(errmsg==""){
		//alert("ㅎ");  
	}else{ //error메세지가 들어오면 alert띄우고 모달 다시클릭
		$("#createBtn").click();
		alert(errmsg);
	} 

}

$(function() {
  /*   $("tr[data-url]").click(function() {
        location.href = $(this).attr("data-url");
    }); */
    $("div.pagination a").click(function() {
        $("input[name=pg]").val($(this).attr("data-page"));
        $("form").submit();
    });
    $("[data-auto-submit=true]").change(function() {
        $(this).parents("form").submit();
    });
});
</script>
<div class="container">
	<div class="bs-docs-section">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-header">
					<br />
					<h2 id="tables">My Study List</h2>
					<br />					
					<a  id="createBtn" href="/StudyMate/studyMain/studyCreate.do" role="button" data-backdrop="static" class="btn btn-primary col-xs-offset-10" data-toggle="modal" data-target="#myModal3">create study</a>
				</div>
			</div>
		</div>
	</div>
</div>
<form:form method="get">
<input type="hidden" name="pg" value="1" />
<div class="container bootstrap snippet">
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
    			<a href="/StudyMate/studyRoom/board/boardList.do?idx=${ studyGroup.idx }">
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
    			</a>
    			<h5>${studyGroup.leaderName}</h5>
    			<h6>${studyGroup.studyGroupIntro}</h6>
    			<h6>${studyGroup.studyGroupGoal}</h6>
    			<h6>${studyGroup.studyGroupTerm}</h6>
    				
    			<div class="user-button">
    				<div class="row">
    					<div class="col-md-12">
    						<a href="/StudyMate/studyRoom/board/boardList.do?idx=${ studyGroup.idx }" type="button" class="btn btn-default btn-sm btn-block"><i class="fa fa-envelope"></i>StudyRoom</a>
    					</div>
    				</div>
    			</div> 
    		</div>
    	</div>
    </div>   
  </c:forEach>	
</div>	
		<!-- pagination -->
		<div class="container bootstrap snippet">
			<div class="col-sm-6">		
				<ul class="pagination">
					<c:forEach var="page" items="${ pages }">
						<li class='${ page.active }'>
						<a href="/StudyMate/studyMain/studyListForLeader.do?pg=${ page.number }">${ page.label }</a></li>
					</c:forEach>
				</ul>
			</div>
			</div>
</form:form>

<input type="hidden" id="errorItem" value="${error}">

<!-- Modal -->
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
    </div>
  </div>
</div>


<%@ include file="../include/footer1.jsp"%>



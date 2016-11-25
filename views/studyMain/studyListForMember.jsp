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
</style>

<script>
$(function() {
    $("tr[data-url]").click(function() {
        location.href = $(this).attr("data-url");
    });

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

	<!-- 스터디 리스트 Table ================================================== -->

	<div class="bs-docs-section">

		<div class="row">
			<div class="col-lg-12">
				<div class="page-header">
					<br />
					<h2 id="tables">My Study List</h2>
					<br />
					
				</div>
			</div>
		</div>
	</div>
</div>



<div class="container bootstrap snippet">
<c:forEach var="studyGroup" items="${list}">
    <div class="col-sm-4">
    	<!-- Begin user profile -->
    	<div class="box-info text-center user-profile-2">
    		<div class="header-cover">
    			<!-- //[유리방금추가] 시작 -->
				    				<c:set var="none2" value="true"/>
					    		<c:forEach var="groupImages" items="${groupImages}">
							   			<c:if test="${studyGroup.studyGroupIdx eq groupImages.studyGroupIdx}">
							   			<img src="/StudyMate/studyGroupImage/${groupImages.fileName}" style="height: 130px; width: 350px;" alt="User cover">
							   			<c:set var="none2" value="false"/>  			
							   			</c:if>
							   				
							   			<c:if test="${studyGroup.studyGroupIdx ne groupImages.studyGroupIdx}">	
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
    			<!-- <div class="user-button">
    				<div class="row">
    					<div class="col-md-6">
    						<button type="button" class="btn btn-primary btn-sm btn-block"><i class="fa fa-envelope"></i> 상세보기</button>
    					</div>
    					<div class="col-md-6">
    						<button type="button" class="btn btn-default btn-sm btn-block"><i class="fa fa-user"></i> 가입하기</button>
    					</div>
    				</div>
    			</div> 1018 임시 주석-->
    			
    			<!-- 추가 -->
    			<div class="user-button">
    				<div class="row">
    					<div class="col-md-12">
    						<a href="/StudyMate/studyRoom/board/boardList.do?idx=${ studyGroup.studyGroupIdx }" type="button" class="btn btn-default btn-sm btn-block"><i class="fa fa-envelope"></i>StudyRoom</a>
    					</div>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>   
    	</c:forEach>	
</div>	




<%@ include file="../include/footer1.jsp"%>








<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header1.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
.click:hover {
	background-color: #ffa;
	cursor: pointer;
}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script>
$(function() {
    $("tr[data-url]").click(function() {
        location.href = $(this).attr("data-url");
    });

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

	<!-- 스터디 리스트 Table ================================================== -->

	<div class="bs-docs-section">

		<div class="row">
			<div class="col-lg-12">
				<div class="page-header">
					<br />
					<h2 id="tables">My Study List</h2>
					<br />
					
					<a href="/StudyMate/studyMain/studyCreate.do"
						class="btn btn-primary col-xs-offset-10">create study</a>
				</div>
			</div>
		</div>

		<form:form method="get">
			<input type="hidden" name="pg" value="1" />
			<div class="bs-component">

				<form:select path="ss">
					<form:option value="0" label="전체보기" />
					<form:option value="1" label="스터디 이름 검색" />
					<form:option value="2" label="스터디 소개글 검색" />
					<form:option value="3" label="스터디 목표 검색" />
				</form:select>
				<form:input path="st" />
				<button type="submit" class="btn btn-small" style="height: 30px">검색</button>
				<c:if test="${ pagination.ss != 0 }">
					<a href="studyList.do" class="btn btn-small">취소</a>
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
				<table class="table table-striped table-hover ">
					<thead>
						<tr>
							<th>조장 이름</th>
							<th>스터디 이름</th>
							<th>스터디 목표</th>
							<th>활동 기간</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="myStudyGroup" items="${list}">
							<!-- <tr data-url="/StudyMate/studyMain/applicationForm.do?idx=${studyGroup.idx}"> -->
								<tr data-url="/StudyMate/studyRoom/board/boardList.do?idx=${ myStudyGroup.studyGroupIdx }">
								<td>${myStudyGroup.leaderName}</td>
								<td>${myStudyGroup.studyGroupName}</td>
								<td>${myStudyGroup.studyGroupGoal}</td>
								<td>${myStudyGroup.studyGroupTerm}</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>

			<!-- pagination -->
			<div class="pagination pagination-small pagination-centered">
				<ul>
					<c:forEach var="page" items="${ pages }">
						<li class='${ page.active }'><a
							href="/StudyMate/studyMain/studyListForMember.do?pg=${ page.number }">${ page.label }</a></li>
					</c:forEach>
				</ul>
			</div>

		</form:form>
	</div>
</div>


<!-- 승인대기중 스터디 리스트 Table ================================================== -->

<div class="bs-docs-section">

		<div class="row">
			<div class="col-lg-12">
				<div class="page-header">
					<h3 id="tables">승인 대기중 . . .</h3>
				</div>


				<div class="bs-component">
					<table class="table table-striped table-hover ">

						<thead>
							<tr>
								<th>No.</th>
								<th>조장</th>
								<th>스터디 소개</th>
								<th>활동 기간</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${standByList}" var="StudyGroup">
								<tr class="click" onclick="goDetail(${StudyGroup.idx});">
									<td>${StudyGroup.idx}</td>
									<td>${StudyGroup.leaderId}</td>
									<td>${StudyGroup.studyGroupName}</td>
									<td>${StudyGroup.studyGroupIntro}</td>
									<td>${StudyGroup.studyGroupTerm}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>


<%@ include file="../include/footer1.jsp"%>
 --%>
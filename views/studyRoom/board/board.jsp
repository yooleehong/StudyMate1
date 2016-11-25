<%@ include file="../../include/header2.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Bootstrap-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script type="text/javascript">
//채팅창을 팝업창으로 띄워줌.
	function popUpChat(){
		var idx = ${idx};
		var popUrl = "/StudyMate/studyRoom/board/tempChat.do?idx="+idx;
		var popOption = "width=400, height=500, resizable=yes, menubar=no, directories=no, location=no"
		
		window.open(popUrl,"",popOption);
	}
</script>

<body>


<div class="wrapper">

	<div class="sidebar" data-background-color="white" data-active-color="danger">

    <!--
		Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
		Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
	-->

    	<div class="sidebar-wrapper">
            <div class="logo">
                <div class="simple-text">${GroupName}</div>
                        <br/>
                <img src="${route}" style="width:80%; align:center; height:180px;"><br/>
                     
            </div>
            <ul class="nav">
                <li>
                    <a href="/StudyMate/studyRoom/schedule/schedule.do?idx=${idx}">
                        <i class="ti-calendar"></i>
                        <p>일정관리</p>
                    </a>
                </li>
                <li>
                    <a href="/StudyMate/studyRoom/fileShare/fileUpload.do?idx=${idx}">
                        <i class="ti-cloud-up"></i>
                        <p>자료공유</p>
                    </a>
                </li>
                <li class="active">
                    <a href="/StudyMate/studyRoom/board/boardList.do?idx=${idx}">
                        <i class="ti-view-list-alt"></i>
                        <p>게시판</p>
                    </a>
                </li>
                <li>
                    <a href="/StudyMate/studyRoom/document/document.do?idx=${idx}">
                        <i class="ti-text"></i>
                        <p>동시문서작성</p>
                    </a>
                </li>
                <li>
                    <a href="/StudyMate/studyRoom/locate/locate.do?idx=${idx}"> <!-- [10월2일추가] -->
                        <i class="ti-map"></i>
                        <p>주변 검색</p>
                    </a>
                </li>
                 <li>
                    <a href="/StudyMate/streaming/StreamBoard.do?idx=${idx}">
                        <i class="fa fa-caret-square-o-right" aria-hidden="true"></i>
                        <p>동영상 공유</p>
                    </a>
                </li>
                 <li>
                    <a href="/StudyMate/streaming/webcam/board.do?idx=${idx}"><!-- [10월1일수정] -->
                        <i class="glyphicon glyphicon-facetime-video" aria-hidden="true"></i>
                        <p>WEBCAM ROOM</p>
                    </a>
                </li>
                
              
			 	<li>
			 		<a href="javascript:popUpChat();">
			 			<i class="fa fa-comments-o"></i>
			 			<p>채팅</p>
			 		</a>
			 	</li>
            </ul>
       </div>
    </div>
   
   <div class="main-panel" >
 
      <nav class="navbar navbar-default">
            <div class="container-fluid">
                
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="/StudyMate/studyMain/studyRecommendList.do">
                                <i class="ti-home"></i>
                        		<p>Home</p>
                            </a>
                        </li>
                        <c:set var="leader" value="${leader}"/>
                        <c:if test="${'yes' eq leader}">
                        <li>
                            <a href="/StudyMate/studyManage/applicantListForLeader.do?idx=${idx}">
                                <i class="fa fa-bullhorn"></i>
                        		<p>신청자보기</p>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-bug"></i>
                        		<p>스터디그룹 삭제</p>
                            </a>
                        </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
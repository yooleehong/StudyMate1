<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../../include/header2.jsp" %>
<!-- Bootstrap-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

            <ul class="nav">
                <li>
                    <a href="/StudyMate/studyRoom/schedule/schedule.do?idx=${studyGroupIdx}">
                        <i class="ti-calendar"></i>
                        <p>일정관리</p>
                    </a>
                </li>
                <li>
                    <a href="/StudyMate/studyRoom/fileShare/fileUpload.do?idx=${studyGroupIdx}">
                        <i class="ti-cloud-up"></i>
                        <p>자료공유</p>
                    </a>
                </li>
                <li >
                    <a href="/StudyMate/studyRoom/board/boardList.do?idx=${studyGroupIdx}">
                        <i class="ti-view-list-alt"></i>
                        <p>게시판</p>
                    </a>
                </li>
                <li>
                    <a href="/StudyMate/studyRoom/document/document.do?idx=${studyGroupIdx}">
                        <i class="ti-text"></i>
                        <p>동시문서작성</p>
                    </a>
                </li>
                <li>
                    <a href="locate.jsp">
                        <i class="ti-map"></i>
                        <p>약속장소정하기</p>
                    </a>
                </li>
                 <li class="active" >
                    <a href="/StudyMate/streaming/StreamBoard.do?idx=${studyGroupIdx}">
                        <i class="glyphicon glyphicon-facetime-video" aria-hidden="true"></i>
                        <p>동영상 공유</p>
                    </a>
                </li>
                
                  <li class="active" >
                    <a href="/StudyMate/streaming/webcam/board.do?idx=${studyGroupIdx}">
                        <i class="glyphicon glyphicon-facetime-video" aria-hidden="true"></i>
                        <p>WEBCAM ROOM</p>
                    </a>
                </li>

            </ul>
    	</div>
    </div>
   
   <div class="main-panel">
 
		<nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">WEBCAM ROOM</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-home"></i>
								<p>Home</p>
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="ti-bell"></i>
									<p>MyPage</p>
									<b class="caret"></b>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="/StudyMate/studyManage/applicantListForLeader.do?idx=${idx}">신청자보기</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                              </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


<!DOCTYPE html>
<html lang="ko">
<head>

<title>업로드</title>

    <script type="text/javascript">
        $(document).ready(function(){
            $("#list").on("click", function(e){ //목록으로 버튼
                e.preventDefault();
                fn_openBoardList();
            });

        });
        function eventonload()
        {
         location.href ='/StudyMate/streaming/webcam/boardDtails.do?idx=${idx}&${ pagination.queryString }';      	
        	}

    </script>
    <style type="text/css">
    div.enter{
    	margin-top: 10em;
    
    }
    
    </style>
</head>
<body onload="eventonload()">
	<div class="container">
     

    
    </div>
  	

      
</body>
</html>
<%@ include file="../../include/footer2.jsp"%>
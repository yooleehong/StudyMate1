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
                 <li>
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
                                <li><a href="/StudyMate/studyManage/applicantListForLeader.do?idx=${studyGroupIdx}">신청자보기</a></li>
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
	 <html> 
	 <head>
	 
	  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
	   <link href="http://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" media="screen"> 
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script> 
	   <style>
	    thead tr { background: #eee; } 
	    tbody tr:hover { background-color: #ffa; cursor: pointer; } 
	    div.form-inline { margin-bottom: 5px; }
	    div.row{margin-top: 3em;}
	    div.page-header{margin-left: 3em;}
	    /*[수정]스타일 변경*/
	    
	    /*탭 스타일*/
	    .input.a{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff; height:19px;}
		.textarea{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff;}


	     </style>
	     
	    	     <script>
	     $(function() {
			$("button.Comments").click(function() { 
	  	    	  location.href = $(this).attr("data-url");
	  	 	    }); //[수정] 스크립트 추가 
	     
	   
	    	
	    	 $("tbody tr").click(function() {
	    		 location.href = $(this).attr("data-url");

		 
	    	  
	     });
	  	 	    
	     $("div.pagination a").click(function()
	    		 { $("input[name=pg]").val($(this).attr("data-page")); $("form").submit(); });
	     }); 
	     
	 
	     
	     </script> 
	     
	     </head>
	<body>
	
	
	
   <div class="container">
   
   		        <div class="row">
		          <div class="col-lg-12">
		            <div class="page-header">
		              <h1 id="forms">WEBCAM ROOM</h1>
		            </div>
		          </div>
		        </div>
		        
      <div class="bs-docs-section">
        
		<form:form method="get" modelAttribute="pagination">
		 <input type="hidden" name="pg" value="1" />
		 <input type="hidden" name="idx" value=${ pagination.idx } />
		  <div class="form-inline">
		   <form:select path="ss">
		    <form:option value="0" label="검색조건" />
		     <form:option value="1" label="idx" /> 
		    <form:option value="2" label="Title" />
		       </form:select> 
		       
		       <form:input path="st" /> 
		       <button type="submit" class="btn btn-small">검색</button> 
		       </div>
		  <table class="table table-bordered"> 
		  <thead>
		   <tr>
		    <th>Idx</th>
		     <th>title</th>
		          </tr>
		   </thead> 
		   <tbody> 
		   <c:forEach var="board" items="${ list }"> 
		   
		   <tr data-url="authority.do?idx=${board.idx}&${ pagination.queryString }"> <!-- 이동페이지 보드 idx실어서 보냄 /받는컨트롤러에 pagination 추가 -->
		    <td>${ board.idx }</td> 
		    <td>${ board.title }</td> 
		        </tr>
	        </c:forEach> 
	        
		    </tbody>
		     </table> 
		     
		     <div class="pagination pagination-small pagination-centered">
		      <ul> <c:forEach var="page" items="${ pagination.pageList }">
		       <li class='${ page.cssClass }'>
		       <a data-page="${ page.number }">
		       ${ page.label }</a>
		       </li>
		        </c:forEach>
		</ul>
		 </div>
		 </form:form>
		  
		     </div>
  				 <button class="btn" onclick=" location.href ='/StudyMate/streaming/webcam/create.do?idx=${studyGroupIdx}&${ pagination.queryString }'">CREATE</button> <!--업로드 페이지로 --> 			 
  			  </div>		
		    </body>
		     </html>
<%@ include file="../../include/footer2.jsp"%>
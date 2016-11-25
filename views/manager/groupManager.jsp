<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	    /*탭 스탈 변경*/
	    
	    .input.a{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff; height:19px;}
		.textarea{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff;}


	     </style>
	     
	     <script>
	     $(function() { $("tbody tr").click(function() {
	    	 
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
		          <h1 id="forms">GroupManager</h1>
		            </div>
		          </div>
		        </div>
		        
      <div class="bs-docs-section">
        
		<form:form method="get" modelAttribute="pagination">
		 <input type="hidden" name="pg" value="1" />
		  <div class="form-inline">
		   <form:select path="ss">
		    <form:option value="0" label="검색조건" /> 
		    <form:option value="1" label="고유번호" />
		     <form:option value="2" label="리더아이디" />
		      <form:option value="3" label="그룹이름" />
		       </form:select> 
		       
		       <form:input path="st" /> 
		       <button type="submit" class="btn btn-small">검색</button> 

		       </div>
		  <table class="table table-bordered"> 
		  <thead>
		   <tr>
		    <th>idx</th>
		   	<th>leaderName</th>
		     <th>leaderIdx</th>
		      <th>studyGroupName</th>
		          </tr>
		   </thead> 
		   <tbody> 
		   <c:forEach var="StudyGroup" items="${ list }"> 
		   <tr data-url="groupDetails.do?idx=${StudyGroup.idx}&${ pagination.queryString }"> <!-- 이동페이지 유저의idx실어서 보냄 /받는컨트롤러에 pagination 추가 -->
		    <td>${ StudyGroup.idx }</td> 
		    <td>${ StudyGroup.leaderName }</td> 
		    <td>${ StudyGroup.leaderIdx }</td> 
		    <td>${ StudyGroup.studyGroupName }</td>
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
   
  			  </div>

		    </body>
		          	
 
		     </html>

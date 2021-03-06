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
	    /*[수정]스타일 변경*/
	    
	    /*탭 스타일*/
	    .input.a{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff; height:19px;}
		.textarea{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff;}


	     </style>
	     
	     <script>
	     $(function() {
	    	 
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
		              <h1 id="forms">Comments</h1>
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
		    <form:option value="1" label="댓글userIdx" />
		    <form:option value="2" label="리플userIdx" />
		     <form:option value="3" label="댓글" />
		      <form:option value="4" label="RE댓글" />
		       </form:select> 
		       
		       <form:input path="st" /> 
		       <button type="submit" class="btn btn-small">검색</button> 
		       </div>
		  <table class="table table-bordered"> 
		  <thead>
		   <tr>
		    <th>commentIdx</th>
		     <th>studyGroupBoardIdx</th>
		    <th> userIdx</th>
		      <th>userID</th>
		      <th>commentContents</th>
		       <th>repleUserIdx</th>
		        <th>repleCommentContents</th>
		          </tr>
		   </thead> 
		   <tbody> 
		   <c:forEach var="comment" items="${ list }"> 
		   <tr>
					<td>${ comment.idx }</td>
					<td>${ comment.studyGroupBoardIdx }</td>
					<td>${ comment.userIdx }</td>
					<td>${ comment.userId }</td>
					<td>${ comment.commentContents }</td>
					<td>${ comment.repleUserIdx }</td>
					<td>${ comment.repleCommentContents }</td>
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
  				 <button onclick=" location.href ='/StudyMate/manager/groupManager.do'">돌아가기</button> <!-- [수정] 위로이동 -->
  			  </div>

			
		    </body>
		          	
 
		     </html>

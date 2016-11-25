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
		div.container{margin-top: 3em;} 
		div.page-header{margin-left: 3em;}
	     </style><!-- page-header 스타일 변경-->
	     
		<script>
	     $(function() {
	    	 
	    	 $("tbody tr").click(function() {
	    		 location.href = $(this).attr("data-url");
		    	 
		     });
	    	 
	    	 
	    	 
	    	  	$("button.delete").click(function() { 
	    	  		 if (confirm("삭제하시겠습니까?")){
	    		    	  location.href = $(this).attr("data-url");
	    		     }else{
	    		
	    		     } 
	    	  		 
	  	 	    });

	    	  	$("button.back").click(function() { 
	  	    	  location.href = $(this).attr("data-url");
	  	 	    });
	    
	     
	     }); 
	 
	     
	     </script> 
	     
	     </head>
	<body>
  
      
   <div class="container">
            	<div class="row">
		          <div class="col-lg-12">
		            <div class="page-header">
		              <h1 id="forms">GroupDetail</h1>
		            </div>
		          </div>
		        </div>
		        
       <table class="table table-bordered"> 
		  <thead>
		   <tr >
		    <th>idx</th>
		     <th>leaderIdx</th>
		     <th>leaderName</th>
		      <th>studyGroupName</th> <!--[추가] -->
		       <th>personnelNumber</th> <!--[수정] -->
		       <th>studyGroupIntro</th>
		        <th>studyGroupTerm</th>
		       	 <th>studyGroupGoal</th>
		       	 	<th>studyGroupContents</th>
		          </tr>
		   </thead> 
		   <tbody> 
		   <tr data-url="boardManager.do?idx=${StudyGroup.idx}"> <!-- 이동페이지 유저의idx실어서 보냄 /받는컨트롤러에 pagination 추가 -->
		    <td>${ StudyGroup.idx }</td> 
		    <td>${ StudyGroup.leaderIdx }</td> 
		    <td>${ StudyGroup.leaderName }</td> <!--[추가] -->
		    <td>${ StudyGroup.studyGroupName }</td>
		     <td>${ StudyGroup.memberCounter } / ${ StudyGroup.maxCounter }</td>
		      <td>${ StudyGroup.studyGroupIntro }</td>
		       <td>${ StudyGroup.studyGroupTerm }</td>
		       <td>${ StudyGroup.studyGroupGoal }</td>
		       <td>${ StudyGroup.studyGroupContents }</td>
		        </tr>
		    </tbody>
		     </table> 
		<button class="delete" data-url="groupDelete.do?idx=${StudyGroup.idx}">삭제</button>	
        <button class="back" data-url="groupManager.do">돌아가기</button>	   
      </div>
      
      
</body>
</html>



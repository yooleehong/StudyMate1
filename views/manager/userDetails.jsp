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
	    div.row{margin-top: 3em;}
	    div.page-header{margin-left: 3em;}
	    /*[수정]스타일 변경*/
	    
	    /*탭 스타일*/
	    .input.a{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff; height:19px;}
		.textarea{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff;}


	     </style>
	     <script type="text/javascript">
	     $(function() {
	   		  $("#delete").click(function() {    	 
			  		 if (confirm("삭제하시겠습니까?")){
				    	  location.href = $(this).attr("data-url");
				     }else{	 
				    	 
				     } 
	   	 	 });
	     }); 
	     </script>
	     
	     </head>
	<body>
	
	
	
   <div class="container">
   
   		        <div class="row">
		          <div class="col-lg-12">
		            <div class="page-header">
		              <h1 id="forms">Button to Select</h1>
		            </div>
		          </div>
		        </div>
		        <br><br><br><br>
		        <center>
	 <button type="button" class="btn btn-danger" style="width: 3.5cm; height: 1cm;  border-radius: 20px;" id="delete" data-url="userDelete.do?idx=${ idx }&${ pagination.queryString }">삭제하기</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 <button type="button" class="btn btn-primary" style="width: 3.5cm; height: 1cm;  border-radius: 20px;" onclick=" location.href ='/StudyMate/manager/userPasswdUpdate.do?idx=${ idx }&${ pagination.queryString }'">비번변경</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <button type="button" class="btn btn-primary" style="width: 3.5cm; height: 1cm;  border-radius: 20px;" onclick=" location.href ='/StudyMate/manager/userEmailUpdate.do?idx=${ idx }&${ pagination.queryString }'">이메일변경</button>
					</center>
  				
  			 
  			  </div>

			
		    </body>
		          	
 
		     </html>

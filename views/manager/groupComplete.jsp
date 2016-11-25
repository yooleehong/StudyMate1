<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<!DOCTYPE html>
	 <html> 
	 <head>
	 
	  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
	   <link href="http://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" media="screen"> 
	  <link rel="stylesheet" href="font-awesome.min.css">
	  
	   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script> 
	   <style>
	    thead tr { background: #eee; } 
	    tbody tr:hover { background-color: #ffa; cursor: pointer; } 
	    div.form-inline { margin-bottom: 5px; } </style>
<script type='text/javascript'>
function eventonload()
{
	alert('삭제완료.');
 location.href ='/StudyMate/manager/groupManager.do?${ pagination.queryString }';
	
	}
</script>

</head>
	<body onload="eventonload()">

	

	</body>
		          	
 
		     </html>

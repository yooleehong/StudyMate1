<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../studyRoom/board/board.jsp"%>
	 

<script type='text/javascript'>
function eventonload()
{
 location.href ='/StudyMate/streaming/StreamDetails.do?idx=${stream.idx}';
	}
</script>

	<body onload="eventonload()">

	

	</body>
		          	


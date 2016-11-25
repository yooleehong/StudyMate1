<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../studyRoom/board/board.jsp"%>
	 

<script type='text/javascript'>
function eventonload()
{
	alert('삭제완료.');
 location.href ='/StudyMate/streaming/StreamBoard.do?${ pagination.queryString }';
	}
</script>

	<body onload="eventonload()">

	

	</body>
		          	

<%@ include file="../include/footer2.jsp"%>
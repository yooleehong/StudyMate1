<%@ page language="java" contentType="application/vnd.ms-word; charset=euc-kr" pageEncoding="euc-kr"%>
<%  
System.out.println("documentDown.jsp ������ ����.");
response.setHeader("Content-Description", "JSP Generated Data");   
response.setHeader("Content-Disposition", "attachment;filename=StudyMate.doc");

%>
<html>
<head>

</head>
<body>
${ contents }
</body>
</html>
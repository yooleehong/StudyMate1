<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<!--부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<title>관리자 페이지</title>
<style>
div.row{
	margin-top: 10em;

}
img.img1{
	width: 2cm;
	height: 2cm;
}
img.img2{
	width: 1.8cm;
	height: 1.8cm;
}
div.enter{
	margin-top: 2em;

}
span.m{
	margin-left: 10cm;

}

</style>

</head>
<body>
	<div class="row">
		<div class="col-xs-4 col-md-2"></div> <!-- Grid-System tag-->
		<div class="col-xs-4 col-md-2" style="width: 20cm; height: 20cm;" > <!--정렬을 위한 div-->

			<!-- 아이프레임 -->
			<center>
			<span class="m"></span> <!--정렬 span-->
				<a href="/StudyMate/manager/groupManager.do" target="down">
				<img class="img1" src="http://image.flaticon.com/icons/svg/33/33308.svg"> <!--Group Image-->
				</a>
				&nbsp;&nbsp;&nbsp;
				<a href="/StudyMate/manager/userManager.do" target="down">
				<img class="img2" src="http://image.flaticon.com/icons/svg/32/32438.svg"> <!--User Image-->
				</a>
			</center>
			<div class="enter"></div> <!--정렬 div-->
				<iframe src="" name="down" width="1200" height="500" frameborder="0"
					marginwidth="0" marginheight="0" scrolling="auto" />


		</div>
		<div class="col-xs-4 col-md-2"></div> <!--정렬을 위한 div-->
		<div class="col-xs-4 col-md-2"></div>
		<div class="col-xs-4 col-md-2"></div>
	</div>




</body>
</html>
 <%@ include file="../include/footer1.jsp" %>
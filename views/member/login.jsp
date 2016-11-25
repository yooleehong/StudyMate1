<%-- <%@ include file="../include/header1.jsp"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<meta charset="utf-8">
<title>StudyMate</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
body{
    margin-top:20px;
    color:#fff;
}.login-page {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    overflow: auto;
    background: #2E406A;
    text-align: center;
    color: #fff;
    padding: 3em;
}.user-avatar {
    width: 125px;
    height: 125px;
}.login-page h1 {
    font-weight: 300;
}.login-page .form-content {
    padding: 40px 0;
}.login-page .form-content .input-underline {
    background: 0 0;
    border: none;
    box-shadow: none;
    border-bottom: 2px solid rgba(255,255,255,.4);
    color: #FFF;
    border-radius: 0;
}.login-page .form-content .input-underline:focus {
    border-bottom: 2px solid #fff;
}    
.input-lg {
    height: 46px;
    padding: 10px 16px;
    font-size: 18px;
    line-height: 1.3333333;
    border-radius: 0;
}.btn-info{
    border-radius: 50px;
    box-shadow: 0 0 0 2px rgba(255,255,255,.8)inset;
    color: rgba(255,255,255,.8);
    background: 0 0;
    border-color: transparent;
    font-weight: 400;
}input[type='text']::-webkit-input-placeholder, input[type='password']::-webkit-input-placeholder { 
    color:    #fff;
}input[type='text']:-moz-placeholder, input[type='password']:-moz-placeholder { 
    color:    #fff;
}input[type='text']::-moz-placeholder, input[type='password']::-moz-placeholder { 
    color:    #fff;
}input[type='text']:-ms-input-placeholder, input[type='password']:-ms-input-placeholder { 
    color:    #fff;
}</style>
</head>
<body>
<div class="container bootstrap snippet">
    <div class="row login-page"> 
        <div class="col-md-4 col-lg-4 col-md-offset-4 col-lg-offset-4" style="margin-top: 7%"> 
    		<img src="/StudyMate/resources/images/icon-main.png"> 
    		<!-- <h1>STUDY MATE</h1> 
    		 -->
    		<form method="post" action="/StudyMate/member/login_processing.do" role="form" class="ng-pristine ng-valid"> 
    			<div class="form-content"> 
    				<div class="form-group"> 
    					<input type="text" class="form-control input-underline input-lg" name="loginId" placeholder="ID"> 
    				</div> 
    				<div class="form-group"> 
    					<input type="password" class="form-control input-underline input-lg" name="password" placeholder="Password"> 
    				</div> 
    			</div> 
    			<button type="submit" class="btn btn-info btn-lg">
                    Log in
    			</button> &nbsp; 
    			<a href="/StudyMate/member/join.do" type="button" class="btn btn-info btn-lg">Register</a>
    		</form> 
    		
    		<a href="/StudyMate/member/user/findId.do">ID찾기/</a> 
			<a href="/StudyMate/member/user/findPw.do">password찾기</a>
    		
    	</div> 
    </div>
</div>
<c:if test="${ not empty success }">
   ${ success }
</c:if>
</body>
</html>
<%-- 
	<!-- Forms
   ================================================== -->
	<div class="container">
		<div class="bs-docs-section" >
			<div class="row">
				<div class="col-lg-12">
					<div class="page-header" >
						<h1 id="forms" style="text-align: center; padding-top:7%">로그인</h1>
					</div>
				</div>
			</div>
			
			<div>
			<div class="row" >
				<div class="col-lg-4 col-lg-offset-4">
					<form class="bs-component" method="post" action="/StudyMate/member/login_processing.do">
						<div class="form-group">
							<label class="control-label" for="inputDefault">ID</label> 
							<input type="text" class="form-control" name="loginId" placeholder="Input Id">
						</div>
						<div class="form-group">
							<label for="inputPassword" class="control-label">password</label>
							<input type="password" class="form-control" name="password" placeholder="Input Password">
						</div>
						<div class="form-group">
							<div>
								<button type="submit" class="btn btn-primary btn-lg btn-block">login</button>
							</div>
						</div>
					</form>
					<div class="col-xs-offset-5" style="color: #000000">
						<br /> 
						<a href="member/join.do">회원가입</a> &nbsp; &nbsp; 
						<a href="/StudyMate/member/user/findId.do">ID찾기/</a> 
						<a href="findPw.do">password찾기</a>
					</div>
				</div>
			</div>
			
			</div>
		
			
		</div>
	</div>
		<c:if test="${ not empty success }">
        ${ success }
    </c:if>
</body>
</html>
 --%>

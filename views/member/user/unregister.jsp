<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../include/header.jsp" %>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container">
   
      <div class="bs-docs-section">
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="forms">회원 탈퇴</h1>
            </div>
          </div>
        </div>

	<div class="row">
	<div class="col-lg-4 col-lg-offset-1">
	
		<form:form method="post" modelAttribute="user" class="bs-component">
			<form:hidden path="idx" />
			
			<div class="form-group">
			<label>비밀번호 입력</label>
			<input type="password" name="password2" class="form-control">
			</div>
			
			<input type="submit" value="회원 탈퇴" class="btn btn-primary">
		</form:form>
		
		<a href="/StudyMate/member/user/myPage.do">메인으로</a>
	</div>
	
	</div>
	</div>
	
	
	<div>
		<c:if test="${ not empty error }">
				<div class="alert alert-error">${ error }</div>
			</c:if>
			<c:if test="${ not empty success }">
				<div class="alert alert-success">${ success }</div>
			</c:if>
	</div>
	
	</div>
</body>
</html>
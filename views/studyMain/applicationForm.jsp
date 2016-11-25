<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header1.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

  
  
   <!-- Forms ================================================== -->
      
   <div class="container">
         
      <div class="bs-docs-section">
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="forms">가입 신청서</h1>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-6">
            <div class="well bs-component">
              <form:form method="post" class="form-horizontal" modelAttribute="applicationForm">
                <fieldset>
                  <legend>신청서 작성</legend>
                  <form:input type="hidden" path="userIdx" value="${user.idx}" />
                  <form:input type="hidden" path="studyGroupIdx" value="${studyGroup.idx}" />
                  
                  <div class="form-group">
                    <label for="textArea" class="col-lg-2 control-label">사유</label>
                    <div class="col-lg-10">
                      <form:input path="reason" class="form-control" rows="5" />
                      <span class="help-block">스터디 조장의 승인/반려 과정을 통해 가입이 진행됩니다.</span>
                    </div>
                  </div>
              
                  <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                      <button type="reset" onclick="page_back();" class="btn btn-default">돌아가기</button>
                      <button type="submit" class="btn btn-primary">신청하기</button>
                    </div>
                  </div>
                </fieldset>
                
              </form:form>
            </div>
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
      
<%@ include file="../include/footer1.jsp" %>
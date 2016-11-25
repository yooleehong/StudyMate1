<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header1.jsp" %>
  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  

   <!-- 신청 Forms ================================================== -->
      
   <div class="container">
         
      <div class="bs-docs-section">
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="forms">study group 상세보기</h1>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-6">
            <div class="well bs-component">
              <form:form class="form-horizontal" modelAttribute="studyGroup">  
              
                <fieldset>
                  <legend>${studyGroup.studyGroupName}</legend>
                  
                   <div class="form-group">
                    <label for="inputEmail" class="col-lg-2 control-label">조장</label>
                    <div class="col-lg-10">
                      <form:input path="leaderName" class="form-control" readonly="true" />
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="inputEmail" class="col-lg-2 control-label">인원</label>
                    <div class="col-lg-10">
                      <form:input path="maxCounter" class="form-control" readonly="true" />
                    </div>
                  </div>
                  
				  <div class="form-group">
                    <label for="inputEmail" class="col-lg-2 control-label">목표</label>
                    <div class="col-lg-10">
                      <form:input  path="studyGroupGoal" type="text" class="form-control" id="count" value="" readonly="true" />
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="textArea" class="col-lg-2 control-label">내용</label>
                    <div class="col-lg-10">
                      <form:textarea path="studyGroupContents"  class="form-control" rows="3" readonly="true"></form:textarea>           
                    </div>
                  </div>
              
                  <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                      <a href="studyListAll.do" class="btn btn-default">돌아가기</a> 
                      <a href="applicationForm.do?idx=${studyGroup.idx}" class="btn btn-primary">가입하기</a>
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
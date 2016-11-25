<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="board.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
		
		
		
		<div class="content">
		 <!--========= form ============-->  
		 
           <form:form action="boardModify.do" modelAttribute="studyGroupBoard" method="post">
               <form:input type="hidden" path="studyGroupIdx" />
               <form:input type="hidden" path="idx" />
               <form:input type="hidden" path="userIdx" />
               <div class="row">
                  <div class="col-md-6">
                      <div class="form-group">
                      	  <label>&nbsp;&nbsp;제목</label>
                          <form:input type="text" class="form-control border-input" placeholder="title" path="boardTitle" />
                          
                      </div>
                  </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <div class="form-group">
                     <label>&nbsp;&nbsp;내용</label>
                     <form:input type="text" class="form-control border-input" placeholder="Here can be your description" path="boardContents" />
				  </div>
			    </div>
			  </div>
			  <a href="/StudyMate/studyRoom/board/boardList.do?idx=${studyGroupIdx}" class="btn btn-info btn-fill" >취소</a>
			  <button type="submit" class="btn btn_modify" >수정</button>
			</form:form>
		</div>


<%@ include file="../../include/footer2.jsp" %>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="board.jsp" %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 


<script type="text/javascript" src="/StudyMate/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

		<div class="content">
		
		 <!--========= form ============-->  
           <form:form id="frm" action="boardWrite.do" method="post" modelAttribute="studygroupboard">
                <div class="form-group">
                    <div class="col-lg-10">
                      <input type="hidden" value="${idx}" name="idx">
                    </div>
                  </div>
               <div class="row">
                  <div class="col-md-6">
                      <div class="form-group">
                      	  <label>&nbsp;&nbsp;제목</label>
                          <form:input type="text" class="form-control border-input" placeholder="title" path="boardTitle"/>
                      </div>
                  </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <div class="form-group">
                     <label>&nbsp;&nbsp;내용</label>
                  <!--    <textarea rows="5" class="form-control border-input" placeholder="Here can be your description" name="boardContents"></textarea>  -->
                  	<!-- 에디터에 적은 값이 안들어감 -->
				  	    <textarea name="boardContents" id="boardContents" class="smarteditor2" rows="22" style="width:auto;"></textarea>
				  </div>
			    </div>
			  </div>
			  

			  <a href="/StudyMate/studyRoom/board/boardList.do?idx=${idx}" class="btn btn-info btn-fill" >취소</a>
			  <button type="submit" class="btn btn-info btn-fill" >저장</button>
			</form:form>
		</div>
		
		<c:if test="${ not empty error }">
    		<script type='text/javascript'>alert('${ error }');</script>
    	</c:if>






<%@ include file="../../include/footer2.jsp" %>




<script type="text/javascript" src="/StudyMate/resources/smarteditor/js/init.js"></script>



<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="board.jsp" %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 


		<div class="content">
		
		 <!--========= form ============-->  
           <form:form action="boardWrite.do" method="post" modelAttribute="studygroupboard">
                <div class="form-group">
                    <div class="col-lg-10">
                      <input type="hidden" value="${idx}" name="idx">
                    </div>
                  </div>
               <div class="row">
                  <div class="col-md-6">
                      <div class="form-group">
                      	  <label>&nbsp;&nbsp;제목</label>
                          <form:input type="text" class="form-control border-input" placeholder="title" path="boardTitle"/>
                      </div>
                  </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                  <div class="form-group">
                     <label>&nbsp;&nbsp;내용</label>
                       <textarea rows="5" class="form-control border-input" placeholder="Here can be your description" name="boardContents">
				  </textarea>
				  </div>
			    </div>
			  </div>
			  
			  <a href="/StudyMate/studyRoom/board/boardList.do?idx=${idx}" class="btn btn-info btn-fill" >취소</a>
			  <button type="submit" class="btn btn-info btn-fill" >저장</button>
			</form:form>
		</div>
		
		<c:if test="${ not empty error }">
    		<script type='text/javascript'>alert('${ error }');</script>
    	</c:if>


<%@ include file="../../include/footer2.jsp" %>


 --%>
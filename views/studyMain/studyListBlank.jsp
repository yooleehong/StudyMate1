<!-- 로그인 -> 가입한 스터디가 없을 때  -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header1.jsp" %>


<style type="text/css">
  .click:hover { background-color: #ffa; cursor: pointer; }
</style>

<script>
	function go(idx){
		location.href = "studyDetail.do?idx="+idx;  //스터디 상세보기 페이지로 이동.
	}
</script>
      
      
   <div class="container">
   
      <!-- 스터디 리스트 Table ================================================== -->

      <div class="bs-docs-section">

        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="tables">Study List</h1>
              <br/>
              <h3>추천 스터디 목록</h3>
              <a href="studyCreate.do" class="btn btn-primary col-xs-offset-10">create study</a>  
            </div>
            

            <div class="bs-component">
              <table class="table table-striped table-hover ">
              
                <thead>
                  <tr>
					<th>No.</th>
                    <th>조장</th>
                    <th>스터디 이름</th>
                    <th>스터디 소개</th>
                    <th>활동 기간</th>
                  </tr>
                </thead>
                
                <tbody>
                 <c:forEach items="${list}" var="StudyGroup">
	                  <tr class="click" onclick="go(${StudyGroup.idx});">
	                    <td>${StudyGroup.idx}</td>
	                    <td>${StudyGroup.leaderId}</td>
	                    <td>${StudyGroup.studyGroupName}</td>
	                    <td>${StudyGroup.studyGroupIntro}</td>
	                     <td>${StudyGroup.studyGroupTerm}</td>
	                  </tr>
                  </c:forEach>
                </tbody>
                
              </table> 
            </div>
          </div>
        </div>
        
        
        <!-- ================== pagination ================== -->
         <div class="row col-xs-offset-4">
          <div class="col-lg-4">
            <div class="bs-component">
              <ul class="pagination pagination-sm">
                <li class="disabled"><a href="#">&laquo;</a></li>
                <li class="active"><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">&raquo;</a></li>
              </ul>
            </div>
          </div> 
      </div> 
      
      
    </div>
    
    
     <!-- 승인대기중 스터디 리스트 Table ================================================== -->
    
        <div class="bs-docs-section">

        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h3 id="tables">승인 대기중 . . .</h3>
            </div>
            

            <div class="bs-component">
              <table class="table table-striped table-hover ">
              
                <thead>
                  <tr>
					<th>No.</th>
                    <th>조장</th>
                    <th>스터디 이름</th>
                    <th>스터디 소개</th>
                    <th>활동 기간</th>
                  </tr>
                </thead>
                
                <tbody>
                  <c:forEach items="${standByList}" var="StudyGroup">
	                  <tr class="click" onclick="go(${StudyGroup.idx});">
	                    <td>${StudyGroup.idx}</td>
	                    <td>${StudyGroup.leaderId}</td>
	                    <td>${StudyGroup.studyGroupName}</td>
	                    <td>${StudyGroup.studyGroupIntro}</td>
	                     <td>${StudyGroup.studyGroupTerm}</td>
	                  </tr>
                  </c:forEach>
                </tbody>
                
              </table> 
            </div>
          </div>
        </div>
        
        
        <!-- ================== pagination ================== -->
         <div class="row col-xs-offset-4">
          <div class="col-lg-4">
            <div class="bs-component">
              <ul class="pagination pagination-sm">
                <li class="disabled"><a href="#">&laquo;</a></li>
                <li class="active"><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#">&raquo;</a></li>
              </ul>
            </div>
          </div> 
      </div> 
     
    </div>
    
    
    
  </div>
  
<%@ include file="../include/footer1.jsp" %>
  
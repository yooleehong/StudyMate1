<!-- 스터디 관리 탭 -> 내가 관리중인(내가 조장인) 스터디 리스트 목록 -->

<!-- 로그인 -> 가입한 스터디가 하나라도 있을 때  -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header1.jsp" %>

      
   <div class="container">
   
      <!-- 스터디 리스트 Table ================================================== -->

      <div class="bs-docs-section">

        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="tables">스터디 관리</h1>
              <br/>
              <h3>나의 스터디 목록</h3>
            </div>
            

            <div class="bs-component">
              <table class="table table-striped table-hover ">
              
                <thead>
                  <tr>
					<th >No.</th>
                    <th class="col-lg-7">스터디 이름</th>
                    <th></th>
                    <th></th>
                  </tr>
                </thead>
                
                <tbody>
                  <tr>
                    <td>1</td>
                    <td>Column content</td>
                    <td><a href="applicantList.jsp" class="btn btn-default">신청자 보기 <span class="badge">3</span></a></td>
                    <td><a><img src="../../resources/images/icon-note2.png"></a></td>
                  </tr>
                  <tr>
                    <td>2</td>
                    <td>Column content</td>
                    <td><a href="applicantList.jsp" class="btn btn-default">신청자 보기 <span class="badge">3</span></a></td>
                    <td><a><img src="../../resources/images/icon-note2.png"></a></td>
                  </tr>
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
    
    <a href="#" class="btn btn-default btn-sm ">메인으로</a>
    
  </div>
  
<%@ include file="../include/footer1.jsp" %>
  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../include/header.jsp" %>
  
  
   <!-- Forms ================================================== -->
   
   <br/><br/><br/>   
      
   <div class="container">
         
      <div class="bs-docs-section">
        
        <div class="row">
          <div class="col-lg-6">
            <div class="well bs-component">
              <form class="form-horizontal">
                <fieldset>
                  <legend>Id 찾기</legend>
                  <h6>이름과 email을 입력해주세요.</h6>
                  <br/>
                   <div class="form-group">
                    <label for="inputEmail" class="col-lg-2 control-label">name</label>
                    <div class="col-lg-10">
                      <input type="text" class="form-control" id="inputEmail" placeholder="이름을 입력하세요">
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="inputEmail" class="col-lg-2 control-label">email</label>
                    <div class="col-lg-10">
                      <input type="text" class="form-control" id="inputEmail" placeholder="email을 입력하세요">
                    </div>
                  </div>
              
                  <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-8">
                      <button type="submit" class="btn btn-primary">찾기</button>
                      <button type="reset" class="btn btn-default">돌아가기</button>
                    </div>
                  </div>
                  
                </fieldset>
              </form>           
            </div>
          </div>
          </div>
          </div>
          
      </div>
      
   </body>
</html>
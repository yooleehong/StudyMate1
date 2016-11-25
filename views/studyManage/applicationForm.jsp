<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header1.jsp" %>
  
  
   <!-- 신청 Forms ================================================== -->
      
   <div class="container">
         
      <div class="bs-docs-section">
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="forms">application form</h1>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-6">
            <div class="well bs-component">
              <form class="form-horizontal">
                <fieldset>
                  <legend>신청서</legend>
                  
                   <div class="form-group">
                    <label for="inputEmail" class="col-lg-2 control-label">name</label>
                    <div class="col-lg-10">
                      <input type="text" class="form-control" id="inputname" value="" readonly >
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="inputEmail" class="col-lg-2 control-label">email</label>
                    <div class="col-lg-10">
                      <input type="text" class="form-control" id="inputEmail" value="" readonly>
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="textArea" class="col-lg-2 control-label">reason</label>
                    <div class="col-lg-10">
                      <textarea class="form-control" rows="3" id="reason" readonly></textarea>
                      <span class="help-block">A longer block of help text that breaks onto a new line and may extend beyond one line.</span>
                    </div>
                  </div>
              
                  <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                      <button type="submit" class="btn btn-default">거절</button>
                      <a href="applicantList.jsp"  class="btn btn-default disabled">Cancel</a>
                      <button type="submit" class="btn btn-primary">수락</button>
                    </div>
                  </div>
                </fieldset>
              </form>
            </div>
          </div>
          </div>
          </div>
          
      </div>
      
<%@ include file="../include/footer1.jsp" %>
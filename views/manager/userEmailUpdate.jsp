<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!--Bootstrap -->
	<link href="http://maxcdn.bootstrapcdn.com/bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" media="screen"> 
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script> 
	   	   <style>
	    div.row{margin-top: 1em;}
		div.container{
		width:300;
		height:200;
		margin-left: 3em;
		} /*화면 크기 와 상단 위치 변경*/

	     </style>
	   
<div class="container">
   
      <div class="bs-docs-section">
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="forms">Email Update</h1>
            </div>
          </div>
        </div>

	<div class="row">
	<div class="col-lg-4 col-lg-offset-1">
	
		<form method="POST" action="userEmailUpdate.do">
			<input type="hidden" name="idx" id="idx" value="${idx}"/>
			<div class="form-group">
			<label>Email</label>
			<input type="text" name="email" id="email" class="form-control" style="height:0.5cm" placeholder="수정할이메일을입력하시오.">
			</div>
			
			<input type="submit" value="이메일 수정" class="btn btn-primary">
		</form>
	</div>
	
	</div>
	</div>

	
	</div>
</body>
</html>
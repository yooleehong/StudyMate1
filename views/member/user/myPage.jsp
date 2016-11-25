<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../include/header1.jsp" %>


<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">

.principal-container {
  background-color:#5bc0de;   
  height:600px;
  width:100% !important;
}

.page-lock .lock-centered {
  position: absolute;
  top: 20%;
  left: 0;
  right: 0;
  margin-top: -65px;
}
@media screen and (min-width: 768px) {
  .page-lock .lock-centered {
   margin-top: -75px; 
  }
}
.page-lock .lock-container {
  position: relative;
  max-width: 420px;
  margin: 0 auto;
}
.page-lock .lock-box {
  position: absolute; 
  left: 0;
  right: 0;
}
.page-lock .lock-box .lock-user {
  background: white;
  width: 50%;
  float: left;
  height: 50px;
  line-height: 50px;
  margin-top: 200px;
  padding: 0 20px;
  -moz-border-radius-topleft: 2px;
  -webkit-border-top-left-radius: 2px;
  border-top-left-radius: 2px;
  -moz-border-radius-bottomleft: 2px;
  -webkit-border-bottom-left-radius: 2px;
  border-bottom-left-radius: 2px;
  color: #1c7ebb;
}
.page-lock .lock-box .lock-img img {
  position: absolute;
  border-radius: 50%;
  left: 40%;
  width: 80px;
  height: 80px;
  border: 6px solid white;
  background: white;
   margin-top: 150px;
}
@media screen and (min-width: 768px) {
  .page-lock .lock-box .lock-img img {
    left: 33%;
    width: 150px;
    height: 150px;
    border: 10px solid white;
  }
}
.page-lock .lock-box .lock-pwd {
  background: white;
  width: 50%;
  float: right;
  height: 50px;
  line-height: 50px;
  padding: 0 0 0 50px; 
  margin-top: 200px; 
  -moz-border-radius-topright: 2px;
  -webkit-border-top-right-radius: 2px;
  border-top-right-radius: 2px;
  -moz-border-radius-bottomright: 2px;
  -webkit-border-bottom-right-radius: 2px;
  border-bottom-right-radius: 2px;
  color: #1c7ebb;  
  padding-left: 20px;
}
@media screen and (min-width: 768px) {
  .page-lock .lock-box .lock-pwd {
    padding: 0 0 0 80px;
  }
}
.page-lock .lock-box .lock-pwd input {
  width: 80%;
  height: 50px;
  color: #555555;
  border: 0;
}
.page-lock .lock-box .lock-pwd .btn-submit {
  position: absolute;
  top: 50%;
  right: 20px;
  margin-top: 75px;
}
.costom{
  padding-left:55px;
}


</style>
</head>
<body>

<div  class="principal-container">
    <div class="container bootstrap snippet">
        <div class="page page-lock ng-scope">
            <div class="lock-centered clearfix">
                <div class="lock-container">
                    <section class="lock-box">
              
                        <div class="lock-user ng-binding">
                        	<a href="mySchedule.do" class="btn-submit">
      							<i class="fa fa-arrow-left"></i>
                            </a>
                            schedule
                        </div>
                        <div class="lock-img"><img src="http://bootdey.com/img/Content/User_for_snippets.png" alt=""></div>
                        <div class="lock-pwd">
                        	<span class="costom">profile</span>
                        	<a href="myInfoModify.do" class="btn-submit">
      							<i class="fa fa-arrow-right"></i>
                            </a>
                        </div>   
                    </section>
                </div>
            </div>
        </div>
    </div>
</div>
</body>






<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../include/header1.jsp" %>

   <div class="container">
   
      <div class="bs-docs-section">
        
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="forms">MyPage</h1>
            </div>
          </div>
        </div>
        
        <div >
        	<a href="mySchedule.do"><img src="/StudyMate/resources/images/icon-calender0.png"></a>
        	<a href="myInfoModify.do"><img src="/StudyMate/resources/images/icon-my0.png"></a>
        </div>
		
      	
      </div>
   
    </div>
  
 <%@ include file="../../include/footer1.jsp" %> --%>
  
  
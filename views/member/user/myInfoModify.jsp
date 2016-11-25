<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../include/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
<style>
.dragAndDropDiv {
	border: 2px dashed #92AAB0;
	width: 100px;
	height: 100px;
	color: #92AAB0;
	text-align: center;
	vertical-align: middle;
	padding: 10px 0px 10px 10px;
	font-size: 200%;
	display: table-cell;
}

.progressBar {
	width: 200px;
	height: 22px;
	border: 1px solid #ddd;
	border-radius: 5px;
	overflow: hidden;
	display: inline-block;
	margin: 0px 10px 5px 5px;
	vertical-align: top;
}

.progressBar div {
	height: 100%;
	color: #fff;
	text-align: right;
	line-height: 22px;
	/* same as #progressBar height if we want text middle aligned */
	width: 0;
	background-color: #0ba1b5;
	border-radius: 3px;
}

.statusbar {
	border-top: 1px solid #A9CCD1;
	min-height: 25px;
	width: 99%;
	padding: 10px 10px 0px 10px;
	vertical-align: top;
}

.statusbar:nth-child(odd) {
	background: #EBEFF0;
}

.filename {
	display: inline-block;
	vertical-align: top;
	width: 250px;
}

.filesize {
	display: inline-block;
	vertical-align: top;
	color: #30693D;
	width: 100px;
	margin-left: 10px;
	margin-right: 5px;
}

.abort {
	background-color: #A8352F;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
	display: inline-block;
	color: #fff;
	font-family: arial;
	font-size: 13px;
	font-weight: normal;
	padding: 4px 15px;
	cursor: pointer;
	vertical-align: top
}
</style>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var objDragAndDrop = $(".dragAndDropDiv");

						$(document).on("dragenter", ".dragAndDropDiv",
								function(e) {
									e.stopPropagation();
									e.preventDefault();
									$(this).css('border', '2px solid #0B85A1');
								});
						$(document).on("dragover", ".dragAndDropDiv",
								function(e) {
									e.stopPropagation();
									e.preventDefault();
								});
						$(document).on("drop", ".dragAndDropDiv", function(e) {

							$(this).css('border', '2px dotted #0B85A1');
							e.preventDefault();
							var files = e.originalEvent.dataTransfer.files;

							handleFileUpload(files, objDragAndDrop);
						});

						$(document).on('dragenter', function(e) {
							e.stopPropagation();
							e.preventDefault();
						});
						$(document).on('dragover', function(e) {
							e.stopPropagation();
							e.preventDefault();
							objDragAndDrop.css('border', '2px dotted #0B85A1');
						});
						$(document).on('drop', function(e) {
							e.stopPropagation();
							e.preventDefault();
						});

						function handleFileUpload(files, obj) {
							for (var i = 0; i < files.length; i++) {
								var fd = new FormData();
								fd.append('file', files[i]);

								var status = new createStatusbar(obj); //Using this we can set progress.
								status.setFileNameSize(files[i].name,
										files[i].size);
								sendFileToServer(fd, status);

							}
						}

						var rowCount = 0;
						function createStatusbar(obj) {

							rowCount++;
							var row = "odd";
							if (rowCount % 2 == 0)
								row = "even";
							this.statusbar = $("<div class='statusbar "+row+"'></div>");
							this.filename = $(
									"<div id='fileName' name='fileName' class='filename'></div>")
									.appendTo(this.statusbar);
							this.size = $(
									"<div id='fileSize' name='fileSize' class='filesize'></div>")
									.appendTo(this.statusbar);
							this.progressBar = $(
									"<div class='progressBar'><div></div></div>")
									.appendTo(this.statusbar);
							this.abort = $("<div class='abort'>중지</div>")
									.appendTo(this.statusbar);

							obj.after(this.statusbar);

							this.setFileNameSize = function(name, size) {
								var sizeStr = "";
								var sizeKB = size / 1024;
								if (parseInt(sizeKB) > 1024) {
									var sizeMB = sizeKB / 1024;
									sizeStr = sizeMB.toFixed(2) + " MB";
								} else {
									sizeStr = sizeKB.toFixed(2) + " KB";
								}

								this.filename.html(name);
								this.size.html(sizeStr);
							}

							this.setProgress = function(progress) {
								var progressBarWidth = progress
										* this.progressBar.width() / 100;
								this.progressBar.find('div').animate({
									width : progressBarWidth
								}, 10).html(progress + "% ");
								if (parseInt(progress) >= 100) {
									this.abort.hide();
								}
							}

							this.setAbort = function(jqxhr) {
								var sb = this.statusbar;
								this.abort.click(function() {
									jqxhr.abort();
									sb.hide();
								});
							}
						}

						function sendFileToServer(formData, status) {
							var uploadURL = "/StudyMate/fileUpdate.do"; //Upload URL
							var extraData = {}; //Extra Data.
							var jqXHR = $
									.ajax({
										xhr : function() {
											var xhrobj = $.ajaxSettings.xhr();
											if (xhrobj.upload) {
												xhrobj.upload
														.addEventListener(
																'progress',
																function(event) {
																	var percent = 0;
																	var position = event.loaded
																			|| event.position;
																	var total = event.total;
																	if (event.lengthComputable) {
																		percent = Math
																				.ceil(position
																						/ total
																						* 100);
																	}
																	//Set progress
																	status
																			.setProgress(percent);

																}, false);
											}
											return xhrobj;
										},
										url : uploadURL,
										type : "POST",
										contentType : false,
										processData : false,
										cache : false,
										data : formData,
										success : function(data) {
											status.setProgress(100);
											$('.dragAndDropDiv').empty();
											$('.dragAndDropDiv')
													.append(
															'<img src="http://kr.seaicons.com/wp-content/uploads/2015/11/success-icon-150x150.png" style=" width:100px; height: 100px;">')
											alert('사진수정완료');

										}
									});

							status.setAbort(jqXHR);
						}

					});
</script>




<div class="container bootstrap snippet">
    <h1 class="text-primary"><span class="glyphicon glyphicon-user"></span>Edit Profile</h1>
      <hr>
	<div class="row">
      <!-- left column -->
      <div class="col-md-3">
        <div class="text-center">
          <h6>Upload a [PNG] photo...</h6>
          <div style="padding-left:70px">
          <div id="fileUpload" name="fileUpload" class="dragAndDropDiv">
				 <c:if test="${ not empty url }">
					<img id="myImage" src="${ url }" width="100px" height="100px">
				</c:if> 
		  </div>
          </div>
          <!-- <img src="//placehold.it/100" class="avatar img-circle" alt="avatar">
          
          <input type="file" class="form-control"> -->
        </div>
      </div>
      
      <!-- edit form column -->
      <div class="col-md-9 personal-info">        
        <h3>Personal info</h3>     
          
        <form:form method="post" modelAttribute="user" class="form-horizontal">
          <form:hidden path="idx" />
          <div class="form-group">
            <label class="col-lg-3 control-label">ID:</label>
            <div class="col-lg-8">
              <form:input path="loginId" readonly="true" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-lg-3 control-label">Name:</label>
            <div class="col-lg-8">
              <form:input path="name" readonly="true" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label for="inputPassword" class="col-lg-3 control-label">password:</label>
            <div class="col-lg-8">
              <form:input path="password" class="form-control"  />
            </div>
          </div>
          <div class="form-group">
            <label class="col-lg-3 control-label">phone number:</label>
            <div class="col-lg-8">
              <form:input path="phoneNumber" class="form-control"  />
            </div>
          </div>
          <div class="form-group">
            <label class="col-lg-3 control-label">Email:</label>
            <div class="col-lg-8">
              <form:input path="email" class="form-control" />
            </div>
          </div>
           <div class="form-group">
            <label class="col-lg-3 control-label"></label>
	          <div class="col-lg-7">
	          <a href="/StudyMate/member/user/unregister.do" >탈퇴하기</a>
	          </div>
          </div>
          <form:hidden path="userType" />
  
          <div class="form-group" style="float:right; padding-right:20px">
          <a href="/StudyMate/member/user/myPage.do" class="btn btn-default">취소</a>
		  <button type="submit" class="btn btn-primary">저장</button>
    	  
		  </div>
        </form:form>
        
        <br/><br/>
         <c:if test="${ not empty error }">
         <div class="alert alert-info alert-dismissable">
	          <a class="panel-close close" data-dismiss="alert">×</a> 
	          <i class="fa fa-coffee"></i>
	          <!-- This is an <strong>.alert</strong>. Use this to show important messages to the user. -->
	         	${ error }
          </div>
		</c:if>
		
		<c:if test="${ not empty success }">
		  <div class="alert alert-info alert-dismissable">
	          <a class="panel-close close" data-dismiss="alert">×</a> 
	          <i class="fa fa-coffee"></i>
	         	${ success }
          </div>
		</c:if>
  
      </div>
      
     
  </div>
  <hr>
</div>

<%@ include file="../../include/footer1.jsp" %>
  
  


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../include/header.jsp" %>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <html>
  <head>
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
        <style>
            .dragAndDropDiv {
                border: 2px dashed #92AAB0;
                width: 100px;
                height: 100px;
                color: #92AAB0;
                text-align: center;
                vertical-align: middle;
                padding: 10px 0px 10px 10px;
                font-size:200%;
                display: table-cell;
            }
            .progressBar {
                width: 200px;
                height: 22px;
                border: 1px solid #ddd;
                border-radius: 5px; 
                overflow: hidden;
                display:inline-block;
                margin:0px 10px 5px 5px;
                vertical-align:top;
            }
              
            .progressBar div {
                height: 100%;
                color: #fff;
                text-align: right;
                line-height: 22px; /* same as #progressBar height if we want text middle aligned */
                width: 0;
                background-color: #0ba1b5; border-radius: 3px; 
            }
            .statusbar{
                border-top:1px solid #A9CCD1;
                min-height:25px;
                width:99%;
                padding:10px 10px 0px 10px;
                vertical-align:top;
            }
            .statusbar:nth-child(odd){
                background:#EBEFF0;
            }
            .filename{
                display:inline-block;
                vertical-align:top;
                width:250px;
            }
            .filesize{
                display:inline-block;
                vertical-align:top;
                color:#30693D;
                width:100px;
                margin-left:10px;
                margin-right:5px;
            }
            .abort{
                background-color:#A8352F;
                -moz-border-radius:4px;
                -webkit-border-radius:4px;
                border-radius:4px;display:inline-block;
                color:#fff;
                font-family:arial;font-size:13px;font-weight:normal;
                padding:4px 15px;
                cursor:pointer;
                vertical-align:top
            }
        </style>
        <script type="text/javascript">
            $(document).ready(function(){
                var objDragAndDrop = $(".dragAndDropDiv");
                 
                $(document).on("dragenter",".dragAndDropDiv",function(e){
                    e.stopPropagation();
                    e.preventDefault();
                    $(this).css('border', '2px solid #0B85A1');
                });
                $(document).on("dragover",".dragAndDropDiv",function(e){
                    e.stopPropagation();
                    e.preventDefault();
                });
                $(document).on("drop",".dragAndDropDiv",function(e){
                     
                    $(this).css('border', '2px dotted #0B85A1');
                    e.preventDefault();
                    var files = e.originalEvent.dataTransfer.files;
                 
                    handleFileUpload(files,objDragAndDrop);
                });
                 
                $(document).on('dragenter', function (e){
                    e.stopPropagation();
                    e.preventDefault();
                });
                $(document).on('dragover', function (e){
                  e.stopPropagation();
                  e.preventDefault();
                  objDragAndDrop.css('border', '2px dotted #0B85A1');
                });
                $(document).on('drop', function (e){
                    e.stopPropagation();
                    e.preventDefault();
                });
                 
                function handleFileUpload(files,obj)
                {
                   for (var i = 0; i < files.length; i++) 
                   {
                        var fd = new FormData();
                        fd.append('file', files[i]);
                  
                        var status = new createStatusbar(obj); //Using this we can set progress.
                        status.setFileNameSize(files[i].name,files[i].size);
                        sendFileToServer(fd,status);
                  	
                   }
                }
                 
                var rowCount=0;
                function createStatusbar(obj){
                         
                    rowCount++;
                    var row="odd";
                    if(rowCount %2 ==0) row ="even";
                    this.statusbar = $("<div class='statusbar "+row+"'></div>");
                    this.filename = $("<div id='fileName' name='fileName' class='filename'></div>").appendTo(this.statusbar);
                    this.size = $("<div id='fileSize' name='fileSize' class='filesize'></div>").appendTo(this.statusbar);
                    this.progressBar = $("<div class='progressBar'><div></div></div>").appendTo(this.statusbar);
                    this.abort = $("<div class='abort'>중지</div>").appendTo(this.statusbar);
                     
                    obj.after(this.statusbar);
                  
                    this.setFileNameSize = function(name,size){
                        var sizeStr="";
                        var sizeKB = size/1024;
                        if(parseInt(sizeKB) > 1024){
                            var sizeMB = sizeKB/1024;
                            sizeStr = sizeMB.toFixed(2)+" MB";
                        }else{
                            sizeStr = sizeKB.toFixed(2)+" KB";
                        }
                  
                        this.filename.html(name);
                        this.size.html(sizeStr);
                    }
                     
                    this.setProgress = function(progress){       
                        var progressBarWidth =progress*this.progressBar.width()/ 100;  
                        this.progressBar.find('div').animate({ width: progressBarWidth }, 10).html(progress + "% ");
                        if(parseInt(progress) >= 100)
                        {
                            this.abort.hide();
                        }
                    }
                     
                    this.setAbort = function(jqxhr){
                        var sb = this.statusbar;
                        this.abort.click(function()
                        {
                            jqxhr.abort();
                            sb.hide();
                        });
                    }
                }
                 
                function sendFileToServer(formData,status)
                {
                    var uploadURL = "/StudyMate/fileUpdate.do"; //Upload URL
                    var extraData ={}; //Extra Data.
                    var jqXHR=$.ajax({
                            xhr: function() {
                            var xhrobj = $.ajaxSettings.xhr();
                            if (xhrobj.upload) {
                                    xhrobj.upload.addEventListener('progress', function(event) {
                                        var percent = 0;
                                        var position = event.loaded || event.position;
                                        var total = event.total;
                                        if (event.lengthComputable) {
                                            percent = Math.ceil(position / total * 100);
                                        }
                                        //Set progress
                                        status.setProgress(percent);
                                  
                                    }, false);
                                }
                            return xhrobj;
                        },
                        url: uploadURL,
                        type: "POST",
                        contentType:false,
                        processData: false,
                        cache: false,
                        data: formData,
                        success: function(data){
                            status.setProgress(100);
                            $('.dragAndDropDiv').empty();
                            $('.dragAndDropDiv').append('<img src="http://kr.seaicons.com/wp-content/uploads/2015/11/success-icon-150x150.png" style=" width:100px; height: 100px;">')          
                            alert('사진수정완료');
                        
                        }
                    }); 
                  
                    status.setAbort(jqXHR);
                }
                 
            });
        </script>
  </head>
  <body>
   <div class="container">
   
      <div class="bs-docs-section">
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="forms">회원 정보 수정</h1>
            </div>
          </div>
        </div>

        <div class="row">
          
          <div class="col-lg-4 col-lg-offset-1">
          [PNG만가능]
          <div id="fileUpload" name="fileUpload" class="dragAndDropDiv">
					<c:if test="${ not empty url }">
					  <img id="myImage" src="${ url }" width="100px" height="100px">
					    </c:if>
				</div>	    
              <form:form method="post" modelAttribute="user" class="bs-component">
               
                 <form:hidden path="idx" />
                 
     			 <div class="form-group">
                  <label class="control-label" for="inputDefault">ID</label>
                  <form:input path="loginId" class="form-control" readonly="true" />
         		 </div>
               
                <div class="form-group">
                  <label class="control-label" for="inputDefault">Name</label>
                  <form:input path="name" class="form-control" readonly="true" />
         		 </div>
                 
 
                 <div class="form-group">
                   <label for="inputPassword" class="control-label">password</label>
                     <form:input path="password" class="form-control" />
                 </div>
              
                <div class="form-group">
                  <label class="control-label" for="inputDefault">phone number</label>
                  <form:input path="phoneNumber" class="form-control"/>
                </div>
                
                <div class="form-group">
                  <label class="control-label" for="inputDefault">email</label>
                  <form:input path="email" class="form-control"  />
                </div>
                
                <form:hidden path="userType" />

		
				
				
				<div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                      <button type="submit" class="btn btn-primary">저장</button>
                      <a href="/StudyMate/member/user/unregister.do" class="btn btn-default">탈퇴하기</a>
                    </div>
                </div>
              </form:form>
              
              <a href="/StudyMate/member/user/myPage.do">돌아가기</a>

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
    </body>
  </html>
<%@ include file="../../include/footer1.jsp" %>
  
   --%>
<%-- <%@ include file="../include/header.jsp" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<head>
<meta charset="utf-8">
<title>StudyMate</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
<link href="http://getbootstrap.com/examples/jumbotron-narrow/jumbotron-narrow.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
<style type="text/css">
.jumbotron label {
	font-size: 12px;
}

.reg-icon {
	color: #5bc0de;
	font-weight: bold;
	text-shadow: 2px 2px 0px rgba(0, 0, 0, 0.4) !important;
}

.nav-pills>li.active>a, .nav-pills>li.active>a:hover, .nav-pills>li.active>a:focus
	{
	color: #fff;
	background-color: #5bc0de;
}

.prj-name {
	font-weight: bold;
	color: #5bc0de;
}

.dragAndDropDiv {
	border: 2px dashed #92AAB0;
	width: 200px;
	height: 200px;
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
							var uploadURL = "/StudyMate/fileUpload.do"; //Upload URL
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
											$(document)
													.mousedown(
															function() {
																$(document)
																		.mousemove(
																				function(
																						e) {
																					return false;
																				});
															});

										}
									});

							status.setAbort(jqXHR);
						}

					});
</script>
</head>


<div class="container bootstrap snippet">
  <div class="header">
    <ul class="nav nav-pills pull-right">
      <li ><a href="http://getbootstrap.com/examples/jumbotron-narrow/#">Home</a></li>
    <!--   <li class="active"><a href="http://getbootstrap.com/examples/jumbotron-narrow/#">Register</a></li> -->
    </ul>
    <h3 class="text-muted prj-name">Study Mate</h3>
  </div>
  <div class="jumbotron text-center" style="min-height:700px;height:auto;">
    <div class="col-md-10 col-md-offset-2">
    		<div class="form-group text-center">
                <div class="col-sm-10 reg-icon">
                    <span class="fa fa-user fa-3x">Register</span>
                </div>
            </div>
    
    	 <div id="fileUpload" name="fileUpload" class="dragAndDropDiv">사진[PNG만가능]</div>
    	
        <form:form method="post" modelAttribute="user" action="join.do" class="form-horizontal" role="form">
            
            <div class="form-group">
                <div class="col-sm-10">
                  <form:input path="loginId" type="text" class="form-control" id="inputDefault" placeholder="ID" />
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-10">
                  <input type="password" class="form-control" id="inputPassword" name="password" placeholder="Password">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-10">
                  <form:input path="name" type="text" class="form-control" id="inputDefault"  placeholder="Username" />
                </div>
              </div>
               <div class="form-group">
                <div class="col-sm-10">
                  <form:input path="phoneNumber" class="form-control" id="inputDefault" placeholder="Phone Number" />
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-10">
                  <form:input path="email" class="form-control" id="inputDefault" placeholder="Email" />
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-10">
                  <button type="submit" class="btn btn-info">
                    <span class="glyphicon glyphicon-share-alt"></span>
                    Register
                  </button>
                </div>
              </div>
        </form:form>
    </div>
  </div>
</div> 
<c:if test="${ not empty error }">
    	<script type='text/javascript'>alert('${ error }');</script>
    </c:if>
</body>
</html>
      


<%-- <%@ include file="../include/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

  <html>
  <head>
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
        <style>
            .dragAndDropDiv {
                border: 2px dashed #92AAB0;
                width: 200px;
                height: 200px;
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
                    var uploadURL = "/StudyMate/fileUpload.do"; //Upload URL
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
                            $(document).mousedown(function(){$(document).mousemove(function(e){return false;});});   
                        
                        }
                    }); 
                  
                    status.setAbort(jqXHR);
                }
                 
            });
        </script>
  </head>
  <body >
      
   <div class="container">
   
      <div class="bs-docs-section">
        <div class="row">
          <div class="col-lg-12">
            <div class="page-header">
              <h1 id="forms">회원가입</h1>
            </div>
          </div>
        </div>

        <div class="row">
          
          <div class="col-lg-4 col-lg-offset-1">

		 <div id="fileUpload" name="fileUpload" class="dragAndDropDiv">사진[PNG만가능]</div>
			<form:form class="bs-component" method="post" modelAttribute="user" action="join.do">
               
                <div class="form-group">
                  <label class="control-label" for="inputDefault">Input ID</label>
                  <form:input path="loginId" class="form-control" id="inputDefault" placeholder="id" />
                </div>
                
                  <div class="form-group">
                    <label for="inputPassword" class="control-label">Input password</label>
                      <input type="password" class="form-control" id="inputPassword" name="password" placeholder="Password">
                  </div>
                
                <div class="form-group">
                  <label class="control-label" for="inputDefault">Input name</label>
                  <form:input path="name" class="form-control" id="inputDefault" />
                </div>
                
                <div class="form-group">
                  <label class="control-label" for="inputDefault">Input phone number</label>
                  <form:input path="phoneNumber" class="form-control" id="inputDefault" />
                </div>
                
                <div class="form-group">
                  <label class="control-label" for="inputDefault">Input email</label>
                  <form:input path="email" class="form-control" id="inputDefault" />
                </div>
                

				 <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                    <button type="button" class="btn btn-default" onclick="location.href='/StudyMate/fileUploadCancel.do';">Cancel</button>
                      <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                  </div>

			</form:form>
          </div>
        </div>
      </div>
   
    </div>
  	<c:if test="${ not empty error }">
    	<script type='text/javascript'>alert('${ error }');</script>
    </c:if>
 </body>
</html>
  
   --%>
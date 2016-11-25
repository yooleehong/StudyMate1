<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="board.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


 <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
    	
body{
    margin-top:20px;
    background-color: #ecf0f5;
}
.box-widget {
    border: none;
    position: relative;
}
.box {
    position: relative;
    border-radius: 3px;
    background: #ffffff;
    border-top: 3px solid #d2d6de;
    margin-bottom: 20px;
    width: 100%;
    box-shadow: 0 1px 1px rgba(0,0,0,0.1);
}
.box-header.with-border {
    border-bottom: 1px solid #f4f4f4;
}
.box-header {
    color: #444;
    display: block;
    padding: 10px;
    position: relative;
}
.user-block img {
    width: 40px;
    height: 40px;
    float: left;
}
.user-block .username {
    font-size: 16px;
    font-weight: 600;
}
.user-block .description {
    color: #999;
    font-size: 13px;
}
.user-block .username, 
.user-block .description, 
.user-block .comment {
    display: block;
    margin-left: 50px;
}
.box-header>.box-tools {
    position: absolute;
    right: 10px;
    top: 5px;
}
.btn-box-tool {
    padding: 5px;
    font-size: 12px;
    background: transparent;
    color: #97a0b3;
}
.box-body {
    border-top-left-radius: 0;
    border-top-right-radius: 0;
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
    padding: 10px;
}
.pad {
    padding: 10px;
}
.box .btn-default {
    background-color: #f4f4f4;
    color: #444;
    border-color: #ddd;
}
.box-comments {
    background: #f7f7f7 !important;
}
.box-footer {
    border-top-left-radius: 0;
    border-top-right-radius: 0;
    border-bottom-right-radius: 3px;
    border-bottom-left-radius: 3px;
    border-top: 1px solid #f4f4f4;
    padding: 10px;
    background-color: #fff;
}
.box-comments .box-comment:first-of-type {
    padding-top: 0;
}
.box-comments .box-comment {
    padding: 8px 0;
    border-bottom: 1px solid #eee;
}
.img-sm, 
.box-comments .box-comment img, 
.user-block.user-block-sm img {
    width: 30px !important;
    height: 30px !important;
}
.img-sm, .img-md, 
.img-lg, .box-comments .box-comment img, 
.user-block.user-block-sm img {
    float: left;
}
.box-comments .comment-text {
    margin-left: 40px;
    color: #555;
}
.box-comments .username {
    color: #444;
    display: block;
    font-weight: 600;
}
.notbold{
    font-weight: 400;
    font-size: 12px;
}
.box-comments .text-muted {
    font-weight: 400;
    font-size: 12px;
}
.img-sm+.img-push {
    margin-left: 40px;
}
.box .form-control {
    border-radius: 0;
    box-shadow: none;
    border-color: #d2d6de;
}

ul{
	list-style-type: none;
	padding: 0;
}

.comments2{
	list-style-type: none;
	padding: 0;
	margin-left: 15px;
}
/*************pagination***********/
.gallery-bottom .pagination {
  margin-top: 0px;
}

.pagination > li > a, .pagination > li > span {
  background-color: #ccc;
  padding: 3px 9px;
  color: #fff;
  border: 0px;
}

.pagination > li > a {
  margin-right: 5px;
}

.pagination > .active > a, .pagination > .active > span, .pagination > .active > a:hover, .pagination > .active > span:hover, .pagination > .active > a:focus, .pagination > .active > span:focus {
  background-color: #32c5d2;
}
</style>


<script>


//쿼리스트링 가져오기위함.
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

//studyGroup별 BoardIdx
var gboardIdx = getParameterByName('boardIdx');



/* 댓글 등록 함수 ->ok (날짜 형식 변환은 string형식의 날짜를 date형식으로 바꾼 후 사용 가능하다.) */	
function commentAdd(){
	var div = "";

    var commentInput = $("#commentInput").val(); 
    var boardIdx = $("#boardIdx").val();
   
	$.ajax({
		url : "/StudyMate/studyRoom/board/boardRead/insertComment.do",
        data : encodeURI("commentInput="+commentInput+"&boardIdx="+boardIdx),
        dataType : "json",
        success : function(data){
          var newComment = $("#newComment");
          var commentIdx = data.commentIdx;
          //alert("성공"+commentIdx);
          $("#commentInput").val(""); //비워주기 
          
          /* div += "<div id='commentItem"+commentIdx+"'>";
          div += data.USERID+"<br/>";
          div += "<div id='updateItem"+commentIdx+"'>"+commentInput+"</div>";
          div += "<div id='updateItemTime"+commentIdx+"'>"+data.WRITETIME+"</div>";
          div += "<a href='javascript:commentUpdate("+commentIdx+");'>수정</a>";
          div += "<a href='javascript:commentDelete("+commentIdx+");'>삭제</a>";
          div += "<a href='javascript:replyForm("+commentIdx+");'>답글</a>";
          div += "<br/></div>";
          div += "<br/><div id='replyItem"+commentIdx+"'></div>";
          div += "<div id='newReply"+commentIdx+"'></div>"; */
          
          div += "<br/><div id='commentItem"+commentIdx+"' class='box-comment'>";
          div += "<img class='img-circle img-sm' src='http://bootdey.com/img/Content/avatar/avatar2.png' alt='User Image'>";
          div += "<div class='comment-text'>";
          div += "<span class='username'>";
          div += data.USERID;
          div += "<span id='updateItemTime"+commentIdx+"' class='notbold'>";
          div += "&nbsp;&nbsp;"+data.WRITETIME+"</span>";
          div += "<span class='notbold'> &nbsp; <a href='javascript:replyForm("+commentIdx+");'>reply</a></span>";
          div += "<span class='text-muted pull-right'>";
          div += "<a href='javascript:commentUpdate("+commentIdx+");'>수정&nbsp;</a>";
          div += "<a href='javascript:commentDelete("+commentIdx+");'>삭제</a></span></span>";
          div += "<div id='updateItem"+commentIdx+"'>"+commentInput+"</div>";
          div += "<div id='replyItem"+commentIdx+"'></div>";
          div += "<div id='newReply"+commentIdx+"'></div>";
          div += "</div></div>";
          
         //newComment.append("<div class='navbar navbar-default' style='display:inline'> <div class='col-md-12'>");
          newComment.append(div);
        },
		error : function(request) {	
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); //에러 발생 이유 알려줌.
		}
	});
}

/* 댓글 삭제 함수 -> ok */
function commentDelete(commentIdx){
	
	//경고창 띄워주기. 삭제하시겠습니까? 확인/취소.

	$.ajax({
		url : "/StudyMate/studyRoom/board/boardRead/deleteComment.do",
		data : encodeURI("commentIdx="+commentIdx),		
		dataType : "text",
		 success : function(data){
			$("#commentItem"+commentIdx).html("");
		 	$("#comment"+commentIdx).html("");
		 },
		 error : function(request){
			 alert("error");
		 }
	});
}

/* 댓글 수정 함수  -> ok*/
function commentUpdate(commentIdx){
	
	var div = "";
	var commentInput = "updateComment";
	
	/* div +=  "<div class='row'><div class='col-md-5'><input type='text' id='updateCommentInput' class='form-control border-input'></div>";
	div += "<a href='javascript:commentUpdateExcute("+commentIdx+");' class='btn btn-info btn-fill'>등록</a>"; */
	//div += "<a href='javascript:click{history.back();}'>취소</a></div>"
	$.ajax({
		url : "/StudyMate/studyRoom/board/boardRead/selectContents.do",
		data : encodeURI("commentIdx="+commentIdx),
		dataType : "text", 
		success : function(data){
			decodeURIComponent(data);
			
			div += "<div class='box-footer' style='display: block;'>";
			div += "<form action='javascript:commentUpdateExcute("+commentIdx+");'>";
			div += "<img class='img-responsive img-circle img-sm' src='http://bootdey.com/img/Content/avatar/avatar1.png' alt='Alt Text'>";
			div += "<div class='img-push'>";
			div += "<input type='text' id='updateCommentInput' class='form-control input-sm' placeholder='Press enter to post comment' value='"+data+"'>";
			div += "</div></form></div> ";			
			
			//댓글내용 자리에 수정폼 append.
			$("#updateItem"+commentIdx).html("");
			$("#updateItem"+commentIdx).append(div);
		},
	    error : function(request){
			alert("error");
		}
	});
		
		

}
/* 댓글 수정 함수  -> ok*/
function commentUpdateExcute(commentIdx){
	
	var commentInput = $("#updateCommentInput").val(); 
	
	$.ajax({
		url : "/StudyMate/studyRoom/board/boardRead/updateComment.do",
		data : encodeURI("commentInput="+commentInput+"&commentIdx="+commentIdx),
		dataType : "text", 
		success : function(data){
			$("#updateItem"+commentIdx).html(commentInput);
			$("#updateItemTime"+commentIdx).html(data);
		},
	    error : function(request){
			alert("error");
		}
	});
}



/* 답글(대댓) 폼 -> ok*/
function replyForm(commentIdx){
	
	var div = "";
	
/* 	div +=  "<br/><div class='row'><div class='col-md-5'><input type='text' id='replyInput' class='form-control border-input'></div>";
	div += "<a href='javascript:replyAdd("+commentIdx+");' class='btn btn-info btn-fill'>등록</a></div>";
	 */
	div += "<div class='box-footer' style='display: block;'>";
	div += "<form action='javascript:replyAdd("+commentIdx+");'>";
	div += "<img class='img-responsive img-circle img-sm' src='http://bootdey.com/img/Content/avatar/avatar1.png' alt='Alt Text'>";
	div += "<div class='img-push'>";
	div += "<input type='text' id='replyInput"+commentIdx+"' class='form-control input-sm' placeholder='Press enter to post comment'>";
	div += "</div></form></div> ";	
	
	$("#replyItem"+commentIdx).html("");
	$("#replyItem"+commentIdx).append(div);
}
/* 답글(대댓) 등록 -> ok*/
function replyAdd(commentIdx){
	
	var replyInput = $("#replyInput"+commentIdx).val();
	var div = "";
	

	$.ajax({
		url : "/StudyMate/studyRoom/board/boardRead/insertReply.do",
		data : encodeURI("replyInput="+replyInput+"&commentIdx="+commentIdx+"&boardIdx="+gboardIdx),
		dataType : "json", 
		success : function(data){
			var replyIdx = data.REPLYIDX;
			
			$("#replyItem"+commentIdx).html("");
	          
	      /*   div += "<div id='newReplyItem"+replyIdx+"'>";
	        div += data.USERID+"<br/>";
	        div += "<div id='newReplyContent"+replyIdx+"'>"+replyInput+"</div>";
	        div += "<div id='newReplyTime"+replyIdx+"'>"+data.WRITETIME+"</div>";
	        div += "&nbsp;&nbsp;<a href='javascript:replyUpdate("+replyIdx+");'>수정</a>";
	        div += "&nbsp;&nbsp;<a href='javascript:replyDelete("+replyIdx+");'>삭제</a></br></br></div>"; */
	       
        	div += "<br/><li id='newReplyItem"+replyIdx+"' class='clearfix'>";
	        div += "<img class='img-circle img-sm' src='http://www.gadgettrader.sg/img/icon/reply_icon.png'>";
	        div += "<div class='box-comment'>";
	        div += "<img class='img-circle img-sm' src='http://bootdey.com/img/Content/avatar/avatar3.png' alt='User Image'>"
	        div += "<div class='comment-text'>";
	        div += "<span class='username'>";
	        div += data.USERID;
	        div += "<span id='newReplyTime"+replyIdx+"' class='notbold'>";
	        div += "&nbsp;&nbsp;"+data.WRITETIME+"</span>";
	        div += "<span class='text-muted pull-right'>";
	        div += "<a href='javascript:replyUpdate("+replyIdx+");'>수정&nbsp;</a>";
	        div += "<a href='javascript:replyDelete("+replyIdx+");'>삭제</a></span></span>";
	        div += "<div id='newReplyContent"+replyIdx+"'>"+replyInput+"</div></div></div></li>";
	        div += "<div id='newReply"+replyIdx+"'></div>";
	        	
	        $("#newReply"+commentIdx).append(div); 
		},
	    error : function(request){
			alert("error");
		}
	});
}
/* 답글(대댓) 삭제 함수 -> ok */
function replyDelete(replyIdx){
	
	$.ajax({
		url : "/StudyMate/studyRoom/board/boardRead/deleteReply.do",
		data : encodeURI("replyIdx="+replyIdx),
		dataType : "text",
		 success : function(data){
			 $("#newReplyItem"+replyIdx).remove();
		 },
		 error : function(request){
			 alert("error");
		 }
	});
}
/* 답글(대댓) 수정 폼 -> ok*/
function replyUpdate(replyIdx){
	
	var div = "";
	
	//$("#updateCommentInput").toggle(); 
	
	/* div +=  "<div class='row'><div class='col-md-5'><input type='text' id='updateCommentInput"+replyIdx+"' class='form-control border-input'></div>";
	div += "<a href='javascript:replyUpdateExcute("+replyIdx+");' class='btn btn-info btn-fill'>등록</a></div>"; */
	
	
	$.ajax({
		url : "/StudyMate/studyRoom/board/boardRead/selectReplyContents.do",
		data : encodeURI("replyIdx="+replyIdx),		
		dataType : "text",
		success : function(data){
			//alert("성공"+decodeURIComponent(data));
			decodeURIComponent(data);
			 
			div += "<br/><div class='box-footer' style='display: block;'>";
			div += "<form action='javascript:replyUpdateExcute("+replyIdx+");'>";
			div += "<img class='img-responsive img-circle img-sm' src='http://bootdey.com/img/Content/avatar/avatar1.png' alt='Alt Text'>";
			div += "<div class='img-push'>";
			div += "<input type='text' id='updateCommentInput"+replyIdx+"' class='form-control input-sm' placeholder='Press enter to post comment' value='"+data+"'>";
			div += "</div></form></div> ";
			
			
			//댓글내용 자리에 수정폼 append. (취소버튼 추가하기)
			$("#newReplyContent"+replyIdx).html("");
			$("#newReplyContent"+replyIdx).append(div);				

		 },
		 error : function(request){
			 alert("error");
		 }
	});
	

}
/* 답글(대댓) 수정 함수 -> ok*/
function replyUpdateExcute(replyIdx){
	
	
	var commentInput = $("#updateCommentInput"+replyIdx).val(); 
	
	$.ajax({
		url : "/StudyMate/studyRoom/board/boardRead/updateReply.do",
		data : encodeURI("commentInput="+commentInput+"&replyIdx="+replyIdx),
		dataType : "text", 
		success : function(data){
			$("#newReplyContent"+replyIdx).html(commentInput);
			$("#newReplyTime"+replyIdx).html(data);
		},
	    error : function(request){
			alert("error");
		}
	});
}





</script>
<div  style="background-color:#ffffff">
<br/>
<div class="container bootstrap snippet">
<div class="col-md-12">
  <div class="box box-widget">
    
    <!-- 글열람 from -->
    <form >
    <input type="hidden" class="form-control border-input" name="idx" value="${idx}">
    <div class="box-header with-border">
      <div class="user-block">
        <img class="img-circle" src="http://bootdey.com/img/Content/avatar/avatar1.png" alt="User Image">
        <span class="username"><a href="#">${boardTitle}</a></span>  <!-- 현재 페이지로 refresh 되는 링크 걸기 -->
        <span class="description">Shared publicly - 7:30 PM Today</span>
      </div>
      <div class="box-tools">
        <button type="button" class="btn btn-box-tool" data-toggle="tooltip" title="" data-original-title="Mark as read">
        <i class="fa fa-circle-o"></i></button>
        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
        </button>
        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
      </div>
    </div>

    <div class="box-body" style="display: block;">
     <!--  <img class="img-responsive pad" src="http://lorempixel.com/600/300/nature/4/" alt="Photo"> -->
      <p>${boardCotents}</p>
      <!-- <button type="button" class="btn btn-default btn-xs"><i class="fa fa-share"></i> Share</button>
      <button type="button" class="btn btn-default btn-xs"><i class="fa fa-thumbs-o-up"></i> Like</button>
      <span class="pull-right text-muted">127 likes - 3 comments</span> -->
    </div>
    
    </form>
    
    <!-- 댓글 form -->   
    <div class="box-footer box-comments" style="display: block;"> 
	    <ul id="commentAll" class="comments">	    
		    <c:forEach var="Comment" items="${commentList}">
				    <!-- 댓글1 -->
				    <li id="comment<c:out value="${Comment.idx}"/>" class="clearfix">
				    <br/>
				      <div id="commentItem<c:out value="${Comment.idx}"/>" class="box-comment" >
				        <img class="img-circle img-sm" src="http://bootdey.com/img/Content/avatar/avatar2.png" alt="User Image">
				        <div class="comment-text">
				                 <span class="username">
				          	       ${Comment.userId}
						           <span id="updateItemTime<c:out value="${Comment.idx}"/>" class="notbold">&nbsp;&nbsp;<fmt:formatDate type="both" value="${Comment.writeTime}" /></span> 
						           <span  class="notbold"> &nbsp; <a href="javascript:replyForm(${Comment.idx});">reply</a></span>
							          <c:if test="${loginUserIdx eq Comment.userIdx}">
								          <span class="text-muted pull-right"> 
								          	<a href="javascript:commentUpdate(${Comment.idx});">수정&nbsp;</a>
								          	<a href="javascript:commentDelete(${Comment.idx});">삭제</a> 
								          </span>
							          </c:if>
						        </span>
						        <div id="updateItem<c:out value="${Comment.idx}"/>">${Comment.commentContents}</div>
						       
						        <!-- 대댓입력폼 채워지는 곳-->
								<div id="replyItem<c:out value="${Comment.idx}"/>"></div>
								
				         </div>
				       </div> <!-- 댓글1 감쌈 -->
				      
				      	<!-- 대댓칸 -->
				        <ul id="newReply<c:out value="${Comment.idx}"/>" class="comments2">
				        	<c:forEach var="ReplyComment" items="${replyList}">
					        	<c:if test="${Comment.idx eq ReplyComment.commentIdx}">	
					        	<!-- 대댓1 -->
						        <li id="newReplyItem<c:out value="${ReplyComment.idx}"/>" class="clearfix">
						        	  <br/>
						        	  <img class="img-circle img-sm" src="http://www.gadgettrader.sg/img/icon/reply_icon.png" > 
								      <div class="box-comment">
								        <img class="img-circle img-sm" src="http://bootdey.com/img/Content/avatar/avatar3.png" alt="User Image">
								        <div class="comment-text">
								          <span class="username">
									          ${ReplyComment.userId}
									          <span id="newReplyTime<c:out value="${ReplyComment.idx}"/>" class="notbold">&nbsp;&nbsp;<fmt:formatDate type="both" value="${ReplyComment.writeTime}"/></span>
									          <c:if test="${loginUserIdx eq ReplyComment.userIdx}">
									          <span class="text-muted pull-right"> 
									          	<a href="javascript:replyUpdate(${ReplyComment.idx});">수정&nbsp;</a>
												<a href="javascript:replyDelete(${ReplyComment.idx});">삭제</a>
												</span>
									          </c:if>
								          </span>
								          <div id="newReplyContent<c:out value="${ReplyComment.idx}"/>">${ReplyComment.commentContents}</div>
								        </div>
								      </div>
							      </li> <!-- 대댓1끝 -->
							      </c:if>
						      </c:forEach>
					      </ul> <!-- 대댓들끝 -->
				      </li> <!-- 댓글1끝  댓글1과 대댓들 감쌈-->
		     </c:forEach>
		     
		     
		     <!-- ajax 비동기 요청 방식으로 새로 입력한 댓글이 채워지는 부분     지금ui형식으로 바꿔야함!-->	
			<li class="clearfix">
				<div id=newComment>
				</div>
			</li>
			    
	    </ul> <!-- 댓글들끝 -->
	    
	     <!-- pagination -->
<div class="row">
	<div class="col-lg-4">
		<div class="bs-component">
			<ul class="pagination">
				<c:forEach var="page" items="${ pages }">
	                <li class='${ page.active }'><a
						href="/StudyMate/studyRoom/board/boardRead.do?idx=${studyGroupIdx}&boardIdx=${boardIdx}&pg=${ page.number }">${ page.label }</a></li>
	            </c:forEach>
			</ul>
		</div>
	</div> 
	</div>
	    
	    <!--======== 페이지네이션 =========-->
				<%-- <div class="row col-xs-offset-3">
					<div class="col-lg-4">
						<div class="bs-component">
							<ul class="pagination pagination-sm">
								<c:forEach var="page" items="${ pages }">
									<li class='${ page.active }'><a
										href="/StudyMate/studyRoom/board/boardRead.do?idx=${studyGroupIdx}&boardIdx=${boardIdx}&pg=${ page.number }">${ page.label }</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div> --%>
				
			 
	   
    </div>
   
    
    <!-- 댓글 입력창 -->
    <div class="box-footer" style="display: block;">
      <form action="javascript:commentAdd();">
        <img class="img-responsive img-circle img-sm" src="http://bootdey.com/img/Content/avatar/avatar1.png" alt="Alt Text">
        <div class="img-push">
          <input type="text" name="commentInput" id="commentInput" class="form-control input-sm" placeholder="Press enter to post comment">
          <input type="hidden" name="boardIdx" id="boardIdx" value="${boardIdx}">
<!--  <a class="btn btn-info btn-fill" href="javascript:commentAdd();">등록</a> -->
        </div>        
      </form>
    </div>
    
  </div>
</div>
	<div style="float:right; padding-right:20px">
		<a href="boardModify.do?studyGroupIdx=${studyGroupIdx}&boardIdx=${boardIdx}" class="btn btn-primary">수정</a>
		<a href="boardDelete.do?studyGroupIdx=${studyGroupIdx}&boardIdx=${boardIdx}" class="btn btn-primary">삭제</a>
		<a href="/StudyMate/studyRoom/board/boardList.do?idx=${studyGroupIdx}" class="btn btn-primary">목록</a>
		<br/>
		<br/>
	</div>
	
    
</div>
</div>


<%@ include file="../../include/footer2.jsp"%>



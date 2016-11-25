<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../studyRoom/board/board.jsp"%>

	   <script>
	     $(function() {
  	
	    	 $("a[data-url]").click(function() { //[10월17일 수정]
	    		 location.href = $(this).attr("data-url");
  
	   			  });
	    	 
	     });
	     
	     </script>
	   <style>
	    thead tr { background: #eee; } 
	    tbody tr:hover { background-color: #ffa; cursor: pointer; } 
	    div.form-inline { margin-bottom: 5px; }
	    div.row{margin-top: 3em;}
	    div.page-header{margin-left: 3em;}
	    /*[수정]스타일 변경*/
	    
	    /*탭 스타일*/
	    .input.a{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff; height:19px;}
		.textarea{color:#ffffff; font-size: 9pt; background-color:#000000;background:; border:solid 1 #ffffff;}
		div.enter{margin-top: 3em;}
		
		img.button{width: 30px; height: 30px;}
	     </style>

	<div class="row">
 

 <div class="col-md-8">
	
	
   <div class="container" style="margin-left: 9%;">
   			
   			<div class="enter"></div>


		
		 <div  id='mediaspace' >없음</div>
			<script type='text/javascript' >
			  jwplayer('mediaspace').setup({
			    'flashplayer': '../resources/streaming/player.swf',
			    'file': '${stream.fileName}',
			    'streamer': 'rtmp://localhost/oflaDemo',
			    'controlbar': 'bottom',
			    'width': '960',
			    'height': '500',
			    'repeat': 'always',
			    'image' : '${streamRoute}',
			    'autostart' : 'true',
			    'stretching' : 'exactfit'
    
			  });
			</script>
		<div style="background-color: white; width: 980px; height: 232px;">
			<div style="margin-top: 10px;"></div>
			<h1 style="margin-top: 40; line-height:200%;">&nbsp;&nbsp;${stream.title}</h1>
	
				<div class="row">
				
					<div class="col-md-9">
					<h3>&nbsp;&nbsp;${stream.contents}</h3>	
					<hr style="margin-bottom: 6px;">		
						<button class="btn" onclick=" location.href ='/StudyMate/streaming/StreamBoard.do?idx=${stream.studyGroupIdx}&${ pagination.queryString }'"><img class="button" src="../resources/images/back.png"> 돌아가기</button> <!-- [수정] 위로이동 -->
						<!-- <button class="btn"><img class="button" src="../resources/images/down.png"> 다운받기</button>구현해야함 -->
						<c:set var="Authority" value="${Authority}"/> 
						<c:if test="${'yes' eq Authority}">
							<button class="btn" onclick="location.href ='/StudyMate/streaming/StreamDelete.do?idx=${stream.idx}&${ pagination.queryString }'"><img class="button" src="../resources/images/delete.png"> 삭제</button>
						</c:if>
					</div><!-- 그리드10 -->
					
					<!--   <div class="col-md-0.9">
					 	 <h2 style="color: gray;  margin-top: 1; margin-bottom: 1px;">조회수23425회</h2>
								<br>
						 <button class="btn" style="margin-right: 2cm;"><img class="button" src="../resources/images/like.png"></button>
					</div>그리드2 -->
					
				</div><!-- 그리드 시스템 10/2  -->
			</div>
		
				
			
				<br>
  				 
  			 
  			  </div>
		<hr>
		
		</div><!--부트스트랩 8 -->

	  <div class="col-md-4">
	  <div class="enter"></div>
		  <div style="background-color: white; width: 400px; height: 809px; margin-bottom: 30px">
 
		<c:forEach var="streamList" items="${streamList}" begin="2" end="6">
			<c:set var="nowStreamIdx" value="${stream.idx}" />
			<c:set var="StreamIdx" value="${streamList.idx}" />
				<c:choose>
				
				<c:when test="${nowStreamIdx eq StreamIdx && !empty streamList && '2' eq streamList}">
				
				${streamList-1}
					
				</c:when>
				
				<c:otherwise>
						  
						
			
							<div class="row" style=" margin-top: 0.1px;">
								
			
								<div class="col-md-6">
						<c:set var="none" value="true"/>
							<c:forEach var="streamImageList" items="${streamImageList}">
								<c:set var="streamIdx" value="${streamList.idx}" />
								<c:set var="ImageIdx" value="${ streamImageList.streamIdx }" />
									
										<c:if test="${streamIdx eq ImageIdx}">
											<img src="/StudyMate/StreamImage/${streamImageList.fileName}"class="img-responsive" alt="" style=" width: 280px; height: 143px; margin-top: 5px; margin-left: 35px; padding-top: 11px;">
											<img src="../resources/images/border.PNG" class="img-responsive" alt="" style=" width: 280px; height: 10px; margin-left: 35px;">
										<c:set var="none" value="false"/> 
										</c:if>
										<c:if test="${streamIdx ne ImageIdx}">	
										</c:if>	
								
							</c:forEach>
							<c:if test="${none}">
										<img src="../resources/images/streamMain.PNG" class="img-responsive" alt="" style=" width: 280px; height: 143px; margin-top: 5px; margin-left: 35px; padding-top: 11px;">
										<img src="../resources/images/border.PNG" class="img-responsive" alt="" style=" width: 280px; height: 10px; margin-left: 35px;">
							</c:if>
								</div>
			<a data-url="StreamDetails.do?idx=${streamList.idx}&${ pagination.queryString }" class="portfolio-link" data-toggle="modal" style="width: 230px; height: 170px; margin-left: 70px">
								<div class="col-md-6" style=" margin-top: 12px;">
									<h5 style="margin-top: 12px; margin-left: 30px;">${streamList.title}<br>
										<span style="color: gray;">${streamList.userName}</span>
									</h5>
								</div>
				</a>
			
							</div>

				
				</c:otherwise>
				
				</c:choose>
		
		</c:forEach> 
		
	 		 </div>

	</div>
</div>

<%@ include file="../include/footer2.jsp"%>
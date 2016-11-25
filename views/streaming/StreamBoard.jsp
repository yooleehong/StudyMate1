<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../studyRoom/board/board.jsp"%>

	   <style>
	    thead tr { background: #eee; } 
	    tbody tr:hover { background-color: #ffa; cursor: pointer; } 
	    div.form-inline { margin-bottom: 5px; }
	    div.row{margin-top: 3em;}
	    div.page-header{margin-left: 3em;}
	    h5.text{width: 140px; height: 70px; border: 0; color: navy; line-height: 20px; margin-left: 80px; margin-bottom: 1px;} /*[10월 17일 추가] 텍스트 박스 수정 */
	   div.enter{margin-top: 3em;}
	   a:hover{
			cursor: pointer;
		}
	     </style>
	     
	   <script>
	     $(function() {

	    	 $("a[data-url]").click(function() { //[10월17일 수정]
	    		 location.href = $(this).attr("data-url");
					 });
	    	 
	    	 
	    	 $("ul.pagination a").click(function() {
	    	        $("input[name=pg]").val($(this).attr("data-page"));
	    	        $("form").submit();
	    	    });

	     }); 
	     
	 
	     
	     </script>
	
		<div class="row" style="margin-top: 9%; margin-left: 13%;">

        
		<form:form method="get" modelAttribute="pagination">
		 <input type="hidden" name="pg" value="1" />
		 <input type="hidden" name="idx" value=${ pagination.idx } />
		  <div class="form-inline">
		   <form:select path="ss">
		    <form:option value="0" label="검색조건" /> <!-- [10월 6일 수정] 검색변경-->
		     <form:option value="1" label="ID" /> 
		    <form:option value="2" label="NAME" />
		    <form:option value="3" label="Title" />
		       </form:select> 
		       
		       <form:input path="st" /> 
		       <button type="submit" class="btn btn-small">검색</button> 
		       </div>

		         <section id="portfolio" style="background-color: white; width:1200px; height: 690px; margin-top: 10px; ">
		            <div class="row" style="margin-top: 1px; ">
		            <c:forEach var="board" items="${list}">
		                <div class="col-sm-3 portfolio-item" style="width: 270px; height: 240px; ">
		                         <center>
		                    <a data-url="StreamDetails.do?idx=${board.idx}&${ pagination.queryString }" class="portfolio-link" data-toggle="modal" style="width: 230px; height: 170px; margin-left: 70px">
		                   
		                        <div class="caption" style="background-color: pink; height: 165px;">
		                            <div class="caption-content" >
		                     			          ▶동영상 재생
		                            </div>
		                        </div>
		                        <c:set var="none" value="true"/>
							<c:forEach var="stream" items="${streamLists}">
							
		                     		<c:set var="streamIdx" value="${stream.streamIdx}" />
									<c:set var="boardIdx" value="${ board.idx }" />
									<c:if test="${streamIdx eq boardIdx}">
									<img src="/StudyMate/StreamImage/${stream.fileName}" class="img-responsive" alt="" style="width: 400px; height: 155px;">
									<img src="../resources/images/border.PNG" class="img-responsive" alt="" style="width: 400px; height: 10px;">
									<c:set var="none" value="false"/> 
									</c:if>
										<c:if test="${streamIdx ne boardIdx}">
				                      	
				                      	</c:if>	
			                      	

		                       </c:forEach> 
		                       <c:if test="${none}">
					    		<img src="../resources/images/streamMain.PNG"class="img-responsive" alt="" style="width: 400px; height: 155px;">
								<img src="../resources/images/border.PNG" class="img-responsive" alt="" style="width: 400px; height: 10px;">
										
					    		</c:if>	
		                    </a>
		                        </center>
		                       
		                    
		                        <h5 class="text" style="margin-top: 5px; margin-bottom: 5px;" >${ board.title }<br><span style="color:gray;">${ board.name }</span></h5>
		                        
		                      
		                    	
		                </div>
		            </c:forEach>
		            </div>
		        
		    </section>
		     
		     
		     
		     
		     <center> <!-- [10월14일 수정]페이지 네이션 가운데 정렬 -->
		     <div>
				<ul class="pagination pagination-small pagination-centered"> 
		     	 <c:forEach var="page" items="${ pagination.pageList }">
			       <li class='${ page.cssClass }'>
			       <a data-page="${ page.number }">
			       ${ page.label }</a>
			       </li>
		       	 </c:forEach>
				</ul>
			 </div>
		 </center>
		 
		 </form:form>

  				 <button class="btn" onclick=" location.href ='/StudyMate/streaming/upload.do?idx=${idx}&${ pagination.queryString }'">동영상업로드</button> <!--업로드 페이지로 --> 			 
</div>
<%@ include file="../include/footer2.jsp"%>
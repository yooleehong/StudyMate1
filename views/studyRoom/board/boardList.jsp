<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="board.jsp"%>

<script>
$(function() {
    $("tr[data-url]").click(function() {
        location.href = $(this).attr("data-url");
    });

    $("ul.pagination a").click(function() {
        $("input[name=pg]").val($(this).attr("data-page"));
        $("form").submit();
    });

    $("[data-auto-submit=true]").change(function() {
        $(this).parents("form").submit();
    });

});

</script> 
<style type="text/css">

.click:hover {
	background-color:#ffa;
	cursor: pointer;
}
  a:hover{
			cursor: pointer;
		}

</style>

	<!-- [10월 6일 수정]제목 삭제 -->

<form:form method="get" modelAttribute="pagination">
<input type="hidden" name="pg" value="1" />
 <input type="hidden" name="idx" value=${ pagination.idx } />
	<div class="container-fluid">
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<h4 class="title">자유게시판</h4>
						<p class="category">자유자유자유</p>
					</div>

										<!--========= 검색폼 ============-->

							<div class="form-inline" style="margin-bottom: 0.5px; margin-top: 10px; margin-left: 3px;">
						<form:select path="ss">
						    <form:option value="0" label="검색조건" /> <!-- [10월 6일 수정] 검색변경-->
						    <form:option value="1" label="Title" />
						     <form:option value="2" label="name" /> 
						       </form:select>
						       <form:input path="st"  placeholder="검색어를 입력하시오." /> 
		       <button type="submit" class="btn btn-primary" style="margin-top: 3px">검색</button>
		       </div>
							
						



					<a href="boardWrite.do?idx=${idx}"
						style="float: right; margin-right: 10px"
						class="btn btn-info btn-fill">글쓰기</a>

					<div class="content table-responsive table-full-width">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>No.</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="studygroupboard" items="${list}">
									<tr class="click" data-url="boardRead.do?boardIdx=${studygroupboard.idx}&idx=${idx}&${ pagination.queryString }"><!-- [10월14일 수정]수정 -->
										<td>${studygroupboard.idx}</td>
										<td>${studygroupboard.boardTitle}</td>
										<td>${studygroupboard.name}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${studygroupboard.writeTime}" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					<center>
					
					
							<ul class="pagination pagination-small pagination-centered">
								<c:forEach var="page" items="${ pagination.pageList }">
									<li class='${ page.cssClass }'>
									<a data-page="${ page.number }">
								 ${ page.label }</a></li>
								</c:forEach>
							</ul>
					
					</center>
					</div>

					
				</div>


			</div>


			
	
</div>



</form:form>



<%@ include file="../../include/footer2.jsp"%>



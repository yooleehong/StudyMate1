<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/header1.jsp"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
.click:hover {
	background-color: #ffa;
	cursor: pointer;
}
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script>
$(function() {
    $("tr[data-url]").click(function() {
        location.href = $(this).attr("data-url");
    });

    $("div.pagination a").click(function() {
        $("input[name=pg]").val($(this).attr("data-page"));
        $("form").submit();
    });

    $("[data-auto-submit=true]").change(function() {
        $(this).parents("form").submit();
    });

});

</script>


<div class="container">

	<!-- 스터디 리스트 Table ================================================== -->

	<div class="bs-docs-section">

		<div class="row">
			<div class="col-lg-12">
				<div class="page-header">
					<br />
					<h2 id="tables">승인 대기중인 Study List</h2>
					<br />
					
					
				</div>
			</div>
		</div>

		<form:form method="get">
			<!-- <input type="hidden" name="pg" value="1" /> -->
			<div class="bs-component">

				<%-- <form:select path="ss">
					<form:option value="0" label="전체보기" />
					<form:option value="1" label="스터디 이름 검색" />
					<form:option value="2" label="스터디 소개글 검색" />
					<form:option value="3" label="스터디 목표 검색" />
				</form:select>
				<form:input path="st" />
				<button type="submit" class="btn btn-small" style="height: 30px">검색</button>
				<c:if test="${ pagination.ss != 0 }">
					<a href="studyList.do" class="btn btn-small">취소</a>
				</c:if>
				<form:select path="od" data-auto-submit="true">
					<form:option value="0" label="생성 순서" />
					<form:option value="1" label="스터디 이름 순서" />
				</form:select>

				<form:select path="sz" data-auto-submit="true">
					<form:option value="10" />
					<form:option value="15" />
					<form:option value="30" />
					<form:option value="50" />
				</form:select> --%>
				<table class="table table-striped table-hover ">
					<thead>
						<tr>
							<th>스터디 이름</th>
							<th>신청 사유</th>
							<th>승인 여부</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="applicant" items="${list}">
							<!-- <tr data-url="/StudyMate/studyMain/applicationForm.do?idx=${studyGroup.idx}"> -->
								<tr>
								<td>${applicant.studyGroupName}</td>
								<td>${applicant.reason}</td>
								<td>승인 대기중</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>

			<!-- pagination -->
			<div class="pagination pagination-small pagination-centered">
				<ul>
					<c:forEach var="page" items="${ pages }">
						<li class='${ page.active }'><a
							href="/StudyMate/studyMain/studyList.do?pg=${ page.number }">${ page.label }</a></li>
					</c:forEach>
				</ul>
			</div>

		</form:form>
	</div>
</div>


<!-- 승인대기중 스터디 리스트 Table ================================================== -->

<%-- <div class="bs-docs-section">

		<div class="row">
			<div class="col-lg-12">
				<div class="page-header">
					<h3 id="tables">승인 대기중 . . .</h3>
				</div>


				<div class="bs-component">
					<table class="table table-striped table-hover ">

						<thead>
							<tr>
								<th>No.</th>
								<th>조장</th>
								<th>스터디 소개</th>
								<th>활동 기간</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${standByList}" var="StudyGroup">
								<tr class="click" onclick="goDetail(${StudyGroup.idx});">
									<td>${StudyGroup.idx}</td>
									<td>${StudyGroup.leaderId}</td>
									<td>${StudyGroup.studyGroupName}</td>
									<td>${StudyGroup.studyGroupIntro}</td>
									<td>${StudyGroup.studyGroupTerm}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div> --%>


<%@ include file="../include/footer1.jsp"%>

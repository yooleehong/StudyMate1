<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ include file="../include/header1.jsp"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script>
function createClick(){

	 document.getElementById('createform').submit();

}
</script>
<!-- Forms ================================================== -->
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close" aria-hidden="true">×</button>
    <h3 class="smaller lighter blue no-margin modal-title">스터디 만들기</h3>
</div>
<div class="modal-body">
<div class="container">

	<div class="bs-docs-section">
	
		<div class="row">
			<div class="col-lg-6">
				<div class="well bs-component">
					<form:form id="createform" class="form-horizontal" method="post" modelAttribute="studyGroup"  enctype="multipart/form-data">
						<fieldset>
							<!-- <legend>스터디 만들기</legend> -->

							<!-- 아이디값을 받아서 파라미터값으로 넘겨줌(studycontroller에 study createpost로 넘겨줌) -->
							<div class="form-group">
								<div class="col-lg-10">
									<form:input type="hidden" path="leaderIdx" value="${leader.idx}" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail" class="col-lg-2 control-label">스터디명</label>
								<div class="col-lg-10">
									<form:input type="text" class="form-control" path="studyGroupName"
										placeholder="study name" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail" class="col-lg-2 control-label">소개</label>
								<div class="col-lg-10">
									<form:input type="text" class="form-control" path="studyGroupIntro"
										placeholder="study intro" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail" class="col-lg-2 control-label">기간</label>
								<div class="col-lg-10">
									<form:input type="text" class="form-control"
										 path="studyGroupTerm"
										placeholder="study term" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputEmail" class="col-lg-2 control-label">정원</label>
								<div class="col-lg-10">
									<form:input type="text" class="form-control" path="maxCounter"
										 placeholder="max count" />
								</div>
							</div>

							<div class="form-group">
								<label for="textArea" class="col-lg-2 control-label">목표</label>
								<div class="col-lg-10">
									<form:input type="text" class="form-control" rows="3" path="studyGroupGoal" />
								</div>
							</div>

							<div class="form-group">
								<label for="textArea" class="col-lg-2 control-label">내용</label>
								<div class="col-lg-10">
									<form:input class="form-control" rows="3" path="studyGroupContents" />
									<span class="help-block">스터디 활동내역이나 기타 사항을 입력해주세요.</span>
								</div>
							</div>
							
							<div class="form-group">
								<label for="textArea" class="col-lg-2 control-label">이미지</label>
								<div class="col-lg-10">
									<input type="file" name="file">		
								</div>
							</div>
						

						</fieldset>
					</form:form>
				</div>
			</div>
		</div>
	</div>

</div>
<c:if test="${ not empty error }">
<div class="alert alert-info alert-dismissable">
	          <a class="panel-close close" data-dismiss="alert">×</a> 
	          <i class="fa fa-coffee"></i>
	         	${ error }
</div>
	<!-- <script type='text/javascript'>alert('${ error }');</script> -->
</c:if>


</div>

<div class="modal-footer">
	<a href="javascript:createClick()" class="btn btn-sm btn-warning" id="testSave">
        저장<i class="cace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
    </a>
    <button class="btn btn-sm btn-danger pull-right" data-dismiss="modal" id="btnClose">
        <i class="ace-icon fa fa-times"></i>닫기
    </button>
</div>


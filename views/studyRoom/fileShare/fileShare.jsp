<%@ include file="../../include/header2.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


            <ul class="nav">
                <li>
                    <a href="schedule.jsp">
                        <i class="ti-calendar"></i>
                        <p>일정관리</p>
                    </a>
                </li>
                <li>
                    <a href="/StudyMate/studyRoom/fileShare/fileUpload.do?idx=${idx}">
                        <i class="ti-cloud-up"></i>
                        <p>자료공유</p>
                    </a>
                </li>
                <li class="active">
                    <a href="/StudyMate/studyRoom/board/boardList.do?idx=${idx}">
                        <i class="ti-view-list-alt"></i>
                        <p>게시판</p>
                    </a>
                </li>
                <li>
                    <a href="/StudyMate/studyRoom/document/document.do">
                        <i class="ti-text"></i>
                        <p>동시문서작성</p>
                    </a>
                </li>
                <li>
                    <a href="locate.jsp">
                        <i class="ti-map"></i>
                        <p>약속장소정하기</p>
                    </a>
                </li>

            </ul>
    	</div>
    </div>
    
  <div class="main-panel">
  
  
    <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">파일 공유</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-home"></i>
								<p>Home</p>
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="ti-bell"></i>
                                    <p class="notification">5</p>
									<p>MyPage</p>
									<b class="caret"></b>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="#">Notification 1</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                              </ul>
                        </li>
						<li>
                            <a href="#">
								<i class="ti-settings"></i>
								<p>Help</p>
                            </a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>
        
        <div class="content">
        
        </div>

<%@ include file="../../include/footer2.jsp" %>
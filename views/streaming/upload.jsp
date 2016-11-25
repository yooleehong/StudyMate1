<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../studyRoom/board/board.jsp"%>

    <style type="text/css">
    div.enter{
    	margin-top: 10em;
    
    }
    
    </style>
    <script>
    $(function() {
    	
	    $(document).keydown(function(e){   
	        if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){       
	            if(e.keyCode === 8){   
	            return false;
	            }
	        }
	    });  //키보드뒤로가기 막기
 
    window.history.forward(0);  
    
    });
    history.pushState(null, null, location.href); 
    window.onpopstate = function(event) { 
    history.go(1); 
    }//마우스뒤로가기 막기
    </script>


	<div class="container">
	<center>
  <form id="frm" name="frm" method="POST" action="/StudyMate/streaming/upload.do" enctype="multipart/form-data" >
 
        <table class="board_view">
            <colgroup>
                <col width="15%">
                <col width="*"/>
            </colgroup>
            <div class="enter"></div>
            <caption>게시글 작성</caption>
            <tbody>
                <tr>
                    <th scope="row">제목</th>
                    <td><input type="text" id="title" name="title" class="wdp_90"></input></td>
                </tr>
                <tr>
                    <td colspan="2" class="view_text">
                        <textarea rows="20" cols="100" title="내용" id="contents" name="contents"></textarea>
                    </td>
                </tr>
            </tbody>
        </table>
        <div style="margin-bottom: 3%;"></div>
        <input type="file" name="file">
        
        <br/><br/>
         
        <input type="submit" class="btn" id="write" value="작성하기">
        <a href="/StudyMate/streaming/StreamBoard.do?&${ pagination.queryString }" class="btn" id="list">게시판으로</a>
    </form>
    </center> 

    
    </div>
  	

<%@ include file="../include/footer2.jsp"%>
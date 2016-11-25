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


	<div class="container" style="margin-top: 9%;">
	<center>
    <form id="frm" name="frm" method="POST" action="/StudyMate/streaming/uploadNext.do" enctype="multipart/form-data" >
 		<input type="hidden" id="fileName" name="fileName" value="${stream.fileName}"/> 
		<input type="hidden" id="idx" name="idx" value="${stream.idx}"/>
		<input type="hidden" id="title" name="title" value="${stream.title}"/>
		
        <input type="file" name="file">
        
        <br/><br/>
         <div style="margin-bottom: 300;"></div>
        <input type="submit" class="btn" id="write" value="완료">
       
    </form>
     
</center>
    
    </div>
  	

<%@ include file="../include/footer2.jsp"%>
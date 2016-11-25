<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <head>
    <script type='text/javascript' src='../../resources/streaming/jwplayer.js'></script>
        <style type="text/css" media="screen">
            html, body, #containerA, #containerB { height:100%; }
            body { margin:0; padding:0; overflow:hidden; }
        </style>
        <title>웹캠설정</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <script type="text/javascript" src="../../resources/streaming/swfobject.js"></script>
        <script type="text/javascript">
        
        var flashvars = {};
        var params = {allowfullscreen: "true"};
        var attributes = {};
        attributes.id = "simpleSOChat";
        attributes.name = "simpleSOChat";
        attributes.align = "middle";
        swfobject.embedSWF("../../resources/streaming/publisher.swf", "myContent", "70%", "70%", "9.0.0", "../../resources/streaming/expressInstall.swf", flashvars, params, attributes);
       
		</script>


    </head>
    <body>
        <div id="myContent">
            <h1>Adobe Flash Player(X)</h1>
        </div>
      <hr />
      <p>server 탭 클릭 -> localhost 대신 접속한 ip주소 적고 connection 클릭</p><br/>
      <p>video 탭 클릭 -> dvice 선택 후 start</p><br/>
      <p>name에 title 입력후 (모르면 url참고) -> publish 클릭 </p><br/>
      
<!--       <div id='mediaspace'>없음</div>
			<script type='text/javascript' >
			  jwplayer('mediaspace').setup({
			    'flashplayer': '../resources/streaming/player.swf',
			    'file': 'dbfl1324',
			    'streamer': 'rtmp://localhost/oflaDemo',
			    'controlbar': 'bottom',
			    'width': '600',
			    'height': '360',
			    'repeat': 'always'
			  });
			</script> -->		
      
        
    </body>
</html>
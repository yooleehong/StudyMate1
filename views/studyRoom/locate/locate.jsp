<%-- <%@ include file="../../include/header2.jsp" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="/StudyMate/resources/bootstrap2/assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/StudyMate/resources/bootstrap2/assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Study Room</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <!-- Bootstrap core CSS     -->
    <link href="/StudyMate/resources/bootstrap2/assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="/StudyMate/resources/bootstrap2/assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="/StudyMate/resources/bootstrap2/assets/css/paper-dashboard.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="/StudyMate/resources/bootstrap2/assets/css/demo.css" rel="stylesheet" />

    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="/StudyMate/resources/bootstrap2/assets/css/themify-icons.css" rel="stylesheet">

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=704bb6d2-81dc-3bef-a8a0-3bc6bca8eab8"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script type="text/javascript">
//채팅창을 팝업창으로 띄워줌.
	function popUpChat(){
		var idx = ${studyGroupIdx};
		var popUrl = "/StudyMate/studyRoom/board/tempChat.do?idx="+idx;
		var popOption = "width=400, height=500, resizable=yes, menubar=no, directories=no, location=no"
		
		window.open(popUrl,"",popOption);
	}
</script>


<style>
.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap {position:relative;width:100%;height:350px;}
#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
#category li.on {background: #eee;}
#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
#category li:last-child{margin-right:0;border-right:0;}
#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
#category li .category_bg {background:url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
#category li .bank {background-position: -10px 0;}
#category li .mart {background-position: -10px -36px;}
#category li .pharmacy {background-position: -10px -72px;}
#category li .oil {background-position: -10px -108px;}
#category li .cafe {background-position: -10px -144px;}
#category li .store {background-position: -10px -180px;}
#category li.on .category_bg {background-position-x:-46px;}
.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>


</head>

<!-- 1018추가 -->
<script type="text/javascript">
//채팅창을 팝업창으로 띄워줌.
	function popUpChat(){
		var idx = ${idx};
		var popUrl = "/StudyMate/studyRoom/board/tempChat.do?idx="+idx;
		var popOption = "width=400, height=500, resizable=yes, menubar=no, directories=no, location=no"
		
		window.open(popUrl,"",popOption);
	}
</script>

<body>

<div class="wrapper">

	<div class="sidebar" data-background-color="white" data-active-color="danger">

    <!--
		Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
		Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
	-->

    	<div class="sidebar-wrapper">
            <div class="logo">
                <div class="simple-text">${GroupName}</div>
                        <br/>
                <img src="${route}" style="width:70%; height:auto;"><br/>
                     
            </div>
            <ul class="nav">
                <li>
                    <a href="/StudyMate/studyRoom/schedule/schedule.do?idx=${idx}">
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
                    <a href="/StudyMate/studyRoom/document/document.do?idx=${idx}">
                        <i class="ti-text"></i>
                        <p>동시문서작성</p>
                    </a>
                </li>
                <li>
                    <a href="/StudyMate/studyRoom/locate/locate.do?idx=${idx}"> <!-- [10월2일추가] -->
                        <i class="ti-map"></i>
                        <p>주변 검색</p>
                    </a>
                </li>
                 <li>
                    <a href="/StudyMate/streaming/StreamBoard.do?idx=${idx}">
                        <i class="fa fa-caret-square-o-right" aria-hidden="true"></i>
                        <p>동영상 공유</p>
                    </a>
                </li>
                 <li>
                    <a href="/StudyMate/streaming/webcam/board.do?idx=${idx}"><!-- [10월1일수정] -->
                        <i class="glyphicon glyphicon-facetime-video" aria-hidden="true"></i>
                        <p>WEBCAM ROOM</p>
                    </a>
                </li>
                
               
			 	<li>
			 		<a href="javascript:popUpChat();">
			 			<i class="fa fa-comments-o"></i>
			 			<p>채팅</p>
			 		</a>
			 	</li>
            </ul>
       </div>
    </div>
    
  <div class="main-panel" >
 
      <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">게시판</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-home"></i>
                        <p>Home</p>
                            </a>
                        </li>
                         <c:set var="leader" value="${leader}"/>
                        <c:if test="${'yes' eq leader}">
                        <li>
                            <a href="/StudyMate/studyManage/applicantListForLeader.do?idx=${idx}">
                                <i class="fa fa-bullhorn"></i>
                        		<p>신청자보기</p>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="fa fa-bug"></i>
                        		<p>스터디그룹 삭제</p>
                            </a>
                        </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
        
<div class="content">

<div>
	<input type="text" id="searchText" name="searchText" placeholder="현재 위치를 입력하세요">
	<input type="button" value="검색" onclick="javascript:test()">
	<input type="button" value="현위치" onclick="javascript:myPoint()">
</div>
<br/>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <ul id="category">
        <li id="CT1" data-order="0"> 
            <span class="category_bg bank"></span>
            은행
        </li>       
        <li id="MT1" data-order="1"> 
            <span class="category_bg mart"></span>
            마트
        </li>  
        <li id="PM9" data-order="2"> 
            <span class="category_bg pharmacy"></span>
            약국
        </li>  
        <li id="OL7" data-order="3"> 
            <span class="category_bg oil"></span>
            주유소
        </li>  
        <li id="CE7" data-order="4"> 
            <span class="category_bg cafe"></span>
            카페
        </li>  
        <li id="CS2" data-order="5"> 
            <span class="category_bg store"></span>
            편의점
        </li>      
    </ul>
</div>

<ul id="placesList"></ul>


			
			
</div>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=a0413377db77e2ed72b537c66432a721&libraries=services"></script>
<script>
// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
var placeOverlay = new daum.maps.CustomOverlay({zIndex:1}), 
    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
    markers = [], // 마커를 담을 배열입니다
    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
 
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };      
    
// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 
//장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places(map);

//검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});




//현재 위치 추적
function myPoint(){
	
	geoLocation();

	function geoLocation()
	{
		if(navigator.geolocation)
		{
			navigator.geolocation.getCurrentPosition(showPosition,showError);
		}
		else
		{
			alert("다른 브라우저를 이용해주세요");
		}
	}
	
	var nLat;
	var nLng;
	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	//위치 추적 success
	function showPosition(position)
	{
		nLat = position.coords.latitude;
		nLng = position.coords.longitude;
		
		map_initialize(nLat,nLng);
		
	}
		
	//위치 추적 fail
	function showError(error)
	{
		//에러별로 처리 추가해주기.
		alert("위치추적fail"+error.code);
	}
	
	function map_initialize( myLat, myLng ){
		var position = new daum.maps.LatLng(myLat, myLng);
		
		//추적된 현재위치 좌표->지번주소로 변환
		geocoder.coord2detailaddr(position, a);
		
	};
	
	function a(status, result){
		//input 박스에 들어갈 현재 위치 주소값
		var myPointString =  result[0].jibunAddress.name;	
		document.getElementsByName('searchText')[0].value= myPointString ;
		//이 주소로 검색.
		test();	
	}
	
}



//지도 중심 이동 , 카테고리별 검색
function test(){
	
	var searchText = document.getElementsByName('searchText')[0].value;
	
	ps.keywordSearch(searchText, placesSearchCB); //입력한 키워드로 검색
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수
	function placesSearchCB (status, data, pagination) {
		
		if (status === daum.maps.services.Status.OK) {
			 displayMarker(data.places[0]);		 
		}
	}
	
	 function displayMarker(place) {
		test2(place.latitude, place.longitude);
	}
}

function test2(myLat, myLng){
	
	//지도 중심 좌표 변경
    mapOption = {
        center: new daum.maps.LatLng(myLat, myLng), // 지도의 중심좌표  => 변경됨.
        level: 5 // 지도의 확대 레벨
    }; 
    map = new daum.maps.Map(mapContainer, mapOption);
    
    ps = new daum.maps.services.Places(map);
    
	DrawHumanMaker(myLat, myLng);
	
	DrawCircle(myLat, myLng, 600);
	    
	// 지도에 idle 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'idle', searchPlaces);
	
	// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
	contentNode.className = 'placeinfo_wrap';
	
	// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
	// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 daum.maps.event.preventMap 메소드를 등록합니다 
	addEventHandle(contentNode, 'mousedown', daum.maps.event.preventMap);
	addEventHandle(contentNode, 'touchstart', daum.maps.event.preventMap);
	
	// 커스텀 오버레이 컨텐츠를 설정합니다
	placeOverlay.setContent(contentNode);  
	
	// 각 카테고리에 클릭 이벤트를 등록합니다
	addCategoryClickEvent();
	
	// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
	function addEventHandle(target, type, callback) {
	    if (target.addEventListener) {
	        target.addEventListener(type, callback);
	    } else {
	        target.attachEvent('on' + type, callback);
	    }
	}
	
	// 카테고리 검색을 요청하는 함수입니다
	function searchPlaces() {
	    if (!currCategory) {
	        return;
	    }
	    
	    // 커스텀 오버레이를 숨깁니다 
	    placeOverlay.setMap(null);
	
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    //검색.
	    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB( status, data, pagination ) {
	    if (status === daum.maps.services.Status.OK) {
	        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
	        displayPlaces(data.places);
	    } else if (status === daum.maps.services.Status.ZERO_RESULT) {
	        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
	
	    } else if (status === daum.maps.services.Status.ERROR) {
	        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
	        
	    }
	}
	 
	// 지도에 마커를 표출하는 함수입니다 , 검색 결과도 나오게 하자.
	function displayPlaces(places) {
	
	    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
	    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
	    var order = document.getElementById(currCategory).getAttribute('data-order');
	
	    
	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new daum.maps.LatLngBounds(), 
	    listStr = '';
	    
	    //검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
	
	            // 마커를 생성하고 지도에 표시합니다
	            var marker = addMarker(new daum.maps.LatLng(places[i].latitude, places[i].longitude), order);
	            itemEl = getListItem(i, places[i], marker); // 검색 결과 항목 Element를 생성합니다
	            
	            // 마커와 검색결과 항목을 클릭 했을 때 (마커의 클릭이벤트 등록)
	            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
	            (function(marker, place) {
	                daum.maps.event.addListener(marker, 'click', function() {
	                    displayPlaceInfo(place);
	                });
	                
	                daum.maps.event.addListener(marker, 'mouseover', function() {
	                    displayInfowindow(marker, title);
	                });
	                
	                daum.maps.event.addListener(marker, 'mouseout', function() {
	                    infowindow.close();
	                });

	                itemEl.onmouseover =  function () {
	                    displayInfowindow(marker, title);
	                };

	                itemEl.onmouseout =  function () {
	                    infowindow.close();
	                };
	                
	            })(marker, places[i]);
	            
	            fragment.appendChild(itemEl);
	    }
	    
	 // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	}	
	
	// 검색결과 항목을 Element로 반환하는 함수입니다. 목록출력.
	function getListItem(index, places) {

	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.title + '</h5>';

	    if (places.newAddress) {
	        itemStr += '    <span>' + places.newAddress + '</span>' +
	                    '   <span class="jibun gray">' +  places.address  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item';

	    return el;
	}
	
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다. 카테고리 클릭했을 때 마커 뜨게함.
	function addMarker(position, order) {
		
	 	    var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new daum.maps.Size(27, 28),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new daum.maps.Size(72, 208), // 스프라이트 이미지의 크기
	            spriteOrigin : new daum.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new daum.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new daum.maps.Marker({
	            position: position, // 마커의 위치 
	            image: markerImage 
	        });
	
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	    return marker;
	} 
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}
	
	// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
	function displayPlaceInfo (place) {
	   //클릭하면 이동할 url => 길찾기로 바꾸자.
	   alert(place.id);
	   
/* 	    var content = '<div class="placeinfo">' +
        '   <a class="title" href="' + place.placeUrl + '" target="_blank" title="' + place.title + '">' + place.title + '</a>'; */
		 var content = '<div class="placeinfo">' +
	                    '   <a class="title" href="http://map.daum.net/link/to/'+place.id +'" target="_blank"  title="' + place.title + '">' + place.title + '</a>';   
	 
	    if (place.newAddress) {
	        content += '    <span title="' + place.newAddress + '">' + place.newAddress + '</span>' +
	                    '  <span class="jibun" title="' + place.address + '">(지번 : ' + place.address + ')</span>';
	    }  else {
	        content += '    <span title="' + place.address + '">' + place.address + '</span>';
	    }                
	   
	    content += '    <span class="tel">' + place.phone + '</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';
	
	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new daum.maps.LatLng(place.latitude, place.longitude));
	    placeOverlay.setMap(map);  
	}
	
	
	// 각 카테고리에 클릭 이벤트를 등록합니다
	function addCategoryClickEvent() {
	    var category = document.getElementById('category'),
	        children = category.children;
	
	    for (var i=0; i<children.length; i++) {
	        children[i].onclick = onClickCategory;
	    }
	}
	
	// 카테고리를 클릭했을 때 호출되는 함수입니다
	function onClickCategory() {
	    var id = this.id,
	        className = this.className;
	
	    placeOverlay.setMap(null);
	
	    if (className === 'on') {
	        currCategory = '';
	        changeCategoryClass();
	        removeMarker();
	    } else {
	        currCategory = id;
	        changeCategoryClass(this);
	        searchPlaces();
	    }
	}
	
	 // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
	function changeCategoryClass(el) {
	    var category = document.getElementById('category'),
	        children = category.children,
	        i;
	
	    for ( i=0; i<children.length; i++ ) {
	        children[i].className = '';
	    }
	
	    if (el) {
	        el.className = 'on';
	    } 
	} 
	 
	 // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}
	 
	function DrawHumanMaker(lat,lng){
		
		var imageSrc = "http://www.cottagesalonspa.com/img/location-icon.png",
			imageSize = new daum.maps.Size(32, 37),
			imageOption = {offset: new daum.maps.Point(16,37)};
		
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
			markerPosition = new daum.maps.LatLng(lat,lng);
		
		var poiDaumMarker = new daum.maps.Marker({
			position: markerPosition,
			image: markerImage
		});
		
		poiDaumMarker.setMap(map);
		

	}

	var circle;
	var circleList=[];

	function DrawCircle(lat, lng, radius){
		
		circle = new daum.maps.Circle({
			center: new daum.maps.LatLng(lat, lng),
			radius: radius, //미터 단위의 원의 반지름
			strokeWeight: 5, //선의 두께
			strokeColor: '#75B8FA',
			strokeOpacity: 1,
			strokeStyle: 'dashed',
			fillColor: '#CFE7FF',
			fillOpacity: 0.3
		});
		
		circle.setMap(map);
		
	}
} 
</script>

<%@ include file="../../include/footer2.jsp" %>







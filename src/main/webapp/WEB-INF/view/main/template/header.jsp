<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.MemberServiceImp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 카카오로그아웃  -->
<script src='https://developers.kakao.com/sdk/js/kakao.min.js'></script>

<!-- 네이버로그아웃 -->
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="css/log.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
	$(document).ready(function() {
		$('#nologin').on('click', function() {
			alert('NANALAND 회원에게만 제공되는 서비스입니다.');
			location.href = "memberloginform.do";
		});

		$('#knlogin').on('click', function() {
			alert('NANALAND의 회원만 사용 가능한 서비스입니다.');
			return false;
		});

		$('#noCartlogin').on('click', function() {
			alert('NANALAND의 회원만 사용 가능한 서비스입니다.');
			return false;
		});

		$('#knCartlogin').on('click', function() {
			alert('NANALAND의 회원만 사용 가능한 서비스입니다.');
			return false;
		});
	});
</script>
<title>header.jsp</title>

<style type="text/css">
#header_wrap {
	border-bottom: 1px solid #ccc;
}

#header_topMenu {
	width: 100%;
	height: 50px;
	line-height: 50px;
	background-color: #1f1f2e;
	color: white;
}

#header_topMenu p {
	display: inline;
	margin-left: 4%;
	font-size: small;
}

.topMenu {
	text-decoration: none;
	color: white;
	padding-right: 10px;
	font-size: small;
}

.topMenu:hover {
	text-decoration: none;
	color: #ff3333;
}

/*------------------------------------*/
#header_mainMenu {
	width: 100%;
	height: 110px;
	line-height: 110px;
	background-color: white;
}

#main_logo_box {
	width: 15%;
	float: left;
	/* margin-left : 3%; */
}

#main_logo_box #main_logo {
	/* width : 200px;
   height : 50px;
   size: 100%;
   padding-top:27.5px;
   margin-left: 5%;
   margin-right: 15%; */
	display: inline-block;
}

#mainMenu_box {
	width: 33%;
	float: left;
	margin-left: 20%;
}

#mainMenu_box .mainMenu {
	text-decoration: none;
	color: black;
	padding-right: 20px;
	/* margin-top : 40px; */
	font-size: medium;
	font-weight: normal;
}

#mainMenu_box .mainMenu:hover {
	text-decoration: none;
	color: #ff3333;
}

#btn_box {
	width: 20%;
	float: left;
	margin-right: 10%
}

#shop_basket, #open_chatting {
	/* width : 75px;
   height: 75px;
   padding-top : 15px;
   padding-right : 20px;
   size : 100%; */
	display: inline-block;
	float: right;
}

#open_chatting {
	margin-right: 5%;
}
</style>



</head>
<body>
	<div id="header_wrap">
		<div id="header_topMenu">
			<p>오늘 주문하시면 내일부터 취미 배송이 시작됩니다.</p>
			<div id="topMenuBox"
				style="display: inline-block; float: right; margin-right: 6%">
				<%
					//nana홈페이지 로그인
					Object mem_id = session.getAttribute("mem_id");
					//카카오 로그인시 정보 가져옴
					Object kemail = session.getAttribute("kemail");
					//네이버 로그인시 정보 가져옴
					Object nemail = session.getAttribute("nemail");
				%>

				<%
					if (mem_id == null && kemail == null && nemail == null) {
				%>
				<a href="memberloginform.do" class="topMenu" id="login">로그인</a> 
				<a href="memberjoinform.do" class="topMenu" id="memberjoin">회원가입</a>
				<%
					} else if (mem_id != null) {
				%>
				<a href="memberlogoutform.do" class="topMenu" id="logout">로그아웃</a>
				
				<!-- 관리자는 마이페이지 권한x -->
				<c:set var="nanaland" value="nanaland" />
				<c:if test="${sessionScope.mem_id != nanaland}">
				<a href="mypage.do" class="topMenu">마이페이지</a>
				</c:if>
				<%
					} else if (nemail != null) {//네이버
				%>
				<a href="#" class="topMenu" id="logout">${nname}님 환영합니다.</a> 
				<a href="nmypage.do" class="topMenu">마이페이지</a> 
				<a href="memberlogoutform.do" class="topMenu">로그아웃</a>
				<%
					} else if (kemail != null) {//카카오
				%>
				<a href="#" class="topMenu" id="logout">${kname}님 환영합니다.</a> 
				<a href="kmypage.do" class="topMenu">마이페이지</a> 
				<a href="memberlogoutform.do" class="topMenu" id="logout">로그아웃</a>
				<%
					}
				%>
				<a href="list.do" class="topMenu">NaNa 게시판</a>
				<!-- 관리자 페이지 권한 -->
				<c:set var="nanaland" value="nanaland" />
				<c:if test="${sessionScope.mem_id == nanaland}">
					<a href="marketing.do" class="topMenu">관리자 페이지</a>
				</c:if>
				<!-- end 관리자 페이지 권한 -->
			</div>
		</div>

		<div id="header_mainMenu">
			<div id="main_logo_box" style="display: inline-block; float: left;">
				<a href="nanaland.do"><img id="main_logo"
					src="./images/main_logo9.png" alt="로고" /></a>
			</div>
			<div id="mainMenu_box" style="display: inline-block;">
				<a href="discStart.do" class="mainMenu">취미 분석 테스트</a> <a
					href="shoppingMain.do" class="mainMenu">취미 쇼핑하기</a> <a
					href="nanaInfo.do" class="mainMenu">나나랜드 소개</a>
			</div>
			<div id="btn_box"
				style="display: inline-block; float: right; margin-right: 6%">

				<!-- 오픈채팅 로그인 권한 -->
				<%
					if (mem_id == null && nemail == null && kemail == null) {
				%>
				<a href="#" id="nologin"> <input type="image" id="open_chatting"
					src="./images/open_chatting10.png" alt="오픈채팅" /></a>
				<%
					} else {
				%>
				<a href="openchat.do"> <input type="image" id="open_chatting"
					src="./images/open_chatting10.png" alt="오픈채팅" /></a>
				<%
					}
				%>
				<!-- end 오픈채팅 로그인 권한 -->


				<!-- 취미바구니 권한 -->
				<%
					if (mem_id == null && nemail == null && kemail == null) {
				%>
				<a href="#" id="noCartlogin"><input type="image"
					id="shop_basket" src="./images/shop_basket10.png" alt="장바구니" /></a>
				<%
					} else if (mem_id != null) {
				%>
				<a href="shoppingCart.do"><input type="image" id="shop_basket"
					src="./images/shop_basket10.png" alt="장바구니" /></a>
				<%
					} else {
				%>
				<a href="#" id="knCartlogin"><input type="image"
					id="shop_basket" src="./images/shop_basket10.png" alt="장바구니" /></a>
				<%
					}
				%>
				<!--  end 취미바구니 권한 -->
			</div>
		</div>
	</div>

</body>
</html>